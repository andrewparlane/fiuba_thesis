//==============================================================================
/*! \file     main.c
    \brief    Entry point for the reader project
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

#define ONLY_POLL_ON_BUTTON_PRESS

// Changelog:
//      v0.1    - initial build

void poll_tags()
{
    // Check for other active RF fields
    // we don't want to collide with another reader
    // Note: this is more relevant for NFC when you can have peer-to-peer mode
    //       but would still cause issues to have two active readers in the same area
    /* if (trf7970a_detect_other_rf_fields())
    {
        uart_puts("RF field detected, staying offline to avoid collisions\n");
        return;
    } */

    iso14443a_scan_for_tags();
}

int main( void )
{
    hardware_init();

    // turn off the LEDs
    gpio_set_led(Led_0, false);
    gpio_set_led(Led_1, false);
    gpio_set_led(Led_2, false);

    uart_puts("======================================================================\n");
    uart_puts("MSP-EXP430G2 + DLP-7970ABP as a ISO 14443-4A reader\n");
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

    // 16 bit CPU, so 32 bit ops are only to be used when necessary
    uint32_t lastHB = 0;
    while(1)
    {
        if ((get_ms_since_boot() - lastHB) > 1000)
        {
            lastHB = get_ms_since_boot();

            // toggle heartbeat LED
            gpio_toggle_led(Led_HEARTBEET);

#ifndef ONLY_POLL_ON_BUTTON_PRESS
            poll_tags();
#endif
        }

#ifdef ONLY_POLL_ON_BUTTON_PRESS
        if (gpio_get_button_debounced())
        {
            uart_puts("polling\n");
            poll_tags();
        }
#endif
    }

    return 0;
}

