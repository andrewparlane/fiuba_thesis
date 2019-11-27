//==============================================================================
/*! \file     main.c
    \brief    Entry point for the card emulator project
    \author   Andrew Parlane
*/
//==============================================================================

#include "uart.h"
#include "spi.h"
#include "time.h"
#include "hardware.h"
#include "gpio.h"
#include "trf7970a.h"
#include "iso14443.h"
#include "timestamp.h"

#include <msp430.h>
#include <stdint.h>
#include <stdbool.h>

#define VERSION_STRING "0.1"

// Changelog:
//      v0.1    - initial build

const enum ISO14443_UID_Size    _gUIDSize   = ISO14443_UID_Size_DOUBLE;
const uint8_t                   _gUID[]     = {0x12, 0x34, 0x56, 0x78, 0xC0, 0xFF, 0xEE};

int main( void )
{
    hardware_init();

    // turn off the LEDs
    gpio_set_led(Led_0, false);
    gpio_set_led(Led_1, false);
    gpio_set_led(Led_2, false);

    uart_puts("======================================================================\n");
    uart_puts("MSP-EXP430G2 + DLP-7970ABP as an ISO 14443-4A tag (card emulation)\n");
    uart_puts("Written by Andrew Parlane <andrew.parlane@gmail.com>\n");
    uart_puts("as part of my masters thesis for the University of Buenos Aires (UBA)\n");
    uart_puts("======================================================================\n");
    uart_puts("Version " VERSION_STRING "\n");
    output_build_timestamp();
    uart_puts("======================================================================\n");
    uart_puts("\n");

    // Initialise the TRF7970A
    bool trf7970aOk = trf7970a_init();
    uart_puts("\t\tTRF7970A: ");
    if (trf7970aOk)
    {
        uart_puts("OK");
    }
    else
    {
        uart_puts("FAIL");
    }
    uart_puts("\n");

    iso14443a_initialise_in_card_emulation_mode(_gUIDSize, _gUID);

    // 16 bit CPU, so 32 bit ops are only to be used when necessary
    uint32_t lastHB = 0;
    uint32_t tagLastActive = 0;
    while(1)
    {
        if ((get_ms_since_boot() - lastHB) > 500)
        {
            lastHB = get_ms_since_boot();

            // toggle heartbeat LED
            gpio_toggle_led(Led_HEARTBEET);
        }

        if (iso14443_card_emulation_poll())
        {
            tagLastActive = get_ms_since_boot();
        }

        if ((tagLastActive != 0) &&
            ((get_ms_since_boot() - tagLastActive) < 500))
        {
            // tag has been active in the last second
            gpio_set_led(Led_TAG_ACTIVE, true);
        }
        else
        {
            // tag has not been active for at least a second
            gpio_set_led(Led_TAG_ACTIVE, false);
        }
    }

    return 0;
}

