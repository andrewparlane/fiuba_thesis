//==============================================================================
/*! \file     uart.h
    \brief    Some functions for working with the debug uart
    \author   Andrew Parlane
*/
//==============================================================================

#ifndef __UART_H
#define __UART_H

#include <stdint.h>

void uart_init(void);
void uart_putc(char c);
void uart_puts(const char *s);
void uart_put_hex_nibble(uint8_t b);
void uart_put_hex_byte(uint8_t b);
void uart_put_hex_word(uint16_t w);

#endif
