//==============================================================================
/*! \file     iso14443.h
    \brief    Set of defines / functions for the ISO 14443 standard
    \author   Andrew Parlane
*/
//==============================================================================

#ifndef __ISO14443_H
#define __ISO14443_H

#include <stdint.h>
#include <stdbool.h>

// Only support type A for now
#define ISO14443A_NUM_SUPPORTED_TAGS    (4)     // DLP can't seem to read more than 2

// --------------------------------------------------------
// Short frames
// --------------------------------------------------------
// REQA
#define ISO_14443_SHORT_REQA            (0x26)  // responds with ATQA
#define ISO_14443_SHORT_WUPA            (0x52)

// --------------------------------------------------------
// Bitwise Anticollision / select
// --------------------------------------------------------
enum ISO_14443_SelectLevel
{
    ISO_14443_SelectLevel_1 = 0x93,
    ISO_14443_SelectLevel_2 = 0x95,
    ISO_14443_SelectLevel_3 = 0x97,
};

struct ISO14443_AnticollisionSelect
{
    uint8_t     level;  // ISO_14443_SelectLevel
    uint8_t     nvb;    // format using ISO14443_ANTICOLLISION_SELECT_SET_NVB
    uint8_t     uid[4]; // UID bits
    uint8_t     bcc;    // exclusive OR of UID
    uint16_t    crc;
} __attribute__((packed));

// NVB is formatted as:
// [7:4] - num valid bytes transmitted by the PCD (including sel and nvb, so minimum 2)
// [3:0] - num valid bits transmitted by the PCD (0 - 7)

// uid_bits - the number of bits of the UID that the PCD sends (not including SEL and NVB)
#define ISO14443_ANTICOLLISION_SELECT_SET_NVB(num_uid_bits)             \
                    (((num_uid_bits) % 8) |                             \
                     ((2 + ((num_uid_bits) >> 3)) << 4))

#define ISO14443_ANTICOLLISION_SELECT_GET_NVB_BYTES(nvb)    ((nvb) >> 4)
#define ISO14443_ANTICOLLISION_SELECT_GET_NVB_BITS(nvb)     ((nvb) & 0x0F)

#define ISO14443_ANTICOLLISION_SELECT_CASCADE_TAG           (0x88)

#define ISO14443_ANTICOLLISION_SELECT_CALC_BCC(uid)                     \
                    ((uid[0]) ^ (uid[1]) ^ (uid[2]) ^ (uid[3]))

// --------------------------------------------------------
// Standard frames
// --------------------------------------------------------
#define ISO14443_STANDARD_HLTA                              (0x0050)

// --------------------------------------------------------
// Tag responses
// --------------------------------------------------------

// ATQA
// 16 bits
// [15:12]  RFU
// [11:8]   propietary encoding
// [7:6]    UID size
// [5]      RFU
// [4:0]    Anticollision bits (only one should be set)

enum ISO14443_UID_Size
{
    ISO14443_UID_Size_SINGLE = 0,   // 4 bytes
    ISO14443_UID_Size_DOUBLE = 1,   // 7 bytes
    ISO14443_UID_Size_TRIPLE = 2,   // 10 bytes
    ISO14443_UID_Size_RFU    = 3,   // Invalid (collision)
};

#define ISO_14443_ATQA_UID_SIZE_MASK                (0xC0)
#define ISO_14443_ATQA_UID_SIZE_LSB                 (6)
#define ISO_14443_ATQA_GET_UID_SIZE(atqa)           ((enum ISO14443_UID_Size)(((atqa) & (ISO_14443_ATQA_UID_SIZE_MASK)) >> (ISO_14443_ATQA_UID_SIZE_LSB)))
#define ISO_14443_ATQA_SET_UID_SIZE(size)           (((size) << (ISO_14443_ATQA_UID_SIZE_LSB)) & (ISO_14443_ATQA_UID_SIZE_MASK))

#define ISO_14443_ATQA_ANTICOLLISION_BITS_MASK      (0x1F)
#define ISO_14443_ATQA_ANTICOLLISION_BITS_LSB       (0)
#define ISO_14443_ATQA_GET_ANTICOLLISION_BITS(atqa) (((atqa) & (ISO_14443_ATQA_ANTICOLLISION_BITS_MASK)) >> (ISO_14443_ATQA_ANTICOLLISION_BITS_LSB))
#define ISO_14443_ATQA_ATICOLLISION_BITS_1          (0x01)
#define ISO_14443_ATQA_ATICOLLISION_BITS_2          (0x02)
#define ISO_14443_ATQA_ATICOLLISION_BITS_4          (0x04)
#define ISO_14443_ATQA_ATICOLLISION_BITS_8          (0x08)
#define ISO_14443_ATQA_ATICOLLISION_BITS_10         (0x10)

// SAK - 3 bytes
struct ISO14443_SAK
{
// [5] Tag supports ISO/IEC 14443-4
// [2] Cascade bit (UID complete when this is a 0)
    uint8_t sak;
    uint16_t crc;
} __attribute__((packed));

#define ISO_14443_SAK_4_COMPAT_MASK                 (0x20)
#define ISO_14443_SAK_CASCADE_MASK                  (0x04)

// --------------------------------------------------------
// API
// --------------------------------------------------------

struct ISO14443A_Tag
{
    enum ISO14443_UID_Size  uidSize;
    uint8_t                 uid[10];
    uint8_t                 sak;
};

void iso14443a_scan_for_tags(void);

void iso14443a_initialise_in_card_emulation_mode(enum ISO14443_UID_Size uidSize, const uint8_t *uid);
bool iso14443_card_emulation_poll(void);    // returns true if tag is active

#endif
