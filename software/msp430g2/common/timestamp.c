//==============================================================================
/*! \file     timestamp.c
    \brief    Helper function to output build date / time
    \author   Andrew Parlane
*/
//==============================================================================

#include "timestamp.h"
#include "uart.h"

void output_build_timestamp(void)
{
    uart_puts("Built on " __TIMESTAMP__ "\n");
}
