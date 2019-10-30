/*
 * ======== Standard MSP430 includes ========
 */
#include <msp430.h>
#include <stdint.h>
#include <string.h>

/*
 * ======== Grace related declaration ========
 */
extern void Grace_init(void);
extern volatile uint32_t msSinceBoot;

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

/*
 *  ======== main ========
 */
int main( void )
{
    Grace_init();                     // Activate Grace-generated configuration

    // >>>>> Fill-in user code here <<<<<

    // Note: I'm leaving this as close to the original generated code as possible
    //       For ease of diffing, to see what various changes in the GRACE GUI do to the code
    //       For real projects the code should be tidied up some more.

    // UART Tx test
    uart_puts("Hello World!\n");

    // enable global interrupts
    __bis_SR_register(GIE);
    // enable WDT irq   (in timeout mode with a 2ms timeout, used to update msSinceBoot
    IE1 |= WDTIE;

    // 16 bit CPU, so 32 bit ops are only to be used when necessary
    uint32_t lastHB = 0;
    while(1)
    {
        if ((msSinceBoot - lastHB) > 500)
        {
            lastHB = msSinceBoot;
            P1OUT ^= BIT0;  // toggle LED
            uart_puts("Toggle\n");
        }
    }

    return 0;
}
