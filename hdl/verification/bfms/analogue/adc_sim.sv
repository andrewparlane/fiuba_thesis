/***********************************************************************
        File: adc_sim.sv
 Description: Model of the ADC
      Author: Andrew Parlane
**********************************************************************/

/*
 * This file is part of https://github.com/andrewparlane/iso_iec_14443A
 * Copyright (c) 2020 Andrew Parlane.
 *
 * This is free software: you can redistribute it and/or modify it under
 * the terms of the GNU General Public License as published by the Free
 * Software Foundation, version 3.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this code. If not, see <http://www.gnu.org/licenses/>.
 */

`timescale 1ps/1ps

module adc_sim
#(
    parameter int MIN_CYCLES    = 1000,
    parameter int MAX_CYCLES    = 2000
)
(
    input                   clk,

    // input                   adc_enable,  // Not currently used, see comments below
    input                   adc_read,
    output logic            adc_conversion_complete,
    output logic    [15:0]  adc_value,

    // tells the testbench if this model is "busy" doing a read. This is so we can make sure not to start
    // a second read before the first has finished
    output logic            busy,

    // we change adc_value after conversion_complete asserts, so that the correct value is
    // only set for 1 tick. This can be used to ensure the DUT samples the value on the correct
    // tick. I provide last_valid_adc_value here so that the testbench knows what result to expect
    output logic    [15:0]  last_valid_adc_value
);

    // ----------------------------------------------------------------
    // ADC model
    // ----------------------------------------------------------------

    // The ADC as described to me works as follows. However it's worth noting
    // that we don't actually have an ADC implemented for this project yet
    // and as such this is liable to change.

    // I am assuming that adc_conversion_complete is a single cycle pulse that occurs
    // between MIN_CYCLES and MAX_CYCLES after the rising edge of adc_read. I don't bother
    // to check adc_enable in this model. When using AUTO_READ, the adc_enable signal is
    // automatically asserted. When using SET_SIGNAL, the PCD should ensure that the adc_enable
    // signal is asserted before the adc_read. This makes it simpler for the PICC to not
    // worry about that and to just assume the PCD has set it correctly.

    // The ADC has two inputs:
    //  logic adc_enable                - powers up the ADC
    //  logic adc_read                  - starts the read process on the rising edge, should be held high
    //                                    until after conversion_complete asserts
    //
    // And two outputs:
    //  logic adc_conversion_complete   - the read operation is complete, the data in adc_value is
    //                                    valid. It is unclear if this value will remain constant
    //                                    for any period of time after adc_conversion_complete
    //                                    asserts.
    //  logic [15:0] adc_value          - the result of the read operation.

    initial begin
        adc_conversion_complete <= 1'b0;
        adc_value               <= 16'($urandom);
        last_valid_adc_value    <= '0;
        busy                    <= '0;

        forever begin
            automatic int           operation_ticks = $urandom_range(MIN_CYCLES, MAX_CYCLES);
            automatic logic [15:0]  val             = 16'($urandom);

            @(posedge adc_read) begin end
            @(posedge clk) begin end
            busy <= 1'b1;

            repeat (operation_ticks) begin
                @(posedge clk) begin end
                if (!adc_read) begin
                    // operation aborted
                    break;
                end
            end

            if (adc_read) begin
                // randomise the result and mark the conversion as complete
                adc_value               <= val;
                last_valid_adc_value    <= val;
                adc_conversion_complete <= 1'b1;

                @(posedge clk) begin end
                adc_conversion_complete <= 1'b0;

                // randomise the adc_value signal again. I don't actually expect this to happen
                // in the actual hardware, but best to be certain that my design only samples the ADC value
                // at the correct time
                adc_value               <= 16'($urandom);
            end

            busy <= 1'b0;
        end
    end

endmodule
