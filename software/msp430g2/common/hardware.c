//==============================================================================
/*! \file     hardware.h
    \brief    Some functions for dealing with the hardware
    \author   Andrew Parlane
*/
//==============================================================================

#include "hardware.h"
#include "uart.h"
#include "spi.h"
#include "time.h"

#include <msp430.h>

// Pinout:
//  Pin 1   - VCC   - VCC
//  Pin 2   - P1.0  - ULP Wakeup            - GPIO Input
//  Pin 3   - P1.1  - UART Rx               - Not Used
//  Pin 4   - P1.2  - UART Tx               - USCI A0 UART Tx (sel = 2'b11)
//  Pin 5   - P1.3  - I/O_5                 - GPIO Input (for now) - has external pullup on ET board
//  Pin 6   - P1.4  - I/O_2                 - GPIO Input (for now)
//  Pin 7   - P1.5  - SPI_CLK               - USCI B0 SPI Clk (sel = 2'b11)
//  Pin 8   - P2.0  - IRQ (2)               - GPIO Input
//  Pin 9   - P2.1  - SLAVE_SELECT          - GPIO Output (active low)
//  Pin 10  - P2.2  - ENABLE                - GPIO Output (active high)
//  Pin 11  - P2.3  - ISO14443B LED (Blue)  - GPIO Output (active high)
//  Pin 12  - P2.4  - ISO14443A LED (Red)   - GPIO Output (active high)
//  Pin 13  - P2.5  - ISO15693 LED (Yellow) - GPIO Output (active high) - used as heartbeat LED
//  Pin 14  - P1.6  - MISO                  - USCI B0 SPI MISO (sel = 2'b11)
//  Pin 15  - P1.7  - MOSI                  - USCI B0 SPI MOSI (sel = 2'b11)
//  Pin 16  - RST   - RST                   - Not Used
//  Pin 17  - TEST  - TEST                  - Not Used
//  Pin 18  - XOUTR - IRQ (1)               - GPIO Input
//  Pin 19  - XINR  - I/O_3                 - Not Used
//  Pin 20  - GND   - GND                   - GND

static void configure_pins(void)
{
    // ------
    // Port 1
    // ------
    P1OUT = 0;  // all outputs default to 0

    // Select pin functions. All are GPIO / not used, except:
    //  P1.2 - UART Tx - USCI A0 UART Tx
    //  P1.5 - SPI_CLK - USCI B0 SPI Clk
    //  P1.6 - MISO    - USCI B0 SPI MISO
    //  P1.7 - MOSI    - USCI B0 SPI MOSI
    // all of which have P1SEL2 = 1 and P1SEL = 1
    P1SEL2 = BIT2 | BIT5 | BIT6 | BIT7;
    P1SEL  = BIT2 | BIT5 | BIT6 | BIT7;

    // All port 1 GPIOs are inputs
    P1DIR = 0;

    // Clear Interrupt registers, as not used for now
    P1IES = 0;
    P1IFG = 0;

    // ------
    // Port 2
    // ------
    // Set P2.1 - SLAVE_SELECT to high (deasserted)
    P2OUT = BIT1;

    // All pins in port 2 are in SEL mode 0 (GPIO)
    P2SEL  = 0;
    P2SEL2 = 0;

    // Pins used as outputs
    //  P2.1  - SLAVE_SELECT
    //  P2.2  - ENABLE
    //  P2.3  - ISO14443B LED (Blue)
    //  P2.4  - ISO14443A LED (Red)
    //  P2.5  - ISO15693 LED (Yellow)
    P2DIR = BIT1 | BIT2 | BIT3 | BIT4 | BIT5;

    // Clear Interrupt registers, as not used for now
    P2IES = 0;
    P2IFG = 0;

    // ------
    // Port 3
    // ------
    // I don't think we have port 3, keeping these incase they do anything important
    P3OUT = 0;
    P3DIR = 0;
}

static void osc_init(void)
{
    // Use DCOCLK /1 for both MCLK and SMCLK
    BCSCTL2 = SELM_0 | DIVM_0 | DIVS_0;

    if (CALBC1_16MHZ != 0xFF)
    {
        // Adjust this accordingly to your VCC rise time
        __delay_cycles(100000);

        /* Follow recommended flow. First, clear all DCOx and MODx bits. Then
         * apply new RSELx values. Finally, apply new DCOx and MODx bit values.
         */
        DCOCTL = 0x00;
        BCSCTL1 = CALBC1_16MHZ;     // Set DCO to 16MHz
        DCOCTL = CALDCO_16MHZ;
    }

    // Disable XT2 and set ACLK to be /1
    BCSCTL1 |= XT2OFF | DIVA_0;

    // Low Frequency clock is the VCLOCK
    // use 6pF capacitance for the LFXT1 crystal
    BCSCTL3 = LFXT1S_2 | XCAP_1;

    // Wait until we're locked
    do
    {
        // Clear OSC fault flag
        IFG1 &= ~OFIFG;

        // 50us delay
        __delay_cycles(800);
    } while (IFG1 & OFIFG);
}

void hardware_init(void)
{
    // Stop watchdog timer from timing out during initial start-up.
    WDTCTL = WDTPW | WDTHOLD;

    // set up pin muxing
    configure_pins();

    // Initi the oscillator and clocks
    osc_init();

    // Initialise our PIT (uses the WDT)
    time_init();

    // Set up USCI A0 to be debug UART
    uart_init();

    // SPI Init
    spi_init();

    // Finally enable global interrupts
    __bis_SR_register(GIE);
}
