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
    // The value used is the one present when we start transmitting the CID field of the PCB.
    // So the AFE should prepare this value before the start of the response.
    //
    // I treat this as asynchronous but don't synchronise it. The analogue block should ensure
    // this is stable during the response.
    //
    // ISO/IEC 14443-4:2016 section 7.4 states:
    //      2'b00: PICC does not support the power level indiction
    //      2'b01: Insufficient power for full functionality
    //      2'b10: Sufficient power for full functionality
    //      2'b11: More than sufficient power for full functionality
    input           [1:0]       power,

    // pause_n_async is an asynchronous input from the analogue block.
    // It is essentially the digitized envelope of the carrier wave.
    // When idle pause_n_async is a 1, when a pause is detected it's a 0.
    // This signal is latched and synchronised before use
    input                       pause_n_async,

    // lm_out is the manchester encoded data AND'ed with the subcarrier
    // this should be connected to the load modulator
    output logic                lm_out,

    // the version of the AFE, must be constant
    input           [3:0]       afe_version,

    // --------------------------------------------------------------
    // UID signals
    // --------------------------------------------------------------

    // The variable part of the UID, this should go to pads with weak pull ups/downs
    // that we can set with wire bonding.
    input           [2:0]       uid_variable,

    // --------------------------------------------------------------
    // Signals to / from the ADC / Sensor
    // --------------------------------------------------------------

    input           [3:0]       sens_version,           // the version of the sensor, must be constant
    output logic    [2:0]       sens_config,
    output logic                sens_enable,
    output logic                sens_read,

    // All these are asynchronous (except adc_version which is constant). adc_conversion_complete_async
    // is synchronised, and adc_value is not read until that asserts. The ADC should ensure
    // that adc_value is stable from when adc_conversion_complete_async asserts until a new read
    // is started or the adc is disabled.
    input           [3:0]       adc_version,            // the version of the ADC, must be constant
    output logic                adc_enable,
    output logic                adc_read,
    input                       adc_conversion_complete_async,
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

    // To handle this we first latch the signal, and then pass that through a synchroniser.
    // see pause_n_latch_and_synchroniser.sv for more details
    logic pause_n_synchronised;
    pause_n_latch_and_synchroniser pause_n_latch_sync
    (
        .clk                    (clk),
        .rst_n                  (rst_n),
        .pause_n_async          (pause_n_async),
        .pause_n_synchronised   (pause_n_synchronised)
    );

    logic adc_conversion_complete_sync;
    synchroniser adc_sync
    (
        .clk    (clk),
        .rst_n  (rst_n),
        .d      (adc_conversion_complete_async),
        .q      (adc_conversion_complete_sync)
    );

    // ========================================================================
    // The ISO/IEC 14443A IP core
    // ========================================================================

    rx_interface #(.BY_BYTE(1)) app_rx_iface (.*);
    tx_interface #(.BY_BYTE(1)) app_tx_iface (.*);
    logic app_resend_last;
    logic [3:0] iso14443a_version;

    iso14443a
    #(
        .UID_SIZE           (ISO14443A_pkg::UIDSize_SINGLE),
        .UID_INPUT_BITS     (3),
        .UID_FIXED          (UID_FIXED[31:3]),

        // ISO/IEC 14443-3A requires a specific number of ticks between the end of the last pause
        // of a PCD->PICC message and the first edge of lm_out of the reply. The margin of error
        // is +400ns. The iso14443a IP core compensates for all internal (to that IP core) delays
        // so here we just have to compensate for delays external to that block:
        //      pcd_pause_n -> pause_n_async:
        //          This is defined by the behaviour of the AFE. I require it to be < 300ns
        //      pause_n_async internal (to this design) propagation delay:
        //          This is constrained in synthesis to 5ns.
        //      delays in the pause_n_latch_and_synchroniser:
        //          This is 2 - 3 clock periods, depending on when the pause_n_async's deasserting
        //          edge occurs in relation to the rising edge of the clock.
        //      lm_out internal (to this design) propagation delay.
        //          This is constrained in synthesis to 5ns.
        //      lm_out external (to this design) propagation delay.
        //          This should be as low as possible
        //      clock uncertainty
        //          This also should be as low as possible.
        // In total this is a minimum of 2 ticks, and a maximum of 3 ticks + 310ns + a bit for the last
        // two parts. We can compensate for the 2 ticks, but since we can't send the reply early
        // we can't compensate for any more.
        .FDT_TIMING_ADJUST  (2) // compensate for 2 clock periods of delay in pause_n_latch_and_synchroniser
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
        .app_resend_last        (app_resend_last),

        .iso14443a_version      (iso14443a_version)
    );

    // ========================================================================
    // The Adapter (converts app level 14443-4 messages into ADC/sensor signals)
    // and generates the correct responses
    // ========================================================================

    adapter adapter_inst
    (
        .clk                                    (clk),
        .rst_n                                  (rst_n),

        .pause_n_synchronised                   (pause_n_synchronised),

        .rx_iface                               (app_rx_iface),
        .tx_iface                               (app_tx_iface),
        .app_resend_last                        (app_resend_last),

        .sens_config                            (sens_config),
        .sens_enable                            (sens_enable),
        .sens_read                              (sens_read),
        .adc_enable                             (adc_enable),
        .adc_read                               (adc_read),
        .adc_conversion_complete                (adc_conversion_complete_sync),
        .adc_value                              (adc_value),

        .const_iso_iec_14443a_digital_version   (iso14443a_version),
        .const_iso_iec_14443a_AFE_version       (afe_version),
        .const_sensor_version                   (sens_version),
        .const_adc_version                      (adc_version)
    );

endmodule
