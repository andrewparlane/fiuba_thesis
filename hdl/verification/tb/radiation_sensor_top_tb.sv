/***********************************************************************
        File: radiation_sensor_top_tb.sv
 Description: Testbench for the readiation_sensor_top module.
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

module radiation_sensor_top_tb;

    logic       clk;
    logic       rst_n;
    logic       rst_n_async;    // alias

    // The variable part of the UID
    // should come from flash or dip switches / wire bonding / hardcoded
    // I assume this is constant in my code. So I'd recommend only changing it
    // while this IP core is in reset. That may not be strictly necesarry, but
    // further investigation would be necesarry to be sure.
    logic [2:0] uid_variable;

    logic [1:0] power_async;
    logic       pause_n_async;
    logic       lm_out;

    assign rst_n_async = rst_n;

    radiation_sensor_top dut (.*);

    // --------------------------------------------------------------
    // The analogue sim
    // --------------------------------------------------------------
    // this contains the PCD clock source, PICC clk recovery,
    // pause_n detector and the PCDPauseNDriver.

    localparam real CLOCK_FREQ_HZ   = 13560000.0;    // 13.56MHz
    localparam real CLOCK_PERIOD_PS = 1000000000000.0 / CLOCK_FREQ_HZ;
    logic pcd_pause_n;
    analogue_sim
    #(
        .CLOCK_FREQ_HZ          (int'(CLOCK_FREQ_HZ))
    )
    analogue_sim_inst
    (
        .picc_clk               (clk),
        .pcd_pause_n            (pcd_pause_n),          // used for FDT validation
        .pause_n_async          (pause_n_async),        // goes to the DUT
        .pause_n_synchronised   ()
    );

    initial begin
        // reset for 5 ticks
        rst_n <= 1'b0;
        repeat (5) @(posedge clk) begin end
        rst_n <= 1'b1;
        repeat (5) @(posedge clk) begin end

        repeat (50) @(posedge clk) begin end
        $stop;
    end

endmodule
