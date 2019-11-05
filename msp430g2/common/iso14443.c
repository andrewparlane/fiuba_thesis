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

static struct ISO14443A_Tag _gTags[ISO14443A_NUM_SUPPORTED_TAGS];

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

static uint8_t get_uid_len(enum ISO14443_UID_Size uidSize)
{
    switch (uidSize)
    {
        case ISO14443_UID_Size_SINGLE: return 4;
        case ISO14443_UID_Size_DOUBLE: return 7;
        case ISO14443_UID_Size_TRIPLE: return 10;
        default:                       return 0;
    }
}

static bool do_anticollision_loop(struct ISO14443A_Tag *tag)
{
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
        /* uart_puts("ATQA: ");
        uart_put_hex_word(atqa);
        uart_puts("\n"); */
    }
    else if ((status == TRF7970A_Status_TX_ERR) ||
             (status == TRF7970A_Status_TX_TIMEOUT))
    {
        // Tx error???
        return false;
    }
    else if (status == TRF7970A_Status_RX_TIMEOUT)
    {
        // no tags
        return false;
    }
    else if (status == TRF7970A_Status_RX_COLLISION)
    {
        // collision
        // Not really sure what you're supposed to do with collisions during the ATQA
        // They are kind of expected, so let's just continue as normal
    }
    else
    {
        // error?
        return false;
    }

    // we could check the anticollision bits and the UID length
    // but I don't really see why that's useful.

    // Save the UID and the final SAK
    struct ISO14443_SAK sak;
    uint8_t uidIdx = 0;

    // 3 loops of anticollision
    uint8_t level = 1; // start with level 1
    struct ISO14443_AnticollisionSelect selCmd;
    memset(selCmd.uid, 0, 4);
    selCmd.nvb = ISO14443_ANTICOLLISION_SELECT_SET_NVB(0);
    while(1)
    {
        // Send Anticollision / select with 0 bits of UID
        switch (level)
        {
            case 1: selCmd.level = ISO_14443_SelectLevel_1; break;
            case 2: selCmd.level = ISO_14443_SelectLevel_2; break;
            case 3: selCmd.level = ISO_14443_SelectLevel_3; break;
        }

        uint8_t bytesToSend = ISO14443_ANTICOLLISION_SELECT_GET_NVB_BYTES(selCmd.nvb);
        uint8_t bitsToSend  = ISO14443_ANTICOLLISION_SELECT_GET_NVB_BITS(selCmd.nvb);
        uint8_t txLen = bytesToSend;
        if (bitsToSend != 0)
        {
            // len is total bytes in the buffer including any broken bytes
            txLen++;
        }

        /* uart_puts("Sending AC with UID: ");
        for (int i = 0; i < 4; i++)
        {
            uart_put_hex_byte(selCmd.uid[i]);
        }
        uart_puts(" NVB Bytes ");
        uart_put_hex_byte(bytesToSend);
        uart_puts(", Bits ");
        uart_put_hex_byte(bitsToSend);
        uart_puts("\n"); */

        uint8_t selReply[5];
        status = trf7970a_transmit_frame_wait_for_reply(false, (uint8_t *)&selCmd, txLen, bitsToSend, selReply, 5);

        if ((status == TRF7970A_Status_OK) ||
            (status == TRF7970A_Status_RX_COLLISION))
        {
            /* uart_puts("sel reply: ");
            uart_put_hex_byte(selReply[0]);
            uart_put_hex_byte(selReply[1]);
            uart_put_hex_byte(selReply[2]);
            uart_put_hex_byte(selReply[3]);
            uart_put_hex_byte(selReply[4]);
            uart_puts("\n"); */

            // the first byte in the reply may have bits we've already received, clear them
            // if we sent 3 bytes and 3 bits already
            // then bits 0,1,2 of the reply are ones we already have
            // so we do selReply &= ~0x07 to clear those 3 bits
            // bitsToSend   - mask
            // 0            - ~0x00
            // 1            - ~0x01
            // 2            - ~0x03
            // 3            - ~0x07
            // ...
            selReply[0] &= ~((1 << bitsToSend) - 1);
        }

        if (status == TRF7970A_Status_OK)
        {
            // no collision - all bits correct.

            // copy the reply over, use |= so we don't loose bits received earlier
            uint8_t firstUIDByte = bytesToSend - 2;
            for (uint8_t i = 0; i < (4 - firstUIDByte); i++)
            {
                selCmd.uid[i + firstUIDByte] |= selReply[i];
            }

            // check the BCC
            if (ISO14443_ANTICOLLISION_SELECT_CALC_BCC(selCmd.uid) != selReply[4 - firstUIDByte])
            {
                uart_puts("BCC doesn't match expected\n");
                return false;
            }
        }
        else if ((status == TRF7970A_Status_TX_ERR) ||
                 (status == TRF7970A_Status_TX_TIMEOUT))
        {
            // Tx error???
            return false;
        }
        else if (status == TRF7970A_Status_RX_TIMEOUT)
        {
            // no reply??
            uart_puts("Rx timeout to anticollision\n");
            return false;
        }
        else if (status == TRF7970A_Status_RX_COLLISION)
        {
            // collision
            uint8_t colByteIdx;
            uint8_t colBitIdx;
            trf7970a_get_last_collision_position(&colByteIdx, &colBitIdx);

            // for some reason the SELECT cmd and the NVB byte are included in the bit offset here
            colByteIdx -= 2;

            /* uart_puts("Collision during anticollision on byte ");
            uart_put_hex_byte(colByteIdx);
            uart_puts(" bit ");
            uart_put_hex_byte(colBitIdx);
            uart_puts("\n"); */

            // repeat this level, but this time set NVB to
            // valid received bits + 1, and send the known valid bits
            // with a 1 in the collision position
            selCmd.nvb = ISO14443_ANTICOLLISION_SELECT_SET_NVB(colByteIdx*8 + colBitIdx + 1);

            // the last byte in the reply may be a byte we didn't fully receive,
            // clear excess bits.
            // if we received a collision on bitIdx 3, then bits 0,1,2 are valid
            // but we want to clear bits 3,4,5,6,7.
            // selReply &= 0x07
            // colBitIdx    - mask
            // 0            - 0x00
            // 1            - 0x01
            // 2            - 0x03
            // 3            - 0x07
            // ...
            selReply[colByteIdx] &= ((1 << colBitIdx) - 1);

            // Note: this forces the collided bit to a 0, so if there are cards with UIDs
            // 01 23 45 67
            // 01 23 41 FF
            // We will collide on byteIdx 2 and bit Idx 2. So we set that to a 0
            // and find the 01 23 41 FF card first

            // copy the reply over, use |= so we don't loose bits received earlier
            uint8_t firstUIDByte = bytesToSend - 2;
            for (int i = 0; i <= colByteIdx; i++)
            {
                selCmd.uid[i + firstUIDByte] |= selReply[i];
            }

            continue;
        }
        else
        {
            // error ??
            return false;
        }

        // We have the UID for this cascade level
        // transmit select as a standard frame, with the full UID + BCC
        selCmd.nvb = ISO14443_ANTICOLLISION_SELECT_SET_NVB(40);
        selCmd.bcc = ISO14443_ANTICOLLISION_SELECT_CALC_BCC(selCmd.uid);
        status = trf7970a_transmit_frame_wait_for_reply(true, (uint8_t *)&selCmd, sizeof(selCmd), 0, (uint8_t *)&sak, sizeof(struct ISO14443_SAK));

        if (status == TRF7970A_Status_OK)
        {
            /* uart_puts("SAK: ");
            uart_put_hex_byte(sak.sak);
            uart_puts("\n"); */
        }
        else if ((status == TRF7970A_Status_TX_ERR) ||
                 (status == TRF7970A_Status_TX_TIMEOUT))
        {
            // Tx error???
            return false;
        }
        else if (status == TRF7970A_Status_RX_TIMEOUT)
        {
            // no reply??
            uart_puts("Rx timeout to select\n");
            return false;
        }
        else
        {
            // collision
            uart_puts("Collision during reply to select\n");
            // ??? should this be possible?
            return false;
        }

        // check CRC
        if (sak.crc != computeCrc(&sak.sak, 1))
        {
            uart_puts("CRC fail on SAK\n");
            return false;
        }

        if (!(sak.sak & ISO_14443_SAK_CASCADE_MASK))
        {
            // complete UID
            memcpy(&tag->uid[uidIdx], selCmd.uid, 4);
            uidIdx += 4;
            switch (level)
            {
                case 1: tag->uidSize = ISO14443_UID_Size_SINGLE; break;
                case 2: tag->uidSize = ISO14443_UID_Size_DOUBLE; break;
                case 3: tag->uidSize = ISO14443_UID_Size_TRIPLE; break;
            }
            tag->sak = sak.sak;
            break;
        }

        memcpy(&tag->uid[uidIdx], &selCmd.uid[1], 3);
        uidIdx += 3;

        // incomplete UID move to the next level
        if (level == 3)
        {
            uart_puts("Incomplete UID after cascade level 3?\n");
            return false;
        }
        level++;
        selCmd.nvb = ISO14443_ANTICOLLISION_SELECT_SET_NVB(0);
        memset(selCmd.uid, 0, 4);
    }

    // Put the card in HALT state while we scan for other tags
    uint16_t hltaCmd = ISO14443_STANDARD_HLTA;
    if (trf7970a_transmit_frame(true, (uint8_t *)&hltaCmd, 2, 0) != TRF7970A_Status_OK)
    {
        uart_puts("Failed to halt tag\n");
        return false;
    }

    // supported tag found
    return true;
}

void iso14443_scan_for_tags(void)
{
    uint8_t idx = 0;

    while (do_anticollision_loop(&_gTags[idx]))
    {
        idx++;
        if (idx > ISO14443A_NUM_SUPPORTED_TAGS)
        {
            // stop looking
            break;
        }
    }

    if (idx != 0)
    {
        uart_puts("Found ");
        uart_put_hex_byte(idx);
        uart_puts(" ISO 14443A tags:\n");
    }

    for (int i = 0; i < idx; i++)
    {
        uint8_t uidLen = get_uid_len(_gTags[i].uidSize);

        uart_puts("  UID: ");
        for (int j = 0; j < uidLen; j++)
        {
            uart_put_hex_byte(_gTags[i].uid[j]);
        }
        if (_gTags[i].sak & ISO_14443_SAK_4_COMPAT_MASK)
        {
            uart_puts(" ISO 14443-4 compatible");
        }
        uart_puts("\n");
    }

    trf7970a_disable_rf_field();
}
