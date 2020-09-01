/***********************************************************************
        File: signal_control.sv
 Description: Handle SET_SIGNAL and AUTO_READ requests
      Author: Andrew Parlane
**********************************************************************/

/*
 * This file is part of https://github.com/andrewparlane/fiuba_thesis
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

module signal_control
(
    // clk is our 13.56MHz input clock.
    input                           clk,

    // rst_n is our active low synchronised asynchronous reset signal
    input                           rst_n,

    // pause_n_synchronised is the synchronised pause_n signal.
    // since the clock stops during pause frames, we can only expect pause_n_synchronised
    // to be asserted (0) for a couple of clock ticks.
    // So we just look for rising edges (end of pause).
    // We use this to synchronise certain actions between multiple PICCs
    input                           pause_n_synchronised,

    // timings
    input           [15:0]          sync_timing,        // SET_SIGNAL or AUTO_READ
    input           [24:0]          auto_read_timing1,  // AUTO_READ only
    input           [24:0]          auto_read_timing2,  // AUTO_READ only

    // which command was received
    input protocol_pkg::Command     cmd,

    // mask and value for SET_SIGNAL
    input protocol_pkg::Signals     set_signals_mask,
    input protocol_pkg::Signals     set_signals_value,

    // start / stop the cmd operation
    input                           start,
    input                           abort,

    // clears the cached_adc_conversion_complete
    input                           result_read,

    // Interface with the radiation sensor / ADC
    output protocol_pkg::Signals    signals,
    input                           adc_conversion_complete,
    input           [15:0]          adc_value,

    // status
    output logic                    busy,
    output logic                    unexpected_pause,
    output logic                    cached_adc_conversion_complete,
    output logic    [15:0]          cached_adc_value
);

    import protocol_pkg::*;

    // detect pause_n_synchronised rising edges
    logic pause_n_synchronised_old;
    logic pause_n_rising_edge;

    always @(posedge clk, negedge rst_n) begin
        if (!rst_n) begin
            pause_n_synchronised_old <= 1'b1;
        end
        else begin
            pause_n_synchronised_old <= pause_n_synchronised;
        end
    end

    assign pause_n_rising_edge = !pause_n_synchronised_old && pause_n_synchronised;

    // cached values
    logic [15:0]    cached_sync_timing;
    logic [24:0]    cached_auto_read_timing1;
    logic [24:0]    cached_auto_read_timing2;
    Command         cached_cmd;

    // on a SET_SIGNAL command we set new_signals to: (signals & ~mask) | (value & mask)
    // then after the sync period we write that to the signals output
    Signals         new_signals;

    // State machine
    typedef enum
    {
        State_IDLE,
        State_SYNC,
        State_TIMING1,
        State_TIMING2,
        State_WAIT_FOR_ADC
    } State;

    State           state;
    logic           valid_cmd;
    logic [24:0]    counter;
    logic           starts_adc_read;

    // we only use this code for the SET_SIGNAL command and the AUTO_READ command
    assign valid_cmd = (cmd == Command_SET_SIGNAL) ||
                       (cmd == Command_AUTO_READ);

    always @(posedge clk, negedge rst_n) begin
        if (!rst_n) begin
            state                           <= State_IDLE;

            signals.sens_config             <= '0;
            signals.sens_enable             <= '0;
            signals.sens_read               <= '0;
            signals.adc_enable              <= '0;
            signals.adc_read                <= '0;
            signals.padding                 <= '0;

            counter                         <= '0;
            unexpected_pause                <= 1'b0;
            cached_adc_conversion_complete  <= 1'b0;
            cached_adc_value                <= '0;
        end
        else begin
            // always count unless overridden below.
            // We don't overflow.
            if (counter != '1) begin
                counter <= counter + 1'd1;
            end

            if (pause_n_rising_edge) begin
                if ((state == State_IDLE) || (state == State_SYNC)) begin
                    // during the SYNC stage we want to time our action
                    // to occur a certain number of ticks after the last
                    // rising edge of pause_n_synchronised. This is because
                    // all PICCs should see the same rising edge within a short
                    // period of time (depending on PVT variation). It largely depends
                    // on the analogue block, but I expect the maximum variation between
                    // PICC's will be one tick (73.75 ns).
                    // So we can use the rising edge of pause_n to synchronise action
                    // accross multiple PICCs. We restart the counter on every rising edge
                    // and set the timeout to sufficiently large that if the PCD were to
                    // want to send a SYNC command to another PICC that command would cause
                    // the counter on all PICCs to be reset. When the PCD is done, it stops
                    // sending commands and finally the counter on all the PICCs expires
                    // at aproximately the same time.

                    // we reset to 2, because it took one tick to detect the rising edge
                    // and by the time we next check this value it'll have been one tick more
                    counter <= 25'd2;
                end
                else begin
                    // In the other states we don't want to restart the counter on pauses
                    // since we aim to provide a precise time. However since there is no
                    // clock during pauses, our timing gets a bit messed up. Additionally
                    // we don't receive power during pauses and so our voltage levels will
                    // start dropping. We set a flag so we can alert the user.
                    unexpected_pause <= 1'b1;
                end
            end

            // cache the latest ADC value
            // it doesn't matter if we are in an operation or not, we may as well store the new value,
            // but we only assert cached_adc_conversion_complete if we are in State_WAIT_FOR_ADC
            if (adc_conversion_complete) begin
                cached_adc_value    <= adc_value;
            end

            // clear the cached_adc_conversion_complete when requested.
            // the result_read signal should be asserted only on Cmd_GET_RESULT
            // when cached_adc_conversion_complete is set
            if (result_read) begin
                cached_adc_conversion_complete  <= 1'b0;
            end


            // if abort is asserted, it doesn't matter what state we're in
            // just return to idle, clear the flags and reset the signals (other than sens_config)
            if (abort) begin
                state                           <= State_IDLE;
                unexpected_pause                <= 1'b0;
                cached_adc_conversion_complete  <= 1'b0;

                signals.sens_enable             <= '0;
                signals.sens_read               <= '0;
                signals.adc_enable              <= '0;
                signals.adc_read                <= '0;
            end
            else begin
                case (state)
                    State_IDLE:     begin
                        // do nothing until start asserts
                        if (start && valid_cmd) begin
                            // cache values
                            cached_sync_timing              <= sync_timing;
                            cached_auto_read_timing1        <= auto_read_timing1;
                            cached_auto_read_timing2        <= auto_read_timing2;
                            cached_cmd                      <= cmd;

                            unexpected_pause                <= 1'b0;
                            cached_adc_conversion_complete  <= 1'b0;

                            new_signals     <=  (signals            & ~set_signals_mask) |
                                                (set_signals_value  &  set_signals_mask);

                            // if this is a SET_SIGNAL command then we need to know if it will
                            // start an ADC read. This occurs if the adc_read signal asserts.
                            // which means the mask must have that bit set, for it to be able to change.
                            // the value must have that bit set, for it to be asserting, and it can't
                            // already be set.
                            // Technically adc_enable also needs to already be set / assert,
                            // but we can leave that to the PCD to ensure via correct use of SET_SIGNAL.
                            // if it's not enabled the adc_conversion_complete signal will not assert
                            // and we'll require the ABORT command to restart.
                            starts_adc_read <=  set_signals_mask.adc_read   &&
                                                set_signals_value.adc_read  &&
                                                !signals.adc_read;

                            state <= State_SYNC;
                        end
                    end

                    State_SYNC:     begin
                        // has the sync period elapsed? We use >= because if the PCD passed
                        // a sync timing of a low number of ticks (< ~256), then the counter
                        // will already have got passed that by the time we end up here.
                        if ((counter >= {9'd0, cached_sync_timing}) && !pause_n_rising_edge) begin
                            if (cached_cmd == Command_AUTO_READ) begin
                                // if this was a AUTO_READ command then enable the sensor
                                // and the ADC
                                signals.sens_enable <= 1'b1;
                                signals.adc_enable  <= 1'b1;

                                // then move on to the timing1 stage
                                state               <= State_TIMING1;

                                // restart the counter
                                counter             <= '0;
                            end
                            else begin
                                // for Command_SET_SIGNAL we set the signals as instructed.
                                signals <= new_signals;

                                // if this command starts an ADC read, then we need to wait for that to complete
                                // otherwise we return to idle.
                                state   <= starts_adc_read ? State_WAIT_FOR_ADC : State_IDLE;
                            end
                        end
                    end

                    State_TIMING1:  begin
                        // We only get here for Command_AUTO_READ
                        if (counter == cached_auto_read_timing1) begin
                            // set the sens_read signal
                            signals.sens_read <= 1'b1;

                            // move on to timing2 and reset the counter
                            state   <= State_TIMING2;
                            counter <= '0;
                        end
                    end

                    State_TIMING2:  begin
                        // We only get here for Command_AUTO_READ
                        if (counter == cached_auto_read_timing2) begin
                            // set the adc_read signal
                            signals.adc_read <= 1'b1;

                            // wait for the ADC to report conversion_complete
                            state <= State_WAIT_FOR_ADC;

                            // no need to reset the counter here
                            // it'll reset on the next pause
                        end
                    end

                    State_WAIT_FOR_ADC: begin
                        if (adc_conversion_complete) begin
                            // indicate that the conversion has completed
                            cached_adc_conversion_complete  <= 1'b1;

                            // the new value was already cached above.

                            // TODO: Reset signals here (not sens_config)?
                            //       Maybe only if cached_cmd == Command_AUTO_READ?

                            // and we're done
                            state <= State_IDLE;

                            // no need to reset the counter here
                            // it'll reset on the next pause
                        end
                    end

                    default:        begin
                        // ???
                        state <= State_IDLE;
                    end
                endcase
            end
        end
    end

    assign busy = (state != State_IDLE);

endmodule
