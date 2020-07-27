//==============================================================================
/*! \file     gpio.h
    \brief    Some functions for dealing with GPIO pins
    \author   Andrew Parlane
*/
//==============================================================================

#ifndef __GPIO_H
#define __GPIO_H

#include <msp430.h>
#include <stdbool.h>

// see hardware.c for full pinout

//  Pin 5   - P1.3  - BUTTON                - GPIO Input (active low)
#define GPIO_TRF7970A_BUTTON_PORT   (P1IN)
#define GPIO_TRF7970A_BUTTON_BIT    (BIT3)
#define GPIO_TRF7970A_BUTTON_GET()  (!((GPIO_TRF7970A_BUTTON_PORT) & (GPIO_TRF7970A_BUTTON_BIT)))

//  Pin 8   - P2.0  - IRQ (2)               - GPIO Input
#define GPIO_TRF7970A_IRQ2_PORT     (P2IN)
#define GPIO_TRF7970A_IRQ2_BIT      (BIT0)
#define GPIO_TRF7970A_IRQ2_GET()    ((GPIO_TRF7970A_IRQ2_PORT) & (GPIO_TRF7970A_IRQ2_BIT))

//  Pin 9   - P2.1  - SLAVE_SELECT          - GPIO Output (active low)
#define GPIO_TRF7970A_SS_PORT       (P2OUT)
#define GPIO_TRF7970A_SS_BIT        (BIT1)
#define GPIO_ASSERT_TRF7970A_SS()   ((GPIO_TRF7970A_SS_PORT) &= ~(GPIO_TRF7970A_SS_BIT))
#define GPIO_DEASSERT_TRF7970A_SS() ((GPIO_TRF7970A_SS_PORT) |= (GPIO_TRF7970A_SS_BIT))

//  Pin 10  - P2.2  - ENABLE                - GPIO Output (active high)
#define GPIO_TRF7970A_EN_PORT       (P2OUT)
#define GPIO_TRF7970A_EN_BIT        (BIT2)
#define GPIO_ASSERT_TRF7970A_EN()   ((GPIO_TRF7970A_EN_PORT) |= (GPIO_TRF7970A_EN_BIT))
#define GPIO_DEASSERT_TRF7970A_EN() ((GPIO_TRF7970A_EN_PORT) &= ~(GPIO_TRF7970A_EN_BIT))

//  Pin 11  - P2.3  - ISO14443B LED (Blue)  - GPIO Output (active high)
#define GPIO_LED0_PORT              (P2OUT)
#define GPIO_LED0_BIT               (BIT3)
#define GPIO_ASSERT_LED0()          ((GPIO_LED0_PORT) |= (GPIO_LED0_BIT))
#define GPIO_DEASSERT_LED0()        ((GPIO_LED0_PORT) &= ~(GPIO_LED0_BIT))
#define GPIO_TOGGLE_LED0()          ((GPIO_LED0_PORT) ^= (GPIO_LED0_BIT))

//  Pin 12  - P2.4  - ISO14443A LED (Red)   - GPIO Output (active high)
#define GPIO_LED1_PORT              (P2OUT)
#define GPIO_LED1_BIT               (BIT4)
#define GPIO_ASSERT_LED1()          ((GPIO_LED1_PORT) |= (GPIO_LED1_BIT))
#define GPIO_DEASSERT_LED1()        ((GPIO_LED1_PORT) &= ~(GPIO_LED1_BIT))
#define GPIO_TOGGLE_LED1()          ((GPIO_LED1_PORT) ^= (GPIO_LED1_BIT))

//  Pin 13  - P2.5  - ISO15693 LED (Yellow) - GPIO Output (active high) - used as heartbeat LED
#define GPIO_LED2_PORT              (P2OUT)
#define GPIO_LED2_BIT               (BIT5)
#define GPIO_ASSERT_LED2()          ((GPIO_LED2_PORT) |= (GPIO_LED2_BIT))
#define GPIO_DEASSERT_LED2()        ((GPIO_LED2_PORT) &= ~(GPIO_LED2_BIT))
#define GPIO_TOGGLE_LED2()          ((GPIO_LED2_PORT) ^= (GPIO_LED2_BIT))

//  Pin 18  - P2.7  - IRQ (1)               - GPIO Input
#define GPIO_TRF7970A_IRQ1_PORT     (P2IN)
#define GPIO_TRF7970A_IRQ1_BIT      (BIT7)
#define GPIO_TRF7970A_IRQ1_GET()    ((GPIO_TRF7970A_IRQ1_PORT) & (GPIO_TRF7970A_IRQ1_BIT))

enum Led
{
    Led_0= 0,
    Led_1,
    Led_2,

    // Common
    Led_HEARTBEET = Led_2,

    // Reader

    // Card Emulation
    Led_TAG_ACTIVE = Led_0,
};

void gpio_set_led(enum Led led, bool on);
void gpio_toggle_led(enum Led led);

// should be called every loop
bool gpio_get_button_debounced(void);

#endif
