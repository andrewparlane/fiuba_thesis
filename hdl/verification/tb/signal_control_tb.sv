/***********************************************************************
        File: signal_control_tb.sv
 Description: Testbench for signal_control
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

module signal_control_tb;

    import protocol_pkg::*;

    // --------------------------------------------------------------
    // Ports to DUT
    // all named the same as in the DUT, so I can use .*
    // --------------------------------------------------------------

    logic                   clk;
    logic                   rst_n;

    logic                   pause_n_synchronised;

    logic [15:0]            sync_timing;        // SET_SIGNAL or AUTO_READ
    logic [24:0]            auto_read_timing1;  // AUTO_READ only
    logic [24:0]            auto_read_timing2;  // AUTO_READ only

    // which command was received
    protocol_pkg::Command   cmd;

    // mask and value for SET_SIGNAL
    protocol_pkg::Signals   set_signals_mask;
    protocol_pkg::Signals   set_signals_value;

    // start / stop the cmd operation
    logic                   start;
    logic                   abort;

    // clear cached_adc_conversion_complete
    logic                   result_read;

    // Interface with the radiation sensor / ADC
    protocol_pkg::Signals   signals;
    logic                   adc_conversion_complete;
    logic   [15:0]          adc_value;

    // status
    logic                   busy;
    logic                   unexpected_pause;
    logic                   cached_adc_conversion_complete;
    logic   [15:0]          cached_adc_value;

    // --------------------------------------------------------------
    // DUT
    // --------------------------------------------------------------

    signal_control dut (.*);

    // --------------------------------------------------------------
    // Clock generator
    // --------------------------------------------------------------

    clock_source clock_source_inst (.*);

    // --------------------------------------------------------------
    // ADC model
    // --------------------------------------------------------------

    // adc_conversion_complete asserts somewhere between 50 and 100 ticks after adc_read asserts
    logic [15:0]    expected_adc_value;
    logic           adc_sim_busy;
    adc_sim
    #(
        .MIN_CYCLES (50),
        .MAX_CYCLES (100)
    )
    adc_sim_inst
    (
        .clk                        (clk),

        .adc_read                   (signals.adc_read),
        .adc_conversion_complete    (adc_conversion_complete),
        .adc_value                  (adc_value),

        .busy                       (adc_sim_busy),

        .last_valid_adc_value       (expected_adc_value)
    );

    // --------------------------------------------------------------
    // Signals change timings and value checks
    // --------------------------------------------------------------

    int     signal_changes_since_last_start;
    int     ticks_since_last_signals_change;
    int     ticks_since_last_pause_rising_edge;
    int     expected_sync;
    int     expected_timing1;
    int     expected_timing2;
    logic   unexpected_pause_expected;  // are we expecting the unexpected_pause output to assert
    Signals expected_signals;           // SET_SIGNAL only

    always_ff @(posedge clk, negedge rst_n) begin: timingBlock
        if (!rst_n) begin
            signal_changes_since_last_start     <= 0;
            ticks_since_last_signals_change     <= 0;
            ticks_since_last_pause_rising_edge  <= 0;
        end
        else begin: posedgeClk
            if (start) begin
                signal_changes_since_last_start <= 0;
            end

            if ($rose(pause_n_synchronised)) begin
                // pause_n_synchronised rose on the last rising edge of our clock.
                ticks_since_last_pause_rising_edge  <= 1;
            end
            else begin
                ticks_since_last_pause_rising_edge  <= ticks_since_last_pause_rising_edge + 1;
            end

            if (!$stable(signals)) begin: signalsChanged
                // signals just changed, output the values
                //$display("ticks_since_last_pause_rising_edge %d, ticks_since_last_signals_change %d",
                //          ticks_since_last_pause_rising_edge, ticks_since_last_signals_change);

                // the first time the signals change after the start pulse it's the end
                // of the sync period.
                // The second time it's the end of timing1
                // and the third and final time, it's the end of timing2

                // that is unless we aborted, in which case the signals all go to 0
                // except sens_config which stays the same, we check this in a continuous
                // assertion.
                if (!$past(abort)) begin: notAbortCheck
                    signalChangesCheck:
                    assert (signal_changes_since_last_start < 3)
                    else $error("signal_changes_since_last_start %d out of range",
                                signal_changes_since_last_start);

                    case (signal_changes_since_last_start)
                        0: begin
                            syncTimingCheck:
                            assert(ticks_since_last_pause_rising_edge == expected_sync)
                            else $error("ticks_since_last_pause_rising_edge %d, expected_sync %d",
                                        ticks_since_last_pause_rising_edge,
                                        expected_sync);

                            if (cmd == Command_AUTO_READ) begin: AutoRead
                                autoReadSignalCheck0:
                                assert($stable(signals.sens_config) &&
                                       $rose(signals.sens_enable)   &&
                                       $stable(signals.sens_read)   && !signals.sens_read   &&
                                       $rose(signals.adc_enable)    &&
                                       $stable(signals.adc_read)    && !signals.adc_read)
                                else $error("signals %p not as expected after sync for AUTO_READ", signals);
                            end
                            else begin: SetSignal
                                setSignalCheck:
                                assert(signals == expected_signals)
                                else $error("signals %p not as expected after sync for SET_SIGNAL, expecting %p", signals, expected_signals);
                            end
                        end

                        1: begin
                            timing1Check:
                            assert(ticks_since_last_signals_change == expected_timing1)
                            else $error("ticks_since_last_signals_change %d, expected_timing1 %d",
                                        ticks_since_last_signals_change,
                                        expected_timing1);

                            autoReadSignalCheck1:
                            assert($stable(signals.sens_config) &&
                                   $stable(signals.sens_enable) && signals.sens_enable  &&
                                   $rose(signals.sens_read)     &&
                                   $stable(signals.adc_enable)  && signals.adc_enable   &&
                                   $stable(signals.adc_read)    && !signals.adc_read)
                            else $error("signals %p not as expected after timing1", signals);
                        end

                        2: begin
                            timing2Check:
                            assert(ticks_since_last_signals_change == expected_timing2)
                            else $error("ticks_since_last_signals_change %d, expected_timing2 %d",
                                        ticks_since_last_signals_change,
                                        expected_timing2);

                            unexpectedPauseCheck:
                            assert(unexpected_pause == unexpected_pause_expected)
                            else $error("unexpected_pause %b, not as expected",
                                        unexpected_pause);

                            // check the signals are what we expect for an AUTO_READ
                            // AKA adc_read just asserted and nothing else changed
                            // also make sure that the other signals are as expected.
                            // If the other signals aren't reset to 0 before the auto_read command
                            // then this could fail, but we'd have other issues too if that were
                            // the case
                            autoReadSignalCheck2:
                            assert($stable(signals.sens_config) &&
                                   $stable(signals.sens_enable) && signals.sens_enable  &&
                                   $stable(signals.sens_read)   && signals.sens_read    &&
                                   $stable(signals.adc_enable)  && signals.adc_enable   &&
                                   $rose(signals.adc_read))
                            else $error("signals %p not as expected after timing2", signals);
                        end
                    endcase
                end

                signal_changes_since_last_start <= signal_changes_since_last_start + 1;

                // signals changed on the previous rising edge of our clock
                ticks_since_last_signals_change <= 1;
            end
            else begin
                ticks_since_last_signals_change <= ticks_since_last_signals_change + 1;
            end
        end
    end

    // --------------------------------------------------------------
    // Functions / Tasks
    // --------------------------------------------------------------

    // run Command_SET_SIGNAL with minimal timings and checks
    // in order to reset some of the signals to 0. This is important to do
    // before testing Command_AUTO_READ, so we can detect the correct changes
    // at the correct timings
    task reset_signals;
        sync_timing = 16'd1;
        cmd         = Command_SET_SIGNAL;

        set_signals_value.sens_config   = '0;
        set_signals_value.sens_enable   = 1'b0;
        set_signals_value.sens_read     = 1'b0;
        set_signals_value.adc_enable    = 1'b0;
        set_signals_value.adc_read      = 1'b0;
        set_signals_value.padding       = '0;

        set_signals_mask.sens_config    = '0;
        set_signals_mask.sens_enable    = 1'b1;
        set_signals_mask.sens_read      = 1'b1;
        set_signals_mask.adc_enable     = 1'b1;
        set_signals_mask.adc_read       = 1'b1;
        set_signals_mask.padding        = '0;

        expected_signals.sens_config    = signals.sens_config;  // no changes
        expected_signals.sens_enable    = 1'b0;
        expected_signals.sens_read      = 1'b0;
        expected_signals.adc_enable     = 1'b0;
        expected_signals.adc_read       = 1'b0;
        expected_signals.padding        = signals.padding; // no change

        // we need to calculate the expected_sync timing so we don't assert
        // in the timing checking block.
        // If the above signals are already 0s, then that's fine
        // since we won't detect any change, but we have no checks in place
        // in this task to ensure that the change occurs.
        expected_sync = 2;

        // pulse pause_n
        pause_n_synchronised <= 1'b0;
        @(posedge clk)
        pause_n_synchronised <= 1'b1;

        // pulse start
        start <= 1'b1;
        @(posedge clk)
        start <= 1'b0;

        // wait for the operation to complete (plus a bit)
        @(posedge clk) begin end
        wait (!busy) begin end
        repeat (10) @(posedge clk) begin end
    endtask

    // first we pulse pause, pause_to_start ticks later we pulse start
    // then we pulse pause after extra_pause_timings[i] ticks for each i
    // note: extra_pause_timings[i] for i > 0, should not be 0.
    //       this is because it would just result in a pause pulse of two ticks
    task do_valid_command(Command cmd_to_send,
                          int sync, int timing1, int timing2,
                          int pause_to_start, int extra_pause_timings [$] = '{},
                          int abort_time = -1);

        sync_timing         = 16'(sync);
        auto_read_timing1   = 25'(timing1); // only used for Command_AUTO_READ
        auto_read_timing2   = 25'(timing2); // only used for Command_AUTO_READ
        cmd                 = cmd_to_send;

        // set set_signals_mask and set_signals_value such that signals will change
        // only needed for Command_SET_SIGNAL, but may as well do it always
        std::randomize (set_signals_mask, set_signals_value) with
        {
            ((signals & ~set_signals_mask) | (set_signals_value & set_signals_mask))
                != signals;
        };

        // new signals, only needed for Command_SET_SIGNAL
        // I could just do the (signals & ~set_signals_mask) | (set_signals_value & set_signals_mask)
        // thing, but I want it to be different logic to what's in the DUT
        expected_signals.sens_config[0] = set_signals_mask.sens_config[0]   ? set_signals_value.sens_config[0]  : signals.sens_config[0];
        expected_signals.sens_config[1] = set_signals_mask.sens_config[1]   ? set_signals_value.sens_config[1]  : signals.sens_config[1];
        expected_signals.sens_config[2] = set_signals_mask.sens_config[2]   ? set_signals_value.sens_config[2]  : signals.sens_config[2];
        expected_signals.sens_enable    = set_signals_mask.sens_enable      ? set_signals_value.sens_enable     : signals.sens_enable;
        expected_signals.sens_read      = set_signals_mask.sens_read        ? set_signals_value.sens_read       : signals.sens_read;
        expected_signals.adc_enable     = set_signals_mask.adc_enable       ? set_signals_value.adc_enable      : signals.adc_enable;
        expected_signals.adc_read       = set_signals_mask.adc_read         ? set_signals_value.adc_read        : signals.adc_read;
        expected_signals.padding        = set_signals_mask.padding          ? set_signals_value.padding         : signals.padding;

        if (pause_to_start >= (sync-1)) begin
            // +2, 1 for start to be detected, 1 to get to State_SYNC
            expected_sync = pause_to_start + 2;
        end
        else begin
            expected_sync = sync;
        end

        // timing1 and timing2 periods are one tick longer than specified
        // we could have them precise but then we'd have a complication with the 0 case
        // which require additional logic to handle.
        expected_timing1 = timing1 + 1;
        expected_timing2 = timing2 + 1;

        //$display("sync_timing %d, pause_to_start %d, extra_pause_timings",
        //         sync_timing, pause_to_start, extra_pause_timings);

        // pulse pause_n
        pause_n_synchronised <= 1'b0;
        @(posedge clk)
        pause_n_synchronised <= 1'b1;

        // wait a bit
        repeat (pause_to_start) @(posedge clk) begin end

        // pulse start
        start <= 1'b1;
        @(posedge clk)
        start <= 1'b0;

        fork
            // process 1 - assert abort
            begin
                if (abort_time != -1) begin
                    repeat (abort_time) @(posedge clk) begin end
                    abort <= 1'b1;
                    @(posedge clk) begin end
                    abort <= 1'b0;
                end
            end

            // process 2 - extra_pause_timings
            begin
                // pules pause some more after the appropriate timings
                foreach (extra_pause_timings[i]) begin
                    repeat(extra_pause_timings[i]) @(posedge clk) begin end
                    pause_n_synchronised <= 1'b0;
                    @(posedge clk)
                    pause_n_synchronised <= 1'b1;
                end

                // waiting for a clock pulse here ensures that busy has asserted even if
                // extra_pause_timings is empty. And if it wasn't we just ended with a pulse
                // so there's no chance of us timing out and going !busy after this one tick
                @(posedge clk) begin end

                // sanity check we shouldn't have timed out by this point
                // only do this if we aren't testing abort
                if (abort_time == -1) begin: notAbort
                    stillBusy:
                    assert (busy) else $error("!busy at end of extra_pause_timings");
                end
            end
        join

        // wait for the operation to complete (plus a bit)
        wait (!busy && !adc_sim_busy) begin end
        repeat (10) @(posedge clk) begin end

        // if this caused an adc read, then we clear it 50% of the time to check that result_read
        // asserting works as expected. We only do 50% of the time, as it should also get cleared
        // with aborts and on the next start.
        if (cached_adc_conversion_complete) begin
            result_read <= 1'($urandom);
            @(posedge clk)
            result_read <= 1'b0;
        end

        // finally check that we saw the correct amount of changes
        // only do this if we aren't testing abort
        if (abort_time == -1) begin: notAbort2
            signalChanges:
            assert(signal_changes_since_last_start ==
                    ((cmd == Command_SET_SIGNAL) ? 1 : 3))
            else $error("signals changed %d times expected %d times",
                        signal_changes_since_last_start,
                        (cmd == Command_SET_SIGNAL) ? 1 : 3);
        end
    endtask

    task do_invalid_command();
        sync_timing         = 16'($urandom_range(10));
        auto_read_timing1   = 25'($urandom_range(10));
        auto_read_timing2   = 25'($urandom_range(10));

        std::randomize (cmd) with
        {
            cmd != Command_SET_SIGNAL;
            cmd != Command_AUTO_READ;
        };

        // pulse start
        start <= 1'b1;
        @(posedge clk)
        start <= 1'b0;
        @(posedge clk) begin end

        // if the DUT does anything, wait for it to stop
        // we have a concurrent assert to confirm that it doesn't do anything
        wait (!busy && !adc_sim_busy) begin end
        repeat (10) @(posedge clk) begin end
    endtask

    // --------------------------------------------------------------
    // Test stimulus
    // --------------------------------------------------------------

    initial begin
        pause_n_synchronised        <= 1'b1; // idle
        start                       <= 1'b0;
        abort                       <= 1'b0;
        unexpected_pause_expected   <= 1'b0;

        // reset for 5 ticks
        rst_n <= 1'b0;
        repeat (5) @(posedge clk) begin end
        rst_n <= 1'b1;
        repeat (5) @(posedge clk) begin end

        // Test 1a) Command_SET_SIGNAL with start occuring long enough after
        // the last pause that the command is handled immediately
        $display("1a) SET_SIGNAL with the sync period alread finished by the time start fires");
        repeat (10000) begin
            automatic int sync              = $urandom_range(0, 10);
            automatic int pause_to_start    = $urandom_range(sync, sync + 100);
            // we use a pulse_to_start >= sync so that we should immediately time out

            do_valid_command(Command_SET_SIGNAL,
                             sync,
                             $urandom(),    // timing1 - not used
                             $urandom(),    // timing2 - not used
                             pause_to_start);
        end

        // Test 1b) Command_SET_SIGNAL with actual sync period but no more pauses
        $display("1b) SET_SIGNAL with actual sync period but no pauses after start");
        repeat (10000) begin
            automatic int sync              = $urandom_range(10, 20);
            automatic int pause_to_start    = $urandom_range(0, sync - 2);

            do_valid_command(Command_SET_SIGNAL,
                             sync,
                             $urandom(),    // timing1 - not used
                             $urandom(),    // timing2 - not used
                             pause_to_start);
        end

        // Test 1c) Command_SET_SIGNAL with pauses after start during the sync period
        $display("1c) SET_SIGNAL with pauses during the sync period");
        repeat (10000) begin
            // sync must be >= 3 as shown below.
            // pause_to_start must be <= sync - 3 as shown below
            automatic int sync                      = $urandom_range(3, 20);
            automatic int pause_to_start            = $urandom_range(0, sync - 3);
            automatic int num_extra_pause_timings   = $urandom_range(5, 10);
            automatic int extra_pause_timings [$]   = '{};

            // After starting a new pulse (falling edge) with the extra_pause_timings, we have:
            // tick 0                   - pulse falling edge
            // tick 1                   - pulse rising edge
            // tick 2                   - rising edge seen and counter reset

            // So we have to "decide" to pulse 2 ticks before the actual timeout
            // would occur, I.E. extra_pause_timings[i] <= (sync - 2).
            // NOTE: we should ensure it's not 0, as that would result in a single pause
            //       pulse of width 2 ticks instead of two pauses. This requires sync >= 3

            // The first extra_pause_timings is special because we have to account for
            // the pause_to_start ticks, and the start pulse
            // we have:
            // tick 0                   - pulse rising edge
            // tick pause_to_start      - start rising edge
            // tick pause_to_start+1    - start seen, entering SYNC state
            // tick pause_to_start+2    - first check of the counter in the SYNC state
            //                            earliest time "signals" can change.

            // So after the start pulse we will time out in sync - (pause_to_start + 1) ticks
            // meaning extra_pause_timings[0] <= sync - (pause_to_start + 1) - 2
            // or: extra_pause_timings[0] <= sync - pause_to_start - 3
            // we do not need to enforce extra_pause_timings[0] > 0, since that would
            // simply result in a pulse starting immediately after the start pulse.
            // However it must be positive. In order to have sync - pause_to_start - 3 >= 0
            // we require that pause_to_start <= sync - 3.

            // first timing following the special first case rule.
            extra_pause_timings.push_back($urandom_range(0, sync - pause_to_start - 3));

            // add the remaining timings (between 0 and 10 of them) using the normal rule
            repeat (num_extra_pause_timings-1) begin
                extra_pause_timings.push_back($urandom_range(1, sync - 2));
            end

            do_valid_command(Command_SET_SIGNAL,
                             sync,
                             $urandom(),    // timing1 - not used
                             $urandom(),    // timing2 - not used
                             pause_to_start,
                             extra_pause_timings);
        end

        // Test 2a) Command_AUTO_READ with start occuring long enough after
        // the last pause that the command is handled immediately
        $display("2a) AUTO_READ with the sync period alread finished by the time start fires");
        repeat (10000) begin
            automatic int sync              = $urandom_range(0, 10);
            automatic int timing1           = $urandom_range(0, 100);
            automatic int timing2           = $urandom_range(0, 100);
            automatic int pause_to_start    = $urandom_range(sync, sync + 100);
            // we use a pulse_to_tart >= sync so that we should immediately time out

            // we first must ensure the signals are 0s otherwise we may be in a state where
            // some / all of the changes we expect will already be set and as such we'll not
            // detect the change
            reset_signals;

            do_valid_command(Command_AUTO_READ,
                             sync,
                             timing1,
                             timing2,
                             pause_to_start);
        end

        // Test 2b) Command_AUTO_READ with actual sync period but no more pauses
        $display("2b) AUTO_READ with actual sync period but no pauses after start");
        repeat (10000) begin
            automatic int sync              = $urandom_range(10, 20);
            automatic int timing1           = $urandom_range(0, 100);
            automatic int timing2           = $urandom_range(0, 100);
            automatic int pause_to_start    = $urandom_range(0, sync - 2);

            // reset the signals to 0s as in test 2a)
            reset_signals;

            do_valid_command(Command_AUTO_READ,
                             sync,
                             timing1,
                             timing2,
                             pause_to_start);
        end

        // Test 2c) Command_AUTO_READ with pauses after start during the sync period
        $display("2c) AUTO_READ with pauses during the sync period");
        repeat (10000) begin
            // sync must be >= 3 as shown below.
            // pause_to_start must be <= sync - 3 as shown below
            automatic int sync                      = $urandom_range(3, 20);
            automatic int timing1                   = $urandom_range(0, 100);
            automatic int timing2                   = $urandom_range(0, 100);
            automatic int pause_to_start            = $urandom_range(0, sync - 3);
            automatic int num_extra_pause_timings   = $urandom_range(5, 10);
            automatic int extra_pause_timings [$]   = '{};

            // same extra_pause_timings rules apply as in test 1b)

            // first timing following the special first case rule.
            extra_pause_timings.push_back($urandom_range(0, sync - pause_to_start - 3));

            // add the remaining timings (between 0 and 10 of them) using the normal rule
            repeat (num_extra_pause_timings-1) begin
                extra_pause_timings.push_back($urandom_range(1, sync - 2));
            end

            // reset the signals to 0s as in test 2a)
            reset_signals;

            do_valid_command(Command_AUTO_READ,
                             sync,
                             timing1,
                             timing2,
                             pause_to_start,
                             extra_pause_timings);
        end

        // Test 2d) Command_AUTO_READ with pauses after start during the sync period
        // and a pause during timing1 / timing2
        $display("2d) AUTO_READ with pauses during timing1 / timing2");
        repeat (10000) begin
            // sync must be >= 3 as shown below.
            // pause_to_start must be <= sync - 3 as shown below
            automatic int sync                      = $urandom_range(3, 20);
            automatic int timing1                   = $urandom_range(0, 10);
            automatic int timing2                   = $urandom_range(0, 10);
            automatic int pause_to_start            = $urandom_range(0, sync - 3);
            automatic int num_extra_pause_timings   = $urandom_range(5, 10);
            automatic int extra_pause_timings [$]   = '{};

            // same extra_pause_timings rules apply as in test 1b)

            // first timing following the special first case rule.
            extra_pause_timings.push_back($urandom_range(0, sync - pause_to_start - 3));

            // add the remaining timings (between 0 and 10 of them) using the normal rule
            repeat (num_extra_pause_timings-1) begin
                extra_pause_timings.push_back($urandom_range(1, sync - 2));
            end

            // add a final pause that will occur during timing1 / timing2
            // this pause must occur after the sync period, and as such it must
            // be that extra_pause_timings[$] > (sync - 2), and it must occur before
            // the timing2 timeout. which occurs after, sync + timing1 + timing2
            extra_pause_timings.push_back($urandom_range(sync - 1, sync + timing1 + timing2));

            // reset the signals to 0s as in test 2a)
            reset_signals;

            unexpected_pause_expected = 1'b1;
            do_valid_command(Command_AUTO_READ,
                             sync,
                             timing1,
                             timing2,
                             pause_to_start,
                             extra_pause_timings);
            unexpected_pause_expected = 1'b0;
        end

        // Test 3) Invalid commands
        $display("3) Invalid commands");
        repeat (10000) begin
            do_invalid_command;
        end

        // Test 4) Abort works as expected
        $display("4) Testing abort");
        repeat (10000) begin
            // sync must be >= 3
            // pause_to_start must be <= sync - 3
            automatic Command cmd_to_send           = 1'($urandom) ? Command_SET_SIGNAL : Command_AUTO_READ;
            automatic int sync                      = $urandom_range(100, 200);
            automatic int timing1                   = $urandom_range(100, 200);
            automatic int timing2                   = $urandom_range(100, 200);
            automatic int pause_to_start            = 10;
            automatic int num_extra_pause_timings   = $urandom_range(5, 10);
            automatic int extra_pause_timings [$]   = '{};
            automatic int sum                       = 0;
            automatic int abort_time;

            // same extra_pause_timings rules apply as in test 1b)

            // first timing following the special first case rule.
            extra_pause_timings.push_back($urandom_range(0, sync - pause_to_start - 3));

            // add the remaining timings (between 0 and 10 of them) using the normal rule
            repeat (num_extra_pause_timings-1) begin
                extra_pause_timings.push_back($urandom_range(1, sync - 2));
            end

            foreach (extra_pause_timings[i]) begin
                sum = sum + extra_pause_timings[i];
            end

            if (cmd_to_send == Command_SET_SIGNAL) begin
                // no timing1 / timing2
                // we may or may not end up asserting the adc_read signal and enterring the wait_for_adc state.

                // we must assert abort between 1 cycle after start (val 0)
                // and SUM(extra_pause_timings) + extra_pause_timings.size
                //                              + sync - 1
                // the extra_pause_timings.size is because we take one cycle to assert pause_n

                // I add 50 ticks to the max abort time, so that some aborts should occur during the
                // wait_for_adc state. However this means that if we don't assert adc_read, the abort
                // could come after the operation has finished. This is fine since there's nothing wrong
                // with an abort occuring when the DUT is idle.

                abort_time = $urandom_range(sum + extra_pause_timings.size + sync - 1 + 50);
            end
            else begin
                // we must assert abort in the same period as for SET_SIGNAL except
                // we have timing1 and timing2 times too, which have durations of +1 (to each)
                // additonally there's the time waiting for adc_conversion_complete to assert
                // which takes between 50 and 100 cycles, so allow an abort in the first 50 cycles of that time
                // so as to make sure the abort occurs in time.
                abort_time = $urandom_range(sum + extra_pause_timings.size + sync + timing1 + timing2 + 1 + 50);

                // add a final pause that will occur during timing1 / timing2
                // this is generated using the same rules as in test 2d) and is just
                // here to assert the unexpected_pause flag on occasion
                extra_pause_timings.push_back($urandom_range(sync - 1, sync + timing1 + timing2));
            end


            // reset the signals to 0s as in test 2a)
            reset_signals;

            unexpected_pause_expected = 1'b1;
            do_valid_command(cmd_to_send,
                             sync,
                             timing1,
                             timing2,
                             pause_to_start,
                             extra_pause_timings,
                             abort_time);
            unexpected_pause_expected = 1'b0;
        end

        // Test 5a) Command_SET_SIGNAL with long synch times
        $display("5a) SET_SIGNAL with large synch times");
        repeat (100) begin
            // we want full toggle coverage of sync_timing, we've already tested with the MSb = 0, so
            // test with MSb = 1, and the other bits random
            // pause_to_start must be <= sync - 3
            automatic int sync                      = int'({1'b1, 15'($urandom)});
            automatic int pause_to_start            = $urandom_range(0, sync - 3);
            automatic int num_extra_pause_timings   = $urandom_range(1, 3);
            automatic int extra_pause_timings [$]   = '{};

            $display("using sync: %x", sync);
            // same extra_pause_timings rules apply as in test 1b)

            // first timing following the special first case rule.
            extra_pause_timings.push_back($urandom_range(0, sync - pause_to_start - 3));

            // add the remaining timings (between 0 and 2 of them) using the normal rule
            repeat (num_extra_pause_timings-1) begin
                extra_pause_timings.push_back($urandom_range(1, sync - 2));
            end

            do_valid_command(Command_SET_SIGNAL,
                             sync,
                             $urandom(),    // timing1 - not used
                             $urandom(),    // timing2 - not used
                             pause_to_start,
                             extra_pause_timings);
        end

        // Test 5b) Command_AUTO_READ with long sync / timing1 / timing2 periods
        $display("5b) AUTO_READ with long sync / timing1 / timing2 periods");
        repeat (100) begin
            // we want full toggle coverage of sync_timing and timing1/2, we've already tested with the MSb = 0, so
            // test with MSb = 1, and the other bits random.
            // Unfortunately timing1/timing2 are 25 bits, which would lead to a timing of up to 2.4s which is unrealistic
            // to do here in simulation. So I'm limiting it to 19 bits (39 ms)
            // pause_to_start must be <= sync - 3
            automatic int sync                      = int'({1'b1, 15'($urandom)});
            automatic int timing1                   = int'({1'b1, 18'($urandom)});
            automatic int timing2                   = int'({1'b1, 18'($urandom)});
            automatic int pause_to_start            = $urandom_range(0, sync - 3);
            automatic int num_extra_pause_timings   = $urandom_range(5, 10);
            automatic int extra_pause_timings [$]   = '{};

            $display("using sync: %x, timing1: %x, timing2: %x", sync, timing1, timing2);
            // same extra_pause_timings rules apply as in test 1b)

            // first timing following the special first case rule.
            extra_pause_timings.push_back($urandom_range(0, sync - pause_to_start - 3));

            // add the remaining timings (between 0 and 10 of them) using the normal rule
            repeat (num_extra_pause_timings-1) begin
                extra_pause_timings.push_back($urandom_range(1, sync - 2));
            end

            // reset the signals to 0s as in test 2a)
            reset_signals;

            do_valid_command(Command_AUTO_READ,
                             sync,
                             timing1,
                             timing2,
                             pause_to_start,
                             extra_pause_timings);
        end

        repeat (50) @(posedge clk) begin end
        // assert reset for toggle coverage
        rst_n <= 1'b0;
        repeat (5) @(posedge clk) begin end
        $stop;
    end

    // --------------------------------------------------------------
    // Asserts
    // --------------------------------------------------------------

    // check signals in reset
    inReset:
    assert property (
        @(posedge clk)
        !rst_n |-> ((signals.sens_config == 3'b000) &&
                    !signals.sens_enable            &&
                    !signals.sens_read              &&
                    !signals.adc_enable             &&
                    !signals.adc_read               &&
                    !busy                           &&
                    !unexpected_pause               &&
                    !cached_adc_conversion_complete))
        else $error("signals in reset not as expected");

    // check that busy asserts after start with a Command_SET_SIGNAL or Command_AUTO_READ
    busyAfterStart:
    assert property (
        @(posedge clk)
        ($rose(start) && ((cmd == Command_SET_SIGNAL) || (cmd == Command_AUTO_READ))) |=>
            $rose(busy))
        else $error("busy didn't rise after start with valid command");

    // check that busy doesn't asserts after start with cmd not Command_SET_SIGNAL or Command_AUTO_READ
    busyAfterInvalidCommand:
    assert property (
        @(posedge clk)
        ($rose(start) && !((cmd == Command_SET_SIGNAL) || (cmd == Command_AUTO_READ))) |=>
            !busy)
        else $error("busy rose after invalid command");

    // check that busy doesn't asserts unless start asserts
    busyOnlyAfterStart:
    assert property (
        @(posedge clk)
        $rose(busy) |-> $past($rose(start)))
        else $error("busy rose witohut start");

    // check unexpected_pause and cached_adc_conversion_complete are low (falls / was never high)
    // after start with a valid command or an abort.
    flagsLowAfterStart:
    assert property (
        @(posedge clk)
        (($rose(start) && ((cmd == Command_SET_SIGNAL) ||
                           (cmd == Command_AUTO_READ))) ||
         abort)
            |=> (!unexpected_pause && !cached_adc_conversion_complete))
        else $error("unexpected_pause %b or cached_adc_conversion_complete %b are high after start",
                    unexpected_pause, cached_adc_conversion_complete);

    // synopsys doesn't like disable iff (!rst_n)
    logic rst;
    assign rst = !rst_n;

    // check unexpected_pause doesn't fall other than after a start or an abort
    unexpectedPauseOnlyFallsAfterStartOrAbort:
    assert property (
        @(posedge clk)
        disable iff (rst)
        $fell(unexpected_pause)
            |-> $past($rose(start) || $rose(abort)))
        else $error("unexpected_pause fell without start or abort");

    // check that we go idle after asserting abort
    abortToIdle:
    assert property (
        @(posedge clk)
        abort |=> (!busy                && !unexpected_pause    && !cached_adc_conversion_complete  &&
                   !signals.sens_enable && !signals.sens_read   &&
                   !signals.adc_enable  && !signals.adc_read    &&
                   $stable(signals.sens_config)))
        else $error("Abort asserted but signals didn't change as expected");

    // check that cached_adc_conversion_complete asserts one tick after adc_conversion_complete
    // assuming that we haven't aborted and are currently active. Also check that the cached_adc_value
    // is correct.
    adcReadsCheck:
    assert property (
        @(posedge clk)
        ($rose(adc_conversion_complete) && !abort && busy)
            |=> ($rose(cached_adc_conversion_complete) &&
                (cached_adc_value == expected_adc_value)))
        else $error("ADC read didn't go as expected");

    // check cached_adc_conversion_complete doesn't fall other than after a start, an abort or a result_read
    adcCompOnlyFallsAfterStartOrAbort:
    assert property (
        @(posedge clk)
        disable iff (rst)
        $fell(cached_adc_conversion_complete)
            |-> $past($rose(start) || $rose(abort) || $rose(result_read)))
        else $error("cached_adc_conversion_complete fell without start, abort or result_read");

    // check cached_adc_conversion_complete is low after a result_read unless adc_conversion_complete
    // asserts on the same cycle
    adcCompFallsAfterResultRead:
    assert property (
        @(posedge clk)
        disable iff (rst)
        (result_read && !adc_conversion_complete) |=> !cached_adc_conversion_complete)
        else $error("cached_adc_conversion_complete high after result_read asserted");

    // check that cached_adc_conversion_complete only asserts after adc_conversion_complete asserts
    adcReadsCheck2:
    assert property (
        @(posedge clk)
        $rose(cached_adc_conversion_complete) |-> $past($rose(adc_conversion_complete)))
        else $error("cached_adc_conversion_complete asserted without adc_conversion_complete");

    // check that cached_adc_value only changes on reset or on cached_adc_conversion_complete asserting
    cachedAdcValueStable:
    assert property (
        @(posedge clk)
        disable iff (rst)
        !$stable(cached_adc_value) |-> $rose(cached_adc_conversion_complete))
        else $error("cached_adc_value changed without cached_adc_conversion_complete");

endmodule
