//==============================================================================
/*! \file     spi.h
    \brief    Some functions for working with the SPI port to the TRF7970A
    \author   Andrew Parlane
*/
//==============================================================================

#ifndef __SPI_H
#define __SPI_H

#include <stdint.h>

void spi_init(void);

// Tranmits txLen bytes of txBuf, ignoring the rx data.
// Followed by rxLen bytes of dummy writes, and reading the rx data into rxBuf
void spi_tfer(const uint8_t *txBuf, uint16_t txLen, uint8_t *rxBuf, uint16_t rxLen);

// Tranmits txLen1 bytes of txBuf1, ignoring the rx data.
// Tranmits txLen2 bytes of txBuf2, ignoring the rx data.
// Followed by rxLen bytes of dummy writes, and reading the rx data into rxBuf
// We have this, as it's common to set up a command buffer followed by data to write
void spi_tfer_ext(const uint8_t *txBuf1, uint16_t txLen1, const uint8_t *txBuf2, uint16_t txLen2, uint8_t *rxBuf, uint16_t rxLen);

#endif
