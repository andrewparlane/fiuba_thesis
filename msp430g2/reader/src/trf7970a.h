//==============================================================================
/*! \file     trf7970a.h
    \brief    Code for configuring and talking to the TRF7970A
    \author   Andrew Parlane
*/
//==============================================================================

#ifndef __TRF7970A_H
#define __TRF7970A_H

#include <stdint.h>
#include <stdbool.h>

// ----------------------------------------------------------------------------
// Address / Command byte construction
// ----------------------------------------------------------------------------

// bit 7, Command Control Bit,  0 = address, 1 = cmd
#define TRF7970A_ADDR_CMD_BYTE_ADDR_MASK                        (0x00)
#define TRF7970A_ADDR_CMD_BYTE_CMD_MASK                         (0x80)

// bit 6, Read/Write, 0 = write, 1 = read
#define TRF7970A_ADDR_CMD_BYTE_WRITE_MASK                       (0x00)
#define TRF7970A_ADDR_CMD_BYTE_READ_MASK                        (0x40)

// bit 5, Continuous Address Mode, 0 = normal, 1 = continuous
#define TRF7970A_ADDR_CMD_BYTE_CONT_MASK                        (0x20)

// bits 4:0, Address/Command
#define TRF7970A_ADDR_CMD_BYTE_ADDR_CMD_MASK                    (0x1F)

// Address / Command byte construction
#define TRF7970A_ADDR_CMD_BYTE_WRITE_ADDR(addr)                             \
                                ((TRF7970A_ADDR_CMD_BYTE_ADDR_MASK)     |   \
                                 (TRF7970A_ADDR_CMD_BYTE_WRITE_MASK)    |   \
                                 ((addr) & (TRF7970A_ADDR_CMD_BYTE_ADDR_CMD_MASK)))

#define TRF7970A_ADDR_CMD_BYTE_WRITE_ADDR_CONT(addr)                        \
                                ((TRF7970A_ADDR_CMD_BYTE_ADDR_MASK)     |   \
                                 (TRF7970A_ADDR_CMD_BYTE_WRITE_MASK)    |   \
                                 (TRF7970A_ADDR_CMD_BYTE_CONT_MASK)     |   \
                                 ((addr) & (TRF7970A_ADDR_CMD_BYTE_ADDR_CMD_MASK)))

#define TRF7970A_ADDR_CMD_BYTE_READ_ADDR(addr)                              \
                                ((TRF7970A_ADDR_CMD_BYTE_ADDR_MASK)     |   \
                                 (TRF7970A_ADDR_CMD_BYTE_READ_MASK)     |   \
                                 ((addr) & (TRF7970A_ADDR_CMD_BYTE_ADDR_CMD_MASK)))

#define TRF7970A_ADDR_CMD_BYTE_READ_ADDR_CONT(addr)                         \
                                ((TRF7970A_ADDR_CMD_BYTE_ADDR_MASK)     |   \
                                 (TRF7970A_ADDR_CMD_BYTE_READ_MASK)     |   \
                                 (TRF7970A_ADDR_CMD_BYTE_CONT_MASK)     |   \
                                 ((addr) & (TRF7970A_ADDR_CMD_BYTE_ADDR_CMD_MASK)))

#define TRF7970A_ADDR_CMD_BYTE_CMD(cmd)                                     \
                                ((TRF7970A_ADDR_CMD_BYTE_CMD_MASK)      |   \
                                 ((cmd) & (TRF7970A_ADDR_CMD_BYTE_ADDR_CMD_MASK)))

// ----------------------------------------------------------------------------
// Commands
// ----------------------------------------------------------------------------

#define TRF7970A_CMD_IDLE                                   (0x00)
#define TRF7970A_CMD_SW_INIT                                (0x03)
#define TRF7970A_CMD_RF_COLLISION_AVOIDANCE                 (0x04)  // See TRF7970A errata
#define TRF7970A_CMD_RF_COLLISION_AVOIDANCE_REPLY           (0x05)  // See TRF7970A errata
#define TRF7970A_CMD_RF_COLLISION_AVOIDANCE_REPLY_N_0       (0x06)  // See TRF7970A errata
#define TRF7970A_CMD_RESET_FIFO                             (0x0F)
#define TRF7970A_CMD_TX_WITHOUT_CRC                         (0x10)
#define TRF7970A_CMD_TX_WITH_CRC                            (0x11)
#define TRF7970A_CMD_TX_WITHOUT_CRC_DELAYED                 (0x12)
#define TRF7970A_CMD_TX_WITH_CRC_DELAYED                    (0x13)
#define TRF7970A_CMD_EOF_TX_NEXT_TIME_SLOT                  (0x14)
#define TRF7970A_CMD_BLOCK_RECEIVER                         (0x16)
#define TRF7970A_CMD_EN_RECEIVER                            (0x17)
#define TRF7970A_CMD_TEST_INTERNAL_RF                       (0x18)
#define TRF7970A_CMD_TEST_EXTERNAL_RF                       (0x19)

