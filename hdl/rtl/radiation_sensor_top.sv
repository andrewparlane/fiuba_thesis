/***********************************************************************
        File: radiation_sensor_top.sv
 Description: Top Level module for the radiation_sensor project
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

// SDC: create_clock - 13.56MHz +/- 7KHz + extra jitter?

module radiation_sensor_top
(
    // clk is our 13.56MHz input clock. It is recovered from the carrier wave,
    // and as such stops during pause frames. It must not have any glitches.
    input                       clk,

    // rst_n_async is an asynchronous active low reset.
    // It passes through a reset synchroniser here.
    // rst_n should be used everywhere else.
    input                       rst_n_async,

    // The variable part of the UID
    input [2:0]                 uid_variable,

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
    input [1:0]                 power_async,

    // pause_n_async is an asynchronous input from the analogue block.
    // It is essentially the digitized envelope of the carrier wave.
    // When idle pause_n_async is a 1, when a pause is detected it's a 0.
    // This signal is synchronised before use
    input                       pause_n_async,

    // lm_out is the manchester encoded data AND'ed with the subcarrier
    // this should be connected to the load modulator
    output logic                lm_out
);

    // the 3 LSbs are variable
    localparam logic [31:0] UID_TOTAL = 32'hEFFEC700;

    logic rst_n;
    active_low_reset_synchroniser reset_synchroniser
    (
        .clk        (clk),
        .rst_n_in   (rst_n_async),
        .rst_n_out  (rst_n)
    );

    rx_interface #(.BY_BYTE(1)) app_rx_iface (.*);
    tx_interface #(.BY_BYTE(1)) app_tx_iface (.*);
    logic app_resend_last;

    assign app_tx_iface.data_valid = 1'b0;

    // TODO: What to do about the synchronisation
    //       I think we should synchronise everything here and not in
    //       iso14443a.sv, but that means:
    //          explaining correctly what needs to be done in the docs / comments
    //          modifying iso14443a_tb to synchronise stuff

    iso14443a
    #(
        .UID_SIZE           (ISO14443A_pkg::UIDSize_SINGLE),
        .UID_INPUT_BITS     (3),
        .UID_FIXED          (UID_TOTAL[31:3]),
        // TODO: Use correct FDT_TIMING_ADJUST
        .FDT_TIMING_ADJUST  (0)
    )
    iso14443a_inst
    (
        .clk                (clk),
        .rst_n_async        (rst_n_async),

        .uid_variable       (uid_variable),

        .power_async        (power_async),
        .pause_n_async      (pause_n_async),

        .lm_out             (lm_out),

        .app_rx_iface       (app_rx_iface),
        .app_tx_iface       (app_tx_iface),
        .app_resend_last    (app_resend_last)
    );

endmodule
