//==============================================================================
/*! \file     time.c
    \brief    Some functions for dealing with delays / time since boot etc...
    \author   Andrew Parlane
*/
//==============================================================================

#include "time.h"

#include <msp430.h>
#include <stdint.h>

void time_init(void)
{
    // Enable the watchdog in interval mode
    // Timeout occurs after 32768 / smclk = 32768/16MHz = 2.048ms
    WDTCTL = WDTPW | WDTTMSEL;

    // Clear the WDT IRQ
    IFG1 &= ~(WDTIFG);

    // Enable the WDT interrupt
    IE1 |= WDTIE;
}

// 32 bit var (software emulation) - times out after ~49 days
// Hmm, this isn't great, as there is a race condition here
#warning TODO - change msSinceBoot to 16 bits, and figure out a solution for being accurate over longer times
static uint32_t volatile msSinceBoot = 0;
static void __attribute__ ((interrupt(WDT_VECTOR))) watchdog_isr (void)
{
    msSinceBoot += 2;
}

void sleep_ms(uint16_t ms)
{
    uint32_t currentTime = msSinceBoot;
    while (msSinceBoot < (currentTime + ms));
}

uint32_t get_ms_since_boot()
{
    return msSinceBoot;
}
