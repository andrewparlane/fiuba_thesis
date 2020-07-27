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
#include <string.h>

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

void spi_tfer_ext(const uint8_t *txBuf1, uint16_t txLen1, const uint8_t *txBuf2, uint16_t txLen2, uint8_t *rxBuf, uint16_t rxLen, bool send_stop)
{
    // assert slave select
    GPIO_ASSERT_TRF7970A_SS();
    // need to wait 200ns before a clock edge
    // CPU runs at 16MHz, so one cycle is 62.5ns
    // not sure how many cycles there will be between ss active and the first clock edge
    // but I'll throw in a couple of NOPs to be sure.
    // scope says I have 1us here ATM (could change with optimisations / inlining)

    for (int i = 0; i < txLen1; i++)
    {
        // wait for space in the fifo
        while (!(IFG2 & UCB0TXIFG));

        // send the data
        UCB0TXBUF = txBuf1[i];
    }

    for (int i = 0; i < txLen2; i++)
    {
        // wait for space in the fifo
        while (!(IFG2 & UCB0TXIFG));

        // send the data
        UCB0TXBUF = txBuf2[i];
    }

    // wait for the tx to finish before starting the rx
    while (UCB0STAT & UCBUSY);

    for (int i = 0; i < rxLen; i++)
    {
        // dummy write
        UCB0TXBUF = 0;

        // wait for the send to finish (and the rx data to be available)
        while (UCB0STAT & UCBUSY);

        // read the rx data
        rxBuf[i] = UCB0RXBUF;
    }

    // again we need a 200ns delay here.
    // Scope says we have ~1us ATM.

    if (send_stop)
    {
        // deassert slave select
        GPIO_DEASSERT_TRF7970A_SS();
    }
}

void spi_tfer(const uint8_t *txBuf, uint16_t txLen, uint8_t *rxBuf, uint16_t rxLen)
{
    spi_tfer_ext(txBuf, txLen, NULL, 0, rxBuf, rxLen, true);
}
