/***********************************************************************
        File: radiation_sensor_digital_top.sv
 Description: Top Level module for the digital part of
              the radiation_sensor project
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

module radiation_sensor_digital_top
#(
    // see iso14443a.sv for more info on how to set this
    // using a parameter rather than hard coding it, so we can have different
    // values for synthesis and simulation (at least until we update the simulation model
    // to match what the actual hardware will do)
    // The default value of -1 causes an error on build
    parameter int signed FDT_TIMING_ADJUST = -1,

    // Version info for the sensor / ADC IP cores
    parameter int SENSOR_VERSION            = -1,
    parameter int ADC_VERSION               = -1
)
(
    // --------------------------------------------------------------
    // Signals from / to the RFID analogue front end
    // --------------------------------------------------------------

    // clk is our 13.56MHz input clock. It is recovered from the carrier wave,
    // and as such stops during pause frames. It must not have any glitches.
    input                       clk,

    // rst_n_async is an asynchronous active low reset.
    // It passes through a reset synchroniser here.
    // rst_n should be used everywhere else.
    input                       rst_n_async,

    // Every reply from the PICC that includes a CID field also includes a power indicator
    // field to tell the PCD if it's receiving enough power or not. The PCD can then adjust
    // it's power output as needed.
    //
    // The analogue block should pass the correct value in. It can change over time.
    // and is synchronised in the ISO/IEC 14443A IP core
    //
    // ISO/IEC 14443-4:2016 section 7.4 states:
    //      2'b00: PICC does not support the power level indiction
    //      2'b01: Insufficient power for full functionality
    //      2'b10: Sufficient power for full functionality
    //      2'b11: More than sufficient power for full functionality
    input           [1:0]       power_async,

    // pause_n_async is an asynchronous input from the analogue block.
    // It is essentially the digitized envelope of the carrier wave.
    // When idle pause_n_async is a 1, when a pause is detected it's a 0.
    // This signal is synchronised before use
    input                       pause_n_async,

    // lm_out is the manchester encoded data AND'ed with the subcarrier
    // this should be connected to the load modulator
    output logic                lm_out,

    // --------------------------------------------------------------
    // UID signals
    // --------------------------------------------------------------

    // The variable part of the UID, this should go to pads with weak pull ups/downs
    // that we can set with wire bonding.
    input           [2:0]       uid_variable,

    // --------------------------------------------------------------
    // Signals to / from the ADC / Sensor
    // --------------------------------------------------------------

    output logic    [2:0]       sens_config,
    output logic                sens_enable,
    output logic                sens_read,
    output logic                adc_enable,
    output logic                adc_read,
    input                       adc_conversion_complete,
    input           [15:0]      adc_value
);

    // --------------------------------------------------------------
    // UID
    // --------------------------------------------------------------

    // The full UID is the upper 29 bits of UID_FIXED
    // cocatenated with the 3 bits of uid_variable
    // {UID_FIXED[31:2], uid_variable}
    localparam logic [31:0] UID_FIXED = 32'hEFFEC700;

    // ========================================================================
    // Synchronisation of async signals
    // ========================================================================

    // syncronise our asynchronous reset
    logic rst_n;
    active_low_reset_synchroniser reset_synchroniser
    (
        .clk        (clk),
        .rst_n_in   (rst_n_async),
        .rst_n_out  (rst_n)
    );

    // The pause_n_async signal is asynchronous it can assert / deassert at any point
    // during the clock cycle. Additionally the clock will not be running during
    // a pause frame, and so pause_n_async <may> both assert and deassert between rising
    // clock edges.

    // To handle this we pass it through an active low reset synchroniser.
    // When pause_n_async goes low, both FFDs in the synchroniser are reset to 0.
    // Once pause_n_async goes high, a 1 is shifted through both FFDs. So two clock ticks
    // later we detect the rising edge, indicating the end of the pause frame.

    logic pause_n_synchronised;
    active_low_reset_synchroniser pause_n_synchroniser
    (
        .clk        (clk),
        .rst_n_in   (pause_n_async),
        .rst_n_out  (pause_n_synchronised)
    );

    logic [1:0] power;
    synchroniser
    #(
        .WIDTH      (2),
        .RESET_VAL  (2'b00)
    )
    power_synch_inst
    (
        .clk        (clk),
        .rst_n      (rst_n),
        .d          (power_async),
        .q          (power)
    );


    // ========================================================================
    // The ISO/IEC 14443A IP core
    // ========================================================================

    rx_interface #(.BY_BYTE(1)) app_rx_iface (.*);
    tx_interface #(.BY_BYTE(1)) app_tx_iface (.*);
    logic app_resend_last;

    iso14443a
    #(
        .UID_SIZE           (ISO14443A_pkg::UIDSize_SINGLE),
        .UID_INPUT_BITS     (3),
        .UID_FIXED          (UID_FIXED[31:3]),
        .FDT_TIMING_ADJUST  (FDT_TIMING_ADJUST)
    )
    iso14443a_inst
    (
        .clk                    (clk),
        .rst_n                  (rst_n),

        .uid_variable           (uid_variable),

        .power                  (power),
        .pause_n_synchronised   (pause_n_synchronised),

        .lm_out                 (lm_out),

        .app_rx_iface           (app_rx_iface),
        .app_tx_iface           (app_tx_iface),
        .app_resend_last        (app_resend_last)
    );

    // ========================================================================
    // The Adapter (converts app level 14443-4 messages into ADC/sensor signals)
    // and generates the correct responses
    // ========================================================================

    adapter
    #(
        .ISO_IEC_14443A_VERSION (iso14443a_inst.ISO_IEC_14443A_VERSION),
        .SENSOR_VERSION         (SENSOR_VERSION),
        .ADC_VERSION            (ADC_VERSION)
    )
    adapter_inst
    (
        .clk                        (clk),
        .rst_n                      (rst_n),

        .pause_n_synchronised       (pause_n_synchronised),

        .rx_iface                   (app_rx_iface),
        .tx_iface                   (app_tx_iface),
        .app_resend_last            (app_resend_last),

        .sens_config                (sens_config),
        .sens_enable                (sens_enable),
        .sens_read                  (sens_read),
        .adc_enable                 (adc_enable),
        .adc_read                   (adc_read),
        .adc_conversion_complete    (adc_conversion_complete),
        .adc_value                  (adc_value)
    );

endmodule
