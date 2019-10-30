/*
 * ======== Standard MSP430 includes ========
 */
#include <msp430.h>
#include <stdint.h>
#include <string.h>
#include <stdbool.h>

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

void set_trf7970a_ss(bool en)   // slave select (en = 1 -> ss = 0 = chip active)
{
    // P2.1
    if (en)
    {
        P2OUT &= ~BIT1; // ss = 0 (active low)
    }
    else
    {
        P2OUT |= BIT1;  // ss = 1 (active low)
    }
}

void set_trf7970a_enable(bool en)
{
    // P2.2
    if (en)
    {
        P2OUT |= BIT2;  // enable = 1
    }
    else
    {
        P2OUT &= ~BIT2; // enable = 0
    }
}

void set_dlp_led1(bool on)  // labelled as ISO14443B
{
    // P2.3
    if (on)
    {
        P2OUT |= BIT3;
    }
    else
    {
        P2OUT &= ~BIT3;
    }
}

void set_dlp_led2(bool on)  // labelled as ISO14443A
{
    // P2.4
    if (on)
    {
        P2OUT |= BIT4;
    }
    else
    {
        P2OUT &= ~BIT4;
    }
}

void set_dlp_led3(bool on)  // labelled as ISO15693
{
    // P2.5
    if (on)
    {
        P2OUT |= BIT5;
    }
    else
    {
        P2OUT &= ~BIT5;
    }
}

void sleep(uint16_t ms)
{
    uint32_t currentTime = msSinceBoot;
    while (msSinceBoot < (currentTime + ms));
}

void spi_test()
{
    // Quick test, write a byte to the RAM register (0x12) and read it back
    bool ok;
    uint8_t dummy;

    // assert slave select
    set_trf7970a_ss(true);
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
    set_trf7970a_ss(false);

    sleep(1000); // wait 1s

    // read it back
    // assert slave select
    set_trf7970a_ss(true);
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
    set_trf7970a_ss(false);

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

    // Set up the DLP-7970ABP boosterpack
    set_trf7970a_ss(false);
    set_trf7970a_enable(false);
    set_dlp_led1(true);
    set_dlp_led2(false);
    set_dlp_led3(false);

    // enable global interrupts
    __bis_SR_register(GIE);
    // enable WDT irq   (in timeout mode with a 2ms timeout, used to update msSinceBoot
    IE1 |= WDTIE;

    // leave the TRF7970A in reset for 100ms
    // then power it up and wait another 100ms (I can't find any timing info for reset, so 100ms seems safe)
    sleep(100);
    set_trf7970a_enable(true);
    sleep(100);

    // UART Tx test
    uart_puts("Hello World!\n");

    // SPI test
    spi_test();

    // 16 bit CPU, so 32 bit ops are only to be used when necessary
    uint32_t lastHB = 0;
    uint8_t dlp_leds = 0x01;
    while(1)
    {
        if ((msSinceBoot - lastHB) > 500)
        {
            lastHB = msSinceBoot;
            uart_puts("Timeout\n");

            // toggle LED
            P1OUT ^= BIT0;

            // update DLP LEDs
            dlp_leds <<= 1;
            if (dlp_leds > 0x04)
            {
                dlp_leds = 0x01;
            }
            set_dlp_led1(dlp_leds & 0x01);
            set_dlp_led2(dlp_leds & 0x02);
            set_dlp_led3(dlp_leds & 0x04);
        }
    }

    return 0;
}
