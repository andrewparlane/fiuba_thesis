//==============================================================================
/*! \file     spi.h
    \brief    Some functions for working with the SPI port to the TRF7970A
    \author   Andrew Parlane
*/
//==============================================================================

#include "spi.h"
#include "uart.h"
#include "time.h"
#include "gpio.h"

#include <msp430.h>
#include <stdint.h>
#include <stdbool.h>

void spi_init(void)
{
    // Disable USCI
    UCB0CTL1 |= UCSWRST;

    // CPOL=0, CPHA=0, MSB first, 8 bit, SPI Master, no slave select (we GPIO it)
    UCB0CTL0 = UCMSB | UCMST | UCMODE_0 | UCSYNC;

    // We use the smclk for this peripheral
    UCB0CTL1 = UCSSEL_2 | UCSWRST;

    // SPI clk at smclk / 16 = 1MHz
    UCB0BR0 = 16;

    // Enable it
    UCB0CTL1 &= ~UCSWRST;
}

void spi_test(void)
{
    // Quick test, write a byte to the RAM register (0x12) and read it back
    bool ok;

    // assert slave select
    GPIO_ASSERT_TRF7970A_SS();
    // need to wait 200ns before a clock edge
    // CPU runs at 16MHz, so one cycle is 62.5ns
    // not sure how many cycles there will be between ss active and the first clock edge
    // but I'll throw in a couple of NOPs to be sure.
    // scope says I have 1us here ATM (could change with optimisations / inlining)
    asm("NOP\n"
        "NOP\n");

    UCB0TXBUF = 0x12;               // address mode, write, not continuous, RAM reg
    while (!(IFG2 & UCB0TXIFG));    // wait for space in the fifo
    UCB0TXBUF = 0xAB;               // data to write
    while (UCB0STAT & UCBUSY);      // wait for the send to finish

    // again there's a 200ns min between the last clock edge and the SS deasserting
    // scope says I have 1us here ATM (could change with optimisations / inlining)
    asm("NOP\n"
        "NOP\n"
        "NOP\n"
        "NOP\n");

    // deassert slave select
    GPIO_DEASSERT_TRF7970A_SS();

    sleep_ms(1000); // wait 1s

    // read it back
    // assert slave select
    GPIO_ASSERT_TRF7970A_SS();
    asm("NOP\n"
        "NOP\n");

    UCB0TXBUF = 0x40 | 0x12;        // address mode, read, not continuous, RAM reg
    while (UCB0STAT & UCBUSY);      // wait for the send to finish
    UCB0TXBUF = 0;                  // dummy write
    while (UCB0STAT & UCBUSY);      // wait for the send to finish
    ok = UCB0RXBUF == 0xAB;

    asm("NOP\n"
        "NOP\n"
        "NOP\n"
        "NOP\n");

    // deassert slave select
    GPIO_DEASSERT_TRF7970A_SS();

    uart_puts("SPI Test: ");
    if (ok)
    {
        uart_puts("OK");
    }
    else
    {
        uart_puts("Fail");
    }
    uart_puts("\n");
}
