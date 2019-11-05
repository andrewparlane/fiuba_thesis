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

#include <msp430.h>
#include <stdint.h>
#include <stdbool.h>

#define VERSION_STRING "0.1"

// Changelog:
//      v0.1    - initial build

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
    uart_puts("Version " VERSION_STRING " built on " __DATE__ " at " __TIME__ "\n");
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
        if ((get_ms_since_boot() - lastHB) > 500)
        {
            lastHB = get_ms_since_boot();

            // toggle heartbeat LED
            gpio_toggle_led(Led_HEARTBEET);
        }
    }

    return 0;
}

