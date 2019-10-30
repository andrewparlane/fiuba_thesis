//==============================================================================
/*! \file     uart.c
    \brief    Some functions for working with the debug uart
    \author   Andrew Parlane
*/
//==============================================================================

#include "uart.h"

#include <msp430.h>
#include <string.h>
#include <stdint.h>

void uart_init(void)
{
    // Disable USCI
    UCA0CTL1 |= UCSWRST;

    // Use USCI A0 with smclk
    UCA0CTL1 = UCSSEL_2 | UCSWRST;

    // Not sure exactly what this does
    UCA0MCTL = UCBRF_0 | UCBRS_6;

    // smclk = 16MHz
    // Baud rate = smclk / ((6 * 256)) + 130 ~= 9600
    UCA0BR0 = 130;
    UCA0BR1 = 6;

    // Enable it
    UCA0CTL1 &= ~UCSWRST;
}

void uart_putc(char c)
{
    // Wait until the Tx buffer is empty
    while (!(IFG2 & UCA0TXIFG));
    UCA0TXBUF = c;
}

void uart_puts(const char *s)
{
    for (; *s != (int)NULL; s++)
    {
        uart_putc(*s);
    }
}

void uart_put_hex_nibble(uint8_t b)
{
    b &= 0x0F;
    if (b < 10)
    {
        uart_putc('0' + b);
    }
    else
    {
        uart_putc('A' + b - 10);
    }
}

void uart_put_hex_byte(uint8_t b)
{
    uart_put_hex_nibble(b >> 4);
    uart_put_hex_nibble(b);
}
