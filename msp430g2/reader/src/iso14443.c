//==============================================================================
/*! \file     iso14443.c
    \brief    Functions to work with the iso14443 protocol
    \author   Andrew Parlane
*/
//==============================================================================

#include "iso14443.h"
#include "trf7970a.h"
#include "time.h"
#include "uart.h"

#include <stdint.h>
#include <string.h>
#include <stdbool.h>

// CRC calculation code based on Annex B of ISO/IEC 14443-3
static uint16_t computeCrc(const uint8_t *data, uint8_t len)
{
    uint16_t crc = 0x6363;

    for (int i = 0; i < len; i++)
    {
        // convert to 16 bit
        uint16_t ch = data[i];

        ch = ch ^ (crc & 0x00FF);
        ch = (ch ^ ((ch << 4) & 0x00FF));

        crc = (crc >> 8) ^ (ch << 8) ^ (ch << 3) ^ (ch >> 4);
    }

    return crc;
}

bool iso14443_scan_for_tags(void)
{
    bool res = false;

    // Init the TRF7970A in 14443A reader mode
    trf7970a_initialise_as_14443A_reader();

    // ISO 14443-3 section 5 "polling" states the PICC has to be ready to respond within 5ms
    // of being present in an unmodulated field.
    sleep_ms(10);

    // Transmit REQA and wait for ATQA
    uint8_t cmd = ISO_14443_SHORT_REQA;
    uint16_t atqa;
    enum TRF7970A_Status status;
    status = trf7970a_transmit_frame_wait_for_reply(false, &cmd, 1, 7, (uint8_t *)&atqa, 2);

    if (status == TRF7970A_Status_OK)
    {
        uart_puts("ATQA: ");
        uart_put_hex_word(atqa);
        uart_puts("\n");
    }
    else if ((status == TRF7970A_Status_TX_ERR) ||
             (status == TRF7970A_Status_TX_TIMEOUT))
    {
        // Tx error???
        goto cleanup;
    }
    else if (status == TRF7970A_Status_RX_TIMEOUT)
    {
        // no tags
        goto cleanup;
    }
    else
    {
        // collision
        // Not really sure what you're supposed to do with collisions during the ATQA
        // we just continue as normal.
    }

    // we could check the anticollision bits and the UID length
    // but I don't really see why that's useful.

    // 3 loops of anticollision
    struct ISO14443_SAK sak;
    uint8_t uid[10]; // max uid is 10 bytes
    uint8_t uidIdx = 0;
    for (int level = 1; level <= 3; level++)
    {
        // Send Anticollision / select with 0 bits of UID
        struct ISO14443_AnticollisionSelect selCmd;
        switch (level)
        {
            case 1: selCmd.level = ISO_14443_SelectLevel_1; break;
            case 2: selCmd.level = ISO_14443_SelectLevel_2; break;
            case 3: selCmd.level = ISO_14443_SelectLevel_3; break;
        }

        selCmd.nvb = ISO14443_ANTICOLLISION_SELECT_SET_NVB(0);
        uint8_t selReply[5]; // max len 5 bytes
        status = trf7970a_transmit_frame_wait_for_reply(false, (uint8_t *)&selCmd, 2, 0, selReply, 5);

        if (status == TRF7970A_Status_OK)
        {
            uart_puts("sel reply: ");
            uart_put_hex_byte(selReply[0]);
            uart_put_hex_byte(selReply[1]);
            uart_put_hex_byte(selReply[2]);
            uart_put_hex_byte(selReply[3]);
            uart_put_hex_byte(selReply[4]);
            uart_puts("\n");

            // check the BCC
            if (ISO14443_ANTICOLLISION_SELECT_CALC_BCC(selReply) != selReply[4])
            {
                uart_puts("BCC doesn't match expected\n");
                goto cleanup;
            }
        }
        else if ((status == TRF7970A_Status_TX_ERR) ||
                 (status == TRF7970A_Status_TX_TIMEOUT))
        {
            // Tx error???
            goto cleanup;
        }
        else if (status == TRF7970A_Status_RX_TIMEOUT)
        {
            // no reply??
            uart_puts("Rx timeout to anticollision\n");
            goto cleanup;
        }
        else
        {
            // collision
            uart_puts("Collision during reply to anticollision\n");
            // note there are other places where we can collide that need supporting too
#warning TODO: Support collisions
            goto cleanup;
        }

        // We have the UID for this cascade level
        // transmit select as a standard frame, with the full UID + BCC
        selCmd.nvb = ISO14443_ANTICOLLISION_SELECT_SET_NVB(40);
        memcpy(selCmd.uid, selReply, 4);
        selCmd.bcc = ISO14443_ANTICOLLISION_SELECT_CALC_BCC(selCmd.uid);

        status = trf7970a_transmit_frame_wait_for_reply(true, (uint8_t *)&selCmd, sizeof(selCmd), 0, (uint8_t *)&sak, sizeof(struct ISO14443_SAK));

        if (status == TRF7970A_Status_OK)
        {
            uart_puts("SAK: ");
            uart_put_hex_byte(sak.sak);
            uart_puts("\n");
        }
        else if ((status == TRF7970A_Status_TX_ERR) ||
                 (status == TRF7970A_Status_TX_TIMEOUT))
        {
            // Tx error???
            goto cleanup;
        }
        else if (status == TRF7970A_Status_RX_TIMEOUT)
        {
            // no reply??
            uart_puts("Rx timeout to select\n");
            goto cleanup;
        }
        else
        {
            // collision
            uart_puts("Collision during reply to select\n");
            // ??? should this be possible?
            goto cleanup;
        }

        // check CRC
        if (sak.crc != computeCrc(&sak.sak, 1))
        {
            uart_puts("CRC fail on SAK\n");
            goto cleanup;
        }

        if (!(sak.sak & ISO_14443_SAK_CASCADE_MASK))
        {
            // complete UID
            memcpy(&uid[uidIdx], selCmd.uid, 4);
            uidIdx += 4;
            break;
        }

        memcpy(&uid[uidIdx], &selCmd.uid[1], 3);
        uidIdx += 3;

        // incomplete UID move to the next level
        if (level == 3)
        {
            uart_puts("Incomplete UID after cascade level 3?\n");
            goto cleanup;
        }
    }

    uart_puts("Anticollision complete, UID: ");
    for (int i = 0; i < uidIdx; i++)
    {
        uart_put_hex_byte(uid[i]);
    }
    uart_puts("\n");

    if (!(sak.sak & ISO_14443_SAK_4_COMPAT_MASK))
    {
        // not 14443-4 compatable
        uart_puts("Tag is not ISO/IEC 14443-4 compatable\n");
        goto cleanup;
    }

    // supported tag found
    res = true;

cleanup:
    // turn the RF field off
    trf7970a_write_register(TRF7970A_REG_STATUS_CONTROL, 0x00);

    return res;
}
