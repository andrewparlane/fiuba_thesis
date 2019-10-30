//==============================================================================
/*! \file     gpio.c
    \brief    Some functions for dealing with GPIO pins
    \author   Andrew Parlane
*/
//==============================================================================

#include "gpio.h"

#include <stdbool.h>

void gpio_set_led(enum Led led, bool on)
{
    if (on)
    {
        switch (led)
        {
            case Led_0: GPIO_ASSERT_LED0(); break;
            case Led_1: GPIO_ASSERT_LED1(); break;
            case Led_2: GPIO_ASSERT_LED2(); break;
        }
    }
    else
    {
        switch (led)
        {
            case Led_0: GPIO_DEASSERT_LED0(); break;
            case Led_1: GPIO_DEASSERT_LED1(); break;
            case Led_2: GPIO_DEASSERT_LED2(); break;
        }
    }
}

void gpio_toggle_led(enum Led led)
{
    switch (led)
    {
        case Led_0: GPIO_TOGGLE_LED0(); break;
        case Led_1: GPIO_TOGGLE_LED1(); break;
        case Led_2: GPIO_TOGGLE_LED2(); break;
    }
}
