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

// ------------------------------------------------------------------
// Reader global vars / defines
// ------------------------------------------------------------------
static struct ISO14443A_Tag     _gTags[ISO14443A_NUM_SUPPORTED_TAGS];

// ------------------------------------------------------------------
// Card Emulator global vars / defines
// ------------------------------------------------------------------
//#define USE_AUTO_SDD
#define RX_BUFFER_LEN           (16)

enum State
{
    State_POWER_OFF = 0,
    State_IDLE,
    State_HALT,
    State_READY,
    State_READY_STAR,
    State_ACTIVE,
    State_ACTIVE_STAR,
    State_PROTOCOL
};

static enum ISO14443_UID_Size   _gUIDSize;
static const uint8_t *          _gUIDptr;
static uint8_t                  _gRxBuffer[RX_BUFFER_LEN];
static enum State               _gTagState;

#ifndef USE_AUTO_SDD
static uint8_t                  _gTagCurrentACLevel;
#endif

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
        memset(selReply, 0, 5);
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
        // don't need to set the CRC manually, the TRF7970A will send it for us
        // hence the sizeof(selCmd) - 2
        status = trf7970a_transmit_frame_wait_for_reply(true, (uint8_t *)&selCmd, sizeof(selCmd)-2, 0, (uint8_t *)&sak, sizeof(struct ISO14443_SAK));

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

    // wait a little while before putting the tag to sleep
    // this is because in the card_emulator project with auto-sdd
    // we miss the HLTA command if it comes too quickly.
    sleep_ms(100);

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

void iso14443a_scan_for_tags(void)
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

    sleep_ms(20); // wait a little bit before disabling the field

    trf7970a_disable_rf_field();
}

void iso14443a_initialise_in_card_emulation_mode(enum ISO14443_UID_Size uidSize, const uint8_t *uid)
{
    // cache the arguments
    _gUIDSize   = uidSize;
    _gUIDptr    = uid;
    _gTagState  = State_POWER_OFF;

    trf7970a_initialise_as_14443A_card_emulator();

#ifdef USE_AUTO_SDD
    // Enable auto-SDD
    trf7970a_enable_auto_sdd(get_uid_len(uidSize), uid);

    // we only support 14443-4 compliant comms ATM
    trf7970a_set_iso_14443_4_compliance(true);
#endif

    // check if we are already in an RF field
    uint8_t target_protocol = trf7970a_read_register(TRF7970A_REG_NFC_TARGET_PROTOCOL);
    if (target_protocol & 0x80)
    {
        _gTagState = State_IDLE;
    }
}

