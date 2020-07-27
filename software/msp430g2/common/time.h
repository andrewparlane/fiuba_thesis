//==============================================================================
/*! \file     time.h
    \brief    Some functions for dealing with delays / time since boot etc...
    \author   Andrew Parlane
*/
//==============================================================================

#ifndef __TIME_H
#define __TIME_H

#include <stdint.h>

void time_init(void);
void sleep_ms(uint16_t ms);
uint32_t get_ms_since_boot();

#endif
