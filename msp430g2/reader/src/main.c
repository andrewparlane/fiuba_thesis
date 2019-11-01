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

#include <msp430.h>
#include <stdint.h>
#include <stdbool.h>

#define VERSION_STRING "0.1"

// Changelog:
//      v0.1    - initial build

extern uint32_t volatile msSinceBoot;

int main( void )
{
    hardware_init();

    // Set up the DLP-7970ABP boosterpack
    GPIO_DEASSERT_TRF7970A_SS();
    GPIO_DEASSERT_TRF7970A_EN();
    gpio_set_led(Led_0, false);
    gpio_set_led(Led_1, false);
    gpio_set_led(Led_2, false);

    // leave the TRF7970A in reset for 100ms
    // then power it up and wait another 100ms (I can't find any timing info for reset, so 100ms seems safe)
    sleep_ms(100);
    GPIO_ASSERT_TRF7970A_EN();
    sleep_ms(100);

    uart_puts("======================================================================\n");
    uart_puts("MSP-EXP430G2 + DLP-7970ABP as a ISO 14443-4A reader\n");
    uart_puts("Written by Andrew Parlane <andrew.parlane@gmail.com>\n");
    uart_puts("as part of my masters thesis for the University of Buenos Aires (UBA)\n");
    uart_puts("======================================================================\n");
    uart_puts("Version " VERSION_STRING " built on " __DATE__ " at " __TIME__ "\n");
    uart_puts("======================================================================\n");


    // 16 bit CPU, so 32 bit ops are only to be used when necessary
    uint32_t lastHB = 0;
    while(1)
    {
        if ((msSinceBoot - lastHB) > 500)
        {
            lastHB = msSinceBoot;

            // toggle heartbeat LED
            gpio_toggle_led(Led_HEARTBEET);
        }
    }

    return 0;
}