#ifndef USE_AUTO_SDD
static void card_emulation_handle_anticollision_select_cmd(struct ISO14443_AnticollisionSelect *acs, uint8_t rxLen)
{
    // + 2 for CRC
    if ((rxLen < 2) || (rxLen > (sizeof(struct ISO14443_AnticollisionSelect) + 2)))
    {
        uart_puts("AC / SELECT of invalid size\n");
        _gTagState = State_IDLE;
        return;
    }

    // get our UID bytes for this level (and BCC)
    uint8_t uid[5];
    bool cascade = false;
    enum ISO_14443_SelectLevel nextLevel = 0;
    switch (acs->level)
    {
        case ISO_14443_SelectLevel_1:
        {
            if (_gUIDSize == ISO14443_UID_Size_SINGLE)
            {
                memcpy(uid, &_gUIDptr[0], 4);
            }
            else
            {
                uid[0] = (ISO14443_ANTICOLLISION_SELECT_CASCADE_TAG);
                memcpy(&uid[1], &_gUIDptr[0], 3);
                cascade = true;
                nextLevel = ISO_14443_SelectLevel_2;
            }
            break;
        }
        case ISO_14443_SelectLevel_2:
        {
            if (_gUIDSize == ISO14443_UID_Size_SINGLE)
            {
                // can't have level 2 when we only have a single UID
                _gTagState = State_IDLE;
                uart_puts("level 2 but we are single UID\n");
                return;
            }
            else if (_gUIDSize == ISO14443_UID_Size_DOUBLE)
            {
                memcpy(&uid[0], &_gUIDptr[3], 4);
            }
            else
            {
                uid[0] = (ISO14443_ANTICOLLISION_SELECT_CASCADE_TAG);
                memcpy(&uid[1], &_gUIDptr[3], 3);
                cascade = true;
                nextLevel = ISO_14443_SelectLevel_3;
            }
            break;
        }
        case ISO_14443_SelectLevel_3:
        {
            if (_gUIDSize != ISO14443_UID_Size_TRIPLE)
            {
                // can't have level 3 when we only have a single / double UID
                _gTagState = State_IDLE;
                uart_puts("level 3 but we are not triple UID\n");
                return;
            }
            else
            {
                memcpy(&uid[0], &_gUIDptr[6], 4);
            }
            break;
        }
        default:
        {
            uart_puts("Not AC / SELECT command\n");
            _gTagState = State_IDLE;
            return;
        }
    }

    // calculate the BCC
    uid[4] = ISO14443_ANTICOLLISION_SELECT_CALC_BCC(uid);

    uint8_t nvb_bytes = ISO14443_ANTICOLLISION_SELECT_GET_NVB_BYTES(acs->nvb);
    uint8_t nvb_bits = ISO14443_ANTICOLLISION_SELECT_GET_NVB_BITS(acs->nvb);
    uint8_t expectedRxLen = nvb_bytes + ((nvb_bits != 0) ? 1 : 0);
    if ((nvb_bytes == 7) && (nvb_bits == 0))
    {
        // Select command, includes the CRC
        expectedRxLen += 2;
    }

    if (rxLen != expectedRxLen)
    {
        uart_puts("rxLen doesn't match NVB\n");
        _gTagState = State_IDLE;
        return;
    }

    // valid AC / select command
    if (acs->level != _gTagCurrentACLevel)
    {
        uart_puts("unexpected AC level\n");
        _gTagState = State_IDLE;
        return;
    }

    // check if the UID / BCC matches ours
    uint8_t i;
    for (i = 0; i < nvb_bytes-2; i++)
    {
        if (acs->uid[i] != uid[i])
        {
            // not us
            uart_puts("UID doesn't match\n");
            _gTagState = State_IDLE;
            return;
        }
    }

    // received nvb_bits more bits (LSbs), create a mask for them
    // 0 - 0
    // 1 - 1
    // 2 - 3
    // 3 - 7
    // ...
    uint8_t mask = (1 << nvb_bits) - 1;
    if ((acs->uid[i] & mask) != (uid[i] & mask))
    {
        // not us
        uart_puts("UID doesn't match (bits)\n");
        _gTagState = State_IDLE;
        return;
    }

    // OK, this is still for us
    // send our reply

    if ((nvb_bytes == 7) && (nvb_bits == 0))
    {
        // Select command.
        // Check the CRC
        if (acs->crc != computeCrc((uint8_t *)acs, 7))
        {
            uart_puts("CRC mismatch\n");
            _gTagState = State_IDLE;
            return;
        }
        else
        {
            // finished this level

            if (cascade)
            {
                _gTagCurrentACLevel = nextLevel;
            }
            else
            {
                // reset the fifo
                trf7970a_send_direct_command(TRF7970A_CMD_RESET_FIFO);

                // disable anticollision frames
                // we don't want to answer future SELECT / anticollision commands
                trf7970a_write_register(TRF7970A_REG_SPECIAL_FUNC_1, 2);

                // Comms should now contain CRCs
                trf7970a_write_register(TRF7970A_REG_ISO_CONTROL, 0x24);

                _gTagState = State_ACTIVE;
                uart_puts("SDD complete\n");
            }

            // Send our SAK
            struct ISO14443_SAK sak;
            // send just the cascade flag if there's more UID to send
            // else just the 14443-4 compatiblity flag.
            // as per section 6.5.3.4 of 14443-3 2016
            sak.sak = cascade ? (ISO_14443_SAK_CASCADE_MASK) : (ISO_14443_SAK_4_COMPAT_MASK);
            trf7970a_transmit_frame(true, (uint8_t *)&sak, 1, 0);
        }
    }
    else if (nvb_bits == 0)
    {
        // got a whole number of bytes of the UID, but not all, respond with the rest
        trf7970a_transmit_frame(false, &uid[nvb_bytes-2], 7 - nvb_bytes, 0);
    }
    else
    {
        // I can't make this work, I spent a lot of time trying to figure out how to formulate
        // the reply so that the reader gets the correct value, but failed.
        // There were very strange things happening, such as sending all 0s
        // resultad in the reader receiving 00010101011 (for the reader sending us 1 bit of the UID)
        // or 0002020202 (for the reader sending us 2 bits of the UID etc...).
        // Changing 1 bit of the reply could change multiple bits of what was received.
        // The TRF7970A does not have a way to enforce the anti-collision timing restrictions
        // stated in ISO/IEC 14443-3A, so it could be related to that, but I was getting the
        // same results if I had uart comms between receiving and tranmitting the reply, or not.

        // Note: I think the issue here is the parity bits.
        //       if the reader sends us 2 bits of the UID the expected format is:
        //
        //       PCD -> PICC - LEVEL NVB bb
        //       PICC -> PCD -             bbbbbb I bbbbbbbb P bbbbbbbb P bbbbbbbb P bbbbbbbb P
        //
        //       where b is a bit (0 or 1)
        //       P is a parity bit
        //       I is an ignored bit (parity bits of broken bytes are ignored)
        //
        //       Now what I think is happening is we are transmitting 4 bytes and 6 bits
        //       so the TRF7970A adds the parity bits automatically after each byte.
        //       giving us:
        //
        //       PCD -> PICC - LEVEL NVB bb
        //       PICC -> PCD -             bbbbbbbb P bbbbbbbb P bbbbbbbb P bbbbbbbb P bbbbbb
        //
        //       So the PCD auto receives this data and ditches the expected parity bits.
        //       except that was actual data, and uses the auto inserted parity bits as actual data.
        //       which is why when the PICC sends: 0x00, 0x00, 0x00, 0x00, 0x00:
        //
        //       We want to send:               000000 I 00000000 1 00000000 1 00000000 1 00000000 1
        //       The TRF7970A actually sends:   00000000 1 00000000 1 00000000 1 00000000 1 000000
        //       which gets received as:      00000000 I 01000000 0 01000000 0 01000000 0 01000000
        //       which is:                      0x00, 0x02, 0x02, 0x02, 0x02
        //
        //       The fix for this is to get the TRF7970A in card emulator mode
        //       to not auto insert parity bits, or to get it to insert them in the correct
        //       location. I have not found a way to do this yet.

        uart_puts("Got AC with nvb_bits ");
        uart_put_hex_byte(nvb_bits);
        uart_puts(", currently don't support broken bytes replies\n");

        _gTagState = State_IDLE;
        return;
    }
}
#endif