// ----------------------------------------------------------------------------
// Registers
// ----------------------------------------------------------------------------

// Main control registers
#define TRF7970A_REG_STATUS_CONTROL                         (0x00)
#define TRF7970A_REG_ISO_CONTROL                            (0x01)

// Protocol Subsetting Registers
#define TRF7970A_REG_14443B_TX_OPTIONS                      (0x02)
#define TRF7970A_REG_14443A_HBR_OPTIONS                     (0x03)
#define TRF7970A_REG_TX_TIMER_CONTROL_HIGH                  (0x04)
#define TRF7970A_REG_TX_TIMER_CONTROL_LOW                   (0x05)
#define TRF7970A_REG_TX_PULSE_LEN_CONTROL                   (0x06)
#define TRF7970A_REG_RX_NO_RESPONSE_WAIT_TIME               (0x07)
#define TRF7970A_REG_RX_WAIT_TIME                           (0x08)
#define TRF7970A_REG_MODULATOR_SYS_CLK_CONTROL              (0x09)
#define TRF7970A_REG_RX_SPECIAL_SETTING                     (0x0A)
#define TRF7970A_REG_REGULATOR_IO_CONTROL                   (0x0B)
#define TRF7970A_REG_SPECIAL_FUNC_1                         (0x10)
#define TRF7970A_REG_SPECIAL_FUNC_2                         (0x11)
#define TRF7970A_REG_FIFO_IRQ_LEVELS                        (0x14)
#define TRF7970A_REG_NFC_LOW_FIELD_LEVEL                    (0x16)
#define TRF7970A_REG_NFCID1                                 (0x17)      // up to 10 bytes wide
#define TRF7970A_REG_NFC_TARGET_DETECTION_LEVEL             (0x18)
#define TRF7970A_REG_NFC_TARGET_PROTOCOL                    (0x19)

// Status Registers
#define TRF7970A_REG_IRQ_STATUS                             (0x0C)
#define TRF7970A_REG_COLLISION_POSITION_INTERRUPT_MASK      (0x0D)
#define TRF7970A_REG_COLLISION_POSITION                     (0x0E)
#define TRF7970A_REG_RSSI_LEVEL_OSC_STATUS                  (0x0F)

// RAM Registers
#define TRF7970A_REG_RAM_1                                  (0x12)
#define TRF7970A_REG_RAM_2                                  (0x13)

// Test Registers
#define TRF7970A_REG_TEST_1                                 (0x1A)
#define TRF7970A_REG_TEST_2                                 (0x1B)

// FIFO Registers
#define TRF7970A_REG_FIFO_STATUS                            (0x1C)
#define TRF7970A_REG_TX_LEN_1                               (0x1D)
#define TRF7970A_REG_TX_LEN_2                               (0x1E)
#define TRF7970A_REG_FIFO_IO                                (0x1F)


// IRQ Flags (See TRF7970A_REG_IRQ_STATUS)
#define TRF7970A_REG_IRQ_STATUS_IRQ_TX                      (0x80)
#define TRF7970A_REG_IRQ_STATUS_IRQ_SRX                     (0x40)
#define TRF7970A_REG_IRQ_STATUS_IRQ_FIFO                    (0x20)
#define TRF7970A_REG_IRQ_STATUS_IRQ_CRC_ERR                 (0x10)
#define TRF7970A_REG_IRQ_STATUS_IRQ_PARITY_ERR              (0x08)
#define TRF7970A_REG_IRQ_STATUS_IRQ_FRAME_ERR               (0x04)
#define TRF7970A_REG_IRQ_STATUS_IRQ_COLLISION               (0x02)
#define TRF7970A_REG_IRQ_STATUS_IRQ_NORESP                  (0x01)

// ----------------------------------------------------------------------------
// API
// ----------------------------------------------------------------------------

// Register read / writes and Direct commands
void trf7970a_send_direct_command(uint8_t cmd);
void trf7970a_write_register(uint8_t addr, uint8_t val);
void trf7970a_write_registers_cont(uint8_t addr, const uint8_t *buf, uint16_t len);
uint8_t trf7970a_read_register(uint8_t addr);
void trf7970a_read_register_cont(uint8_t addr, uint8_t *buf, uint16_t len);

// FIFO access
void trf7970a_tx_without_crc(const uint8_t *data, uint16_t len, uint8_t brokenBits);

// High level API functions
bool trf7970a_init(void);
bool trf7970a_detect_other_rf_fields(void);

#endif