bool iso14443_card_emulation_poll(void)
{
    if (trf7970a_card_emulation_poll_irq())
    {
        uint8_t irqStatus = trf7970a_get_last_irq_status();
        /* uart_puts("irq: ");
        uart_put_hex_byte(irqStatus); */
        if (irqStatus & (TRF7970A_REG_IRQ_STATUS_IRQ_RF_CHANGE))
        {
            uint8_t target_protocol = trf7970a_read_register(TRF7970A_REG_NFC_TARGET_PROTOCOL);
            /* uart_puts(" ");
            uart_put_hex_byte(target_protocol); */
            if (!(target_protocol & 0x80))
            {
                // field has gone away, reset
                iso14443a_initialise_in_card_emulation_mode(_gUIDSize, _gUIDptr);
            }
            else
            {
                // in an RF field
                _gTagState = State_IDLE;
            }
        }
        //uart_puts("\n");

        if (irqStatus & (TRF7970A_REG_IRQ_STATUS_IRQ_SDD_COMPLETE))
        {
            // SDD is complete

            uint8_t target_protocol = trf7970a_read_register(TRF7970A_REG_NFC_TARGET_PROTOCOL);
            if (target_protocol != 0x89)
            {
                // not ISO 14443A, or field has now gone away
                // reset
                iso14443a_initialise_in_card_emulation_mode(_gUIDSize, _gUIDptr);
            }

            // we have to wait a little bit because the SDD complete flag
            // occurs before we have finished sending the SAK (in ISO 14443A) mode.
            // if we don't sleep we change the settings during SAK transmission
            // resulting in a CRC error
#warning TODO: Sleep for less time
            sleep_ms(4);

            // reset the fifo
            trf7970a_send_direct_command(TRF7970A_CMD_RESET_FIFO);

            // disable anticollision frames
            // we don't want to answer future SELECT / anticollision commands
            trf7970a_write_register(TRF7970A_REG_SPECIAL_FUNC_1, 2);

            // disable auto SDD
            trf7970a_write_register(TRF7970A_REG_NFC_TARGET_DETECTION_LEVEL, 7);

            // Comms should now contain CRCs
            trf7970a_write_register(TRF7970A_REG_ISO_CONTROL, 0x24);

            _gTagState = State_ACTIVE;
            uart_puts("Auto SDD complete\n");
        }

        if (irqStatus & TRF7970A_REG_IRQ_STATUS_IRQ_SRX)
        {
            // Receive
            uint8_t rxLen = trf7970a_receive_frame(_gRxBuffer, (RX_BUFFER_LEN));
            /* uart_puts("Rx ");
            uart_put_hex_byte(rxLen);
            uart_puts(" bytes,");
            for (int i = 0; i < rxLen; i++)
            {
                uart_puts(" ");
                uart_put_hex_byte(_gRxBuffer[i]);
            }
            uart_puts("\n"); */

            switch (_gTagState)
            {
                case State_IDLE:
                case State_HALT:
                {
#ifndef USE_AUTO_SDD
                    // Expect REQA or WUPA
                    if ((rxLen == 1) &&
                        ((_gRxBuffer[0] == (ISO_14443_SHORT_REQA)) ||
                         (_gRxBuffer[0] == (ISO_14443_SHORT_WUPA))))
                    {
                        if ((_gTagState == State_HALT) &&
                            (_gRxBuffer[0] == (ISO_14443_SHORT_REQA)))
                        {
                            // we ignore REQA in the HALT state
                        }
                        else
                        {
                            // respond with our ATQA
                            // I can't see anything that says which anticollision bit
                            // I should use, so just using 04, as do all my other cards
                            uint16_t atqa = (ISO_14443_ATQA_ATICOLLISION_BITS_4) |
                                            (ISO_14443_ATQA_SET_UID_SIZE(_gUIDSize));
                            if (trf7970a_transmit_frame(false, (uint8_t *)&atqa, 2, 0) != TRF7970A_Status_OK)
                            {
                                uart_puts("Failed to send ATQA\n");
                            }
                            else
                            {
                                _gTagState = State_READY;
                                _gTagCurrentACLevel = ISO_14443_SelectLevel_1;
                            }
                        }
                    }
                    else
#endif
                    {
                        // unexpected message, remain idle
                        uart_puts("Unexpected Rx whilst idle / halted\n");
                    }
                    break;
                }
#ifndef USE_AUTO_SDD
                case State_READY:
                {
                    struct ISO14443_AnticollisionSelect *acs = (struct ISO14443_AnticollisionSelect *)_gRxBuffer;
                    card_emulation_handle_anticollision_select_cmd(acs, rxLen);
                    break;
                }
#endif
                case State_ACTIVE:
                {
                    // for now we only accept the HLTA command
                    // the TRF7970A auto-checks the CRC and discards
                    if ((rxLen == 2) &&
                        ((*(uint16_t *)_gRxBuffer) == (ISO14443_STANDARD_HLTA)))
                    {
                        // HLTA command go to the HLT state
                        _gTagState = State_HALT;

                        // Note: once in the halt state, REQAs should be ignored
                        //       and we should only respond to WUPA.
                        //       The TRF7970A does not have a mode to support that
                        //       whilst using auto-sdd. So we either re-enable SDD here
                        //       and immediately get selected again with the next REQA
                        //       or we have to deal with manual AC this time round.
                        //       Ignoring for now, as my reader app doesn't do anything
                        //       more with a tag once it sends HLTA. This may change later.

                        uart_puts("Got HLTA\n");
                    }
                    else
                    {
                        // unexpected command, ignore
                        // technically there are some commands here that would transitition us
                        // to either the State_PROTOCOL or State_IDLE
                    }

                    break;
                }
                default:
                {
                    uart_puts("Got Rx while in unexpected state, ignoring\n");
                }
            }
        }
    }

    return ((_gTagState == State_ACTIVE) ||
            (_gTagState == State_ACTIVE_STAR) ||
            (_gTagState == State_PROTOCOL));
}
