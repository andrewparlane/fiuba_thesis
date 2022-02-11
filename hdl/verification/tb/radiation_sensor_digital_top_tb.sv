/***********************************************************************
        File: radiation_sensor_digital_top_tb.sv
 Description: Testbench for the readiation_sensor_digital_top module.
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

module radiation_sensor_digital_top_tb;

    import protocol_pkg::*;
    import std_block_address_pkg::StdBlockAddress;

    // --------------------------------------------------------------
    // Timing
    // --------------------------------------------------------------

    // We don't know what the actual clock frequency the PCD will use. To be in spec
    // it has to be 13.56 MHz +/- 7KHz. For the FDT timing adjust we must use the MAX
    // possible period, and so the min possible frequency
    localparam real MIN_CLOCK_FREQ_HZ   = 13560000.0 - 7000.0;
    localparam real MAX_CLOCK_PERIOD_PS = 1000000000000.0 / MIN_CLOCK_FREQ_HZ;

    // --------------------------------------------------------------
    // Ports to DUT
    // all named the same as in the DUT, so I can use .*
    // --------------------------------------------------------------

    // these two aren't actually passed into the DUT, but must match the versions specified internally.
    // I could set them automatically using heirarchical accesses, but I think I'd prefer the testbench
    // to fail after an IP core version change, to remind me / whoever else is working on this to check
    // the changes and see if this testbench requires any changes.
    localparam logic [7:0]  ADAPTER_VERSION         = 8'h01;
    localparam logic [3:0]  ISO_IEC_14443A_VERSION  = 4'h1;     // digital

    logic           clk;
    logic           rst_n_async;

    logic [1:0]     power;
    logic           pause_n_async;
    logic           lm_out;

    logic [3:0]     afe_version;

    logic [2:0]     uid_variable;

    logic [3:0]     sens_version;
    logic [2:0]     sens_config;
    logic           sens_enable;
    logic           sens_read;
    logic [3:0]     adc_version;
    logic           adc_enable;
    logic           adc_read;
    logic           adc_conversion_complete_async;
    logic [15:0]    adc_value;

    logic rst_n; // alias
    assign rst_n_async = rst_n;
    // --------------------------------------------------------------
    // DUT
    // --------------------------------------------------------------

    radiation_sensor_digital_top dut (.*);

    // --------------------------------------------------------------
    // UID
    // --------------------------------------------------------------

    // hardcoded into the DUT, bottom 3 bits are variable, upper 29 bits are fixed
    localparam logic [31:0] UID_FIXED = 32'hEFFEC700;

    // our UID class instance
    uid_pkg::FixedSizeUID
    #(
        .UID_SIZE       (ISO14443A_pkg::UIDSize_SINGLE),
        .UID_FIXED_BITS (29),
        .UID_FIXED      (UID_FIXED[31:3])
    ) picc_uid;

    // updated manually when we change picc_uid, it'd be nice to automate this
    logic [31:0] full_uid;

    // assign the variable part of the UID from the full UID (this goes to the DUT)
    assign uid_variable = full_uid[2:0];

    // --------------------------------------------------------------
    // The analogue sim
    // --------------------------------------------------------------
    // this contains the PCD clock source, PICC clk recovery,
    // pause_n detector and the PCDPauseNDriver.

    localparam real CLOCK_FREQ_HZ       = 13560000.0;    // 13.56MHz
    localparam real CLOCK_PERIOD_PS     = 1000000000000.0 / CLOCK_FREQ_HZ;
    localparam int  CLOCK_PERIOD_PS_INT = int'(CLOCK_PERIOD_PS);

    logic pcd_pause_n;
    analogue_sim
    #(
        .CLOCK_FREQ_HZ          (int'(CLOCK_FREQ_HZ))
    )
    analogue_sim_inst
    (
        .rst_n                  (rst_n),
        .picc_clk               (clk),
        .pcd_pause_n            (pcd_pause_n),          // used for FDT validation
        .pause_n_async          (pause_n_async),        // goes to the DUT
        .pause_n_synchronised   ()
    );

    // --------------------------------------------------------------
    // ADC model
    // --------------------------------------------------------------

    // these must be larger than max_rx_msg_ticks which is currently 22500
    localparam int ADC_SIM_MIN_CYCLES = 25000;
    localparam int ADC_SIM_MAX_CYCLES = 35000;

    logic [15:0]    expected_adc_value;
    logic           adc_sim_busy;
    adc_sim
    #(
        .MIN_CYCLES     (ADC_SIM_MIN_CYCLES),
        .MAX_CYCLES     (ADC_SIM_MAX_CYCLES)
    )
    adc_sim_inst
    (
        .clk                        (clk),

        .adc_read                   (adc_read),
        .adc_conversion_complete    (adc_conversion_complete_async),
        .adc_value                  (adc_value),

        .busy                       (adc_sim_busy),
        .last_valid_adc_value       (expected_adc_value)
    );

    // ----------------------------------------------------------------
    // Signal tracking
    // ----------------------------------------------------------------

    // package the current signals into the Signals struct for easier use
    Signals signals;
    assign signals.sens_config  = sens_config;
    assign signals.sens_enable  = sens_enable;
    assign signals.sens_read    = sens_read;
    assign signals.adc_enable   = adc_enable;
    assign signals.adc_read     = adc_read;
    assign signals.padding      = '0;

    // We don't bother tracking timing here, just that the signals change as expected
    // we've proved the timing works in signal_control_tb and adapter_tb.
    // The main reason for this is that the EOC is detected after different times depending
    // on value of the last bit of the message, which is the parity bit of the last byte of the CRC
    // so figuring that out to determine how many ticks it is before EOC is detected, and hence
    // the minimum pause time is a fair bit of effort, for no real gain
    typedef struct
    {
        Signals change_mask;
        Signals new_value;
    } Event;

    longint last_pause_time;
    longint last_event_time;

    Event expected_events[$] = '{};

    always_ff @(posedge clk, negedge rst_n) begin
        if (!rst_n) begin
            last_event_time = '0;
        end
        else begin
            if (!$stable(sens_config)       ||
                !$stable(sens_enable)       ||
                !$stable(sens_read)         ||
                !$stable(adc_enable)        ||
                !$stable(adc_read)) begin: eventOccurred

                // event occurred construct the Event
                automatic Event actual;

                last_event_time                     <= $time;

                //$display("event ocurred, current state: %p", signals);

                actual.change_mask.sens_config[0]   = !$stable(sens_config[0]);
                actual.change_mask.sens_config[1]   = !$stable(sens_config[1]);
                actual.change_mask.sens_config[2]   = !$stable(sens_config[2]);
                actual.change_mask.sens_enable      = !$stable(sens_enable);
                actual.change_mask.sens_read        = !$stable(sens_read);
                actual.change_mask.adc_enable       = !$stable(adc_enable);
                actual.change_mask.adc_read         = !$stable(adc_read);
                actual.change_mask.padding          = '0;

                actual.new_value                = signals;

                eventExpected:
                assert (expected_events.size()) else $error("Event %p occurred but nothing expected", actual);

                if (expected_events.size()) begin: eventCheck
                    automatic Event expected = expected_events.pop_front;
                    automatic logic res;

                    // don't care about padding
                    expected.change_mask.padding    = '0;
                    expected.new_value.padding      = '0;

                    // mask and value must always be correct
                    res = (actual.new_value     == expected.new_value) &&
                          (actual.change_mask   == expected.change_mask);

                    eventAsExpected:
                    assert (res) else $error("Event %p occurred but doesn't match expected %p", actual, expected);
                end
            end
        end
    end

    Event   new_expected_events[$] = '{};
    logic   cmd_valid;
    Command cmd;

    always @(posedge clk) begin
        // the DUT only update the signal_control module on detecting EOC
        // We update the expected events one tick later, this is because the abort command needs to flush
        // old events, but if an event occurs on the same tick that the abort is asserted we don't want to
        // miss it.
        if ($past(dut.app_rx_iface.eoc)) begin
            if (cmd_valid) begin
                if ((cmd == Command_SET_SIGNAL) ||
                    (cmd == Command_AUTO_READ)) begin
                    foreach (new_expected_events[i]) begin
                        expected_events.push_back(new_expected_events[i]);
                    end
                end
                else if (cmd == Command_ABORT) begin
                    automatic Event e;
                    // we are aborting so clear all expected events and replace them with one
                    // where all the signals deassert
                    new_expected_events         = '{};

                    // sens_config stays the same
                    e.new_value.sens_config     = signals.sens_config;
                    // the others reset to 0;
                    e.new_value.sens_enable     = 1'b0;
                    e.new_value.sens_read       = 1'b0;
                    e.new_value.adc_enable      = 1'b0;
                    e.new_value.adc_read        = 1'b0;

                    // the change mask is only those bits that actually change (ignoring padding)
                    e.change_mask               = signals ^ e.new_value;
                    e.change_mask.padding       = '0;

                    if (e.change_mask) begin
                        // push it and delete all others
                        expected_events = '{e};
                    end
                    else begin
                        // nothing is actually changing so just delete any other pending events
                        expected_events = '{};
                    end
                end
            end
        end
    end

    // ----------------------------------------------------------------
    // pause_n_synchronised monitoring
    // ----------------------------------------------------------------

    always_ff @(posedge dut.pause_n_synchronised, negedge rst_n) begin
        if (!rst_n) begin
            last_pause_time <= 0ns;
        end
        else begin
            last_pause_time <= $time;
        end
    end


    // --------------------------------------------------------------
    // The driver / queue / etc... for the pause_n_synchronised input
    // --------------------------------------------------------------

    // driver, note the actual driver is in the analogue_sim above
    typedef pcd_pause_n_driver_pkg::PCDPauseNDriver                             RxDriverType;

    // Rx Transactions
    typedef pcd_pause_n_transaction_pkg::PCDPauseNTransaction                   RxTransType;
    typedef rx_transaction_converter_pkg::RxByteToPCDPauseNTransactionConverter RxTransConvType;

    // the send queue
    typedef RxTransType                                                     RxTransQueueType [$];
    typedef wrapper_pkg::Wrapper #(.Type(RxTransQueueType))                 RxQueueWrapperType;
    RxQueueWrapperType                                                      rx_send_queue;

    // --------------------------------------------------------------
    // The monitor for the lm_out (load modulator) signal
    // --------------------------------------------------------------

    // monitor (produces TxBitTransactions)
    typedef load_modulator_monitor_pkg::LoadModulatorMonitor                TxMonitorType;
    TxMonitorType                                                           tx_monitor;

    // Tx Transactions
    typedef tx_bit_transaction_pkg::TxBitTransaction                        TxTransType;
    typedef tx_transaction_converter_pkg::TxByteToBitTransactionConverter   TxTransConvType;

    // and the recv_queue
    typedef TxTransType                                                     TxTransQueueType [$];
    typedef wrapper_pkg::Wrapper #(.Type(TxTransQueueType))                 TxQueueWrapperType;
    TxQueueWrapperType                                                      tx_recv_queue;

    // interface
    load_modulator_iface                                                    lm_iface (.*);
    assign lm_iface.lm = lm_out;

    // --------------------------------------------------------------
    // FDT verification
    // --------------------------------------------------------------

    // Timings, from ISO/IEC 14443-3:2016 section 6.2.1.1
    localparam int FDT_LAST_BIT_0 = 1172;
    localparam int FDT_LAST_BIT_1 = 1236;

    logic last_rx_bit;
    assign last_rx_bit = dut.iso14443a_inst.part3.framing_inst.last_rx_bit;

    // measure the time between the rising edge of pcd_pause_n
    // and the rising edge of data_valid

    // this is a time in ps (`timescale)
    longint lastPCDPauseRiseTime;

    always_ff @(posedge pcd_pause_n) lastPCDPauseRiseTime <= $time;

    initial begin: fdtVerificationBlock
        forever begin: foreverLoop
            automatic longint diff;
            automatic longint expected;

            // wait for the start of the next Rx frame
            // this ensure we don't check the fdt time on any lm_out pulses other than the first
            @(posedge pcd_pause_n) begin end

            // wait for the start of the reply
            // it doesn't matter if there was no reply to a message, we just get here on the next
            // actual reply. lastPCDPauseRise has been updated for the last rise of the last rx message
            @(posedge lm_out) begin end

            diff        = $time - lastPCDPauseRiseTime;
            expected    = CLOCK_PERIOD_PS * (last_rx_bit ? FDT_LAST_BIT_1 : FDT_LAST_BIT_0);

            // ISO/IEC 14443-3:2016 section 6.2.1.1 requires that the PICC ensures a FDT of
            // the between the value calculated above (expected) and that value + 0.4us.
            // There are several delays that eat into that 400ns margin, in this testbench
            // we only vary two of them (pause_n_deasserts_after_ps, and the delay in the
            // pause_n_latch_and_synchroniser which varies between 2 and 3 periods depending
            // on when pause_n_async deasserts in relation to the clock). These two delays
            // should total a max of 373.78ns. So we check here that the FDT time is between
            // the expected value and that value + 374ns.

            fdtTime: assert ((diff > expected) &&
                             (diff < (expected + (374 * 1000))))
                else $error("Tx started at %d ps, lastPCDPauseRiseTime %d ps, diff %d, expected %d",
                            $time, lastPCDPauseRiseTime, diff, expected);
        end
    end

    // ----------------------------------------------------------------
    // Extend AppCommsTestsSequence to do TB specific stuff
    // ----------------------------------------------------------------

    class RadSensDigTop_TbSequence
    extends app_comms_tests_sequence_pkg::AppCommsTestsSequence
    #(
        .RxTransType        (RxTransType),
        .TxTransType        (TxTransType),
        .RxTransConvType    (RxTransConvType),
        .TxTransConvType    (TxTransConvType),
        .RxDriverType       (RxDriverType),
        .TxMonitorType      (TxMonitorType),

        .ADC_SIM_MIN_CYCLES         (ADC_SIM_MIN_CYCLES),
        .ADC_SIM_MAX_CYCLES         (ADC_SIM_MAX_CYCLES)
    );

        // constructor
        function new(uid_pkg::UID               _picc_uid,
                     TransGenType               _rx_trans_gen,
                     TransGenType               _tx_trans_gen,
                     RxTransConvType            _rx_trans_conv,
                     TxTransConvType            _tx_trans_conv,
                     RxQueueWrapperType         _rx_send_queue,
                     TxQueueWrapperType         _tx_recv_queue,
                     RxDriverType               _rx_driver,
                     TxMonitorType              _tx_monitor,
                     int                        _reply_timeout,
                     int                        _max_rx_msg_ticks);

            super.new(_picc_uid,
                      _rx_trans_gen,
                      _tx_trans_gen,
                      _rx_trans_conv,
                      _tx_trans_conv,
                      _rx_send_queue,
                      _tx_recv_queue,
                      _rx_driver,
                      _tx_monitor,
                      _reply_timeout,
                      _max_rx_msg_ticks,
                      100);                 // TODO: Run optimised builds and test with more than 100 loops per test

        endfunction

        virtual task do_reset;
            rst_n <= 1'b0;
            repeat (5) @(posedge clk) begin end
            rst_n <= 1'b1;
            repeat (5) @(posedge clk) begin end
        endtask

        function void specific_target_callback(SpecificTargetEventCode ec, int arg=0);
            if ((ec == SpecificTargetEventCode_ENTERED_STATE) ||
                (ec == SpecificTargetEventCode_REMAINING_IN_STATE)) begin
                automatic State state = State'(arg);
                //$display("Event Code %s, %s", ec.name, state.name);
                check_state(state);
            end
            else begin
                $error("Unknown event code %s", ec.name);
            end
        endfunction

        function void check_state (State state);
            ISO14443A_pkg::InitialisationState  initState;
            logic                               initStar;
            logic                               allow_pps;

            initState   = ISO14443A_pkg::InitialisationState'(dut.iso14443a_inst.part3.initialisation_inst.state);
            initStar    = dut.iso14443a_inst.part3.initialisation_inst.state_star;
            allow_pps   = dut.iso14443a_inst.part4.allow_pps;

            case (state)
                State_IDLE:                 isIdle:         assert ((initState == ISO14443A_pkg::InitialisationState_IDLE)      && !initStar)   else $error("DUT not in correct state expected State_IDLE, 0 got %s, %b",                               initState.name, initStar);
                State_READY:                isReady:        assert ((initState == ISO14443A_pkg::InitialisationState_READY)     && !initStar)   else $error("DUT not in correct state expected State_READY, 0 got %s, %b",                              initState.name, initStar);
                State_ACTIVE:               isActive:       assert ((initState == ISO14443A_pkg::InitialisationState_ACTIVE)    && !initStar)   else $error("DUT not in correct state expected State_ACTIVE, 0 got %s, %b",                             initState.name, initStar);
                State_HALT:                 isHalt:         assert ((initState == ISO14443A_pkg::InitialisationState_IDLE)      &&  initStar)   else $error("DUT not in correct state expected State_IDLE, 1 got %s, %b",                               initState.name, initStar);
                State_READY_STAR:           isReadyStar:    assert ((initState == ISO14443A_pkg::InitialisationState_READY)     &&  initStar)   else $error("DUT not in correct state expected State_READY, 1 got %s, %b",                              initState.name, initStar);
                State_ACTIVE_STAR:          isActiveStar:   assert ((initState == ISO14443A_pkg::InitialisationState_ACTIVE)    &&  initStar)   else $error("DUT not in correct state expected State_ACTIVE, 1 got %s, %b",                             initState.name, initStar);
                State_PROTOCOL_PPS_ALLOWED: isProtocol1:    assert ((initState == ISO14443A_pkg::InitialisationState_PROTOCOL)  &&  allow_pps)  else $error("DUT not in correct state expected State_PROTOCOL_PPS_ALLOWED, got %s, %b, allow_pps %b",   initState.name, initStar, allow_pps);
                State_PROTOCOL_STD_COMMS:   isProtocol2:    assert ((initState == ISO14443A_pkg::InitialisationState_PROTOCOL)  && !allow_pps)  else $error("DUT not in correct state expected State_PROTOCOL_STD_COMMS, got %s, %b, allow_pps %b",     initState.name, initStar, allow_pps);
            endcase
        endfunction

        virtual protected function void set_power_input(logic [1:0] _power);
            power = _power;
        endfunction

        // pure virtual, must be overwritten
        virtual function logic verify_dut_cid(logic [3:0] expected);
            cidAsExpected:
            assert(dut.iso14443a_inst.part4.our_cid == expected) else $error("DUT's CID is %d expected %d", dut.iso14443a_inst.part4.our_cid, expected);
            return dut.iso14443a_inst.part4.our_cid == expected;
        endfunction

        // pure virtual, must be overwritten
        virtual task wait_for_ticks_since_last_pause(int ticks);
            longint ps = longint'(ticks) * CLOCK_PERIOD_PS;
            while ($time < (last_pause_time + ps)) begin
                @(posedge clk) begin end
            end
        endtask

        // pure virtual, must be overwritten
        virtual task wait_for_signal_control_idle;
            wait (!dut.adapter_inst.signal_control_busy) @(posedge clk) begin end
        endtask

        // pure virtual, must be overwritten
        virtual function logic get_signal_control_busy;
            return dut.adapter_inst.signal_control_busy;
        endfunction

        // pure virtual, must be overwritten
        virtual function Signals get_current_signals;
            return signals;
        endfunction

        // pure virtual, must be overwritten
        virtual function logic [15:0] get_last_read_adc_value;
            return expected_adc_value;
        endfunction

        // pure virtual, must be overwritten
        virtual function IdentifyReplyArgs get_identify_reply_args;
            automatic IdentifyReplyArgs identify_reply_args;

            identify_reply_args.protocol_version        = PROTOCOL_VERSION;
            identify_reply_args.adapter_version         = ADAPTER_VERSION;
            identify_reply_args.iso_iec_14443a_version  = {ISO_IEC_14443A_VERSION,
                                                           afe_version};
            identify_reply_args.sensor_adc_version      = {sens_version,
                                                           adc_version};

            return identify_reply_args;
        endfunction

        // ====================================================================
        // sending tasks
        // ====================================================================

        // override this so we can randomise the AFE behaviour for FDT verification
        virtual task send_transaction (rx_byte_transaction_pkg::RxByteTransaction byte_trans,
                                       EventMessageID mid);
            int pcd_pause_len;
            int pause_n_asserts_after_ps;
            int pause_n_deasserts_after_ps;
            int clock_stops_after_ps;
            int clock_starts_after_ps;

            std::randomize(pcd_pause_len,
                           pause_n_asserts_after_ps, pause_n_deasserts_after_ps,
                           clock_stops_after_ps, clock_starts_after_ps)
            with
            {
                // ISO/IEC 14443-2A:2016 section 8.1.2.1
                // figure 3 and table 4. PCD pause length is T1. The time from when it starts
                // transmitting a pause until it starts stopping to transmit a pause.
                // My DUT shouldn't care about this length though, so I've increased the tested
                // range. This gives more flexibility to the other parameters, ensuring we test
                // larger ranges of those.
                pcd_pause_len >= 10;
                pcd_pause_len <= 50;

                // Pause Detector Requirements
                pause_n_asserts_after_ps >= 0;
                pause_n_asserts_after_ps < (pcd_pause_len*CLOCK_PERIOD_PS_INT);
                pause_n_deasserts_after_ps >= 0;
                pause_n_deasserts_after_ps < 300*1000;  // 300ns

                // Clock recovery requirements
                clock_stops_after_ps >= 0;
                clock_stops_after_ps < (pcd_pause_len*CLOCK_PERIOD_PS_INT);
                clock_starts_after_ps >= 0;
                clock_starts_after_ps < pause_n_deasserts_after_ps;

                // there's some simulation errors where we get the wrong number of ticks
                // if the clock/pause starts/stops exactly on an edge. So make sure that doesn't happen
                (clock_stops_after_ps*2 % CLOCK_PERIOD_PS_INT) != 0;
                (clock_starts_after_ps*2 % CLOCK_PERIOD_PS_INT) != 0;
                (pause_n_asserts_after_ps*2 % CLOCK_PERIOD_PS_INT) != 0;
                (pause_n_deasserts_after_ps*2 % CLOCK_PERIOD_PS_INT) != 0;
            };
/*
            $display("\nUsing:");
            $display("  PCD pause length     %d ticks", pcd_pause_len);
            $display("  pause_n_asserts_after   %d ps", pause_n_asserts_after_ps);
            $display("  pause_n_deasserts_after %d ps", pause_n_deasserts_after_ps);
            $display("  clock_stops_after       %d ps", clock_stops_after_ps);
            $display("  clock_starts_after      %d ps", clock_starts_after_ps);
            $display("========================================"); */

            analogue_sim_inst.set_pause_ticks(pcd_pause_len);
            analogue_sim_inst.set_params(.clock_stops                   (1'b1),
                                         .clock_stops_after_ps          (clock_stops_after_ps),
                                         .clock_starts_after_ps         (clock_starts_after_ps),
                                         .pause_n_asserts_after_ps      (pause_n_asserts_after_ps),
                                         .pause_n_deasserts_after_ps    (pause_n_deasserts_after_ps));

            super.send_transaction(byte_trans, mid);
        endtask

        // ====================================================================
        // send message verify reply tasks
        // ====================================================================

        virtual task send_app_set_signal_request_verify_reply(StdBlockAddress addr, SetSignalRequestArgs request_args, StatusReplyArgs reply_args);
            automatic Event e;

            // clear the new_expected_events queue
            new_expected_events = '{};

            // if we expect the signal_control module to already be busy
            // don't add new events, as they won't occur.
            if (!reply_args.flags.already_busy) begin
                // the signals changing event
                // the new value is calculated as normal
                e.new_value                 = (signals & (~request_args.mask)) | (request_args.value & request_args.mask);

                // the change mask is only those bits that actually change (ignoring padding)
                e.change_mask               = signals ^ e.new_value;
                e.change_mask.padding       = '0;

                if (e.change_mask) begin
                    // signals will actually change
                    new_expected_events = '{e};
                end

                cmd         = Command_SET_SIGNAL;
                cmd_valid   = 1'b1;
            end

            super.send_app_set_signal_request_verify_reply(addr, request_args, reply_args);
            cmd_valid = 1'b0;
        endtask

        virtual task send_app_auto_read_request_verify_reply(StdBlockAddress addr, AutoReadRequestArgs request_args, StatusReplyArgs reply_args);
            automatic Event e;

            // clear the new_expected_events queue
            new_expected_events = '{};

            // if we expect the signal_control module to already be busy
            // or we expect the DUT to return an error (invalid start state)
            // don't add new events, as they won't occur.
            if (!reply_args.flags.already_busy && !reply_args.flags.error) begin
                // at the end of the sync period sens_enable and adc_enable assert
                e.new_value                 = '0;
                // sens_config stays the same
                e.new_value.sens_config     = signals.sens_config;
                // sens_enable and adc_enable assert
                e.new_value.sens_enable     = 1'b1;
                e.new_value.adc_enable      = 1'b1;

                // only sens_enable and adc_enable change
                e.change_mask               = '0;
                e.change_mask.sens_enable   = 1'b1;
                e.change_mask.adc_enable    = 1'b1;

                new_expected_events.push_back(e);

                // at the end of timing1 sens_read asserts
                e.new_value.sens_read       = 1'b1;
                e.change_mask               = '0;
                e.change_mask.sens_read     = 1'b1;

                new_expected_events.push_back(e);

                // at the end of timing2 adc_read asserts
                e.new_value.adc_read        = 1'b1;
                e.change_mask               = '0;
                e.change_mask.adc_read      = 1'b1;

                new_expected_events.push_back(e);

                cmd         = Command_AUTO_READ;
                cmd_valid   = 1'b1;
            end

            super.send_app_auto_read_request_verify_reply(addr, request_args, reply_args);
            cmd_valid = 1'b0;
        endtask

        virtual task send_app_abort_request_verify_reply(StdBlockAddress addr, StatusReplyArgs reply_args);
            // The event handling code deals with clearing pending events and adding the abort event
            cmd         = Command_ABORT;
            cmd_valid   = 1'b1;
            super.send_app_abort_request_verify_reply(addr, reply_args);
            cmd_valid   = 1'b0;
        endtask

        // override this to first randomise the version inputs to the DUT
        // they are meant to be constants, but varying them here lets us check they are
        // correctly connected
        virtual task send_app_identify_request_verify_reply(StdBlockAddress addr);
            afe_version     = 4'($urandom);
            sens_version    = 4'($urandom);
            adc_version     = 4'($urandom);

            super.send_app_identify_request_verify_reply(addr);
        endtask
    endclass

    RadSensDigTop_TbSequence seq;

    // --------------------------------------------------------------
    // Test stimulus
    // --------------------------------------------------------------

    initial begin
        automatic transaction_generator_pkg::TransactionGenerator   rx_trans_gen;
        automatic transaction_generator_pkg::TransactionGenerator   tx_trans_gen;
        automatic RxTransConvType                                   rx_trans_conv;
        automatic TxTransConvType                                   tx_trans_conv;
        automatic int                                               reply_timeout;
        automatic int                                               max_rx_msg_ticks;

        power = 2'b00;

        // TODO: randomise some settings:
        //      CLOCK_STARTS/STOPS_AFTER_PS
        //      PAUSE_N_ASSERTS/DEASSERTS_AFTER_PS
        //      pause ticks
        //      clock speed
        //      ...?

        analogue_sim_inst.init(512);    // inits the RxDriver

        tx_monitor          = new(lm_iface);

        rx_send_queue       = new('{});
        tx_recv_queue       = new('{});

        rx_trans_gen        = new(1'b1);    // Rx messages must have CRCs applied
        tx_trans_gen        = new(1'b1);    // Tx messages will have CRCs applied

        rx_trans_conv       = new(1'b1);    // Rx messages must have parity bits
        tx_trans_conv       = new(1'b1);    // Tx messages will have parity bits

        // initialise the variable part of the UID to be all ones.
        // this is so on the first test when we swap to all 0s, we get the 1->0 toggle coverage
        // we then switch back to 1 to get 0->1.
        picc_uid        = new('1);
        full_uid = picc_uid.get_uid;

        // longest reply is an app IDENTIFY reply:
        //      PCB + CID + 5 byte app header + 5 bytes data + 2 bytes CRC
        // = 14 bytes, each byte has 8 bits + parity -> 126 bits.
        // there are 128 ticks in a bit, so 16,128 ticks
        // then the FDT takes 1236 ticks to fire (in the worst case)
        // so 17,364 ticks total. Use 18,000 ticks
        reply_timeout   = 18000;

        // longest valid request is the AUTO_READ request with:
        // PCB + CID + 5 byte app header + 10 bytes data + 2 bytes CRC
        // = 19 bytes, each byte has 8 bits + parity -> 171 bits.
        // Then there's the SOC (equivalent to 1 bit) and the EOC (equivalent to 2 bits)
        // So 174 bits. Each bit takes 128 ticks, so 22,272.
        // using 22,500
        max_rx_msg_ticks    = 22500;

        seq             = new(picc_uid,
                              rx_trans_gen,
                              tx_trans_gen,
                              rx_trans_conv,
                              tx_trans_conv,
                              rx_send_queue,
                              tx_recv_queue,
                              analogue_sim_inst.driver,
                              tx_monitor,
                              reply_timeout,
                              max_rx_msg_ticks);

        analogue_sim_inst.start (rx_send_queue.data);
        tx_monitor.start        (tx_recv_queue.data);

        seq.do_reset;

        // we don't run a huge amount of tests here, since this already takes a long time to run.
        // All the other testbenches prove that the rest of the design works, so really all this needs
        // to do is show that we haven't missed connecting something at the top level.
        // Still, it'd be worth running a lot more tests as a one off, and leaving it running for a few days.

        // repeat 4 times with different UIDs
        for (int i = 0; i < 4; i++) begin
            if (i == 0) begin
                // set the variable part of the uid to 0
                // this and the i == 1 case help us get toggle coverage
                picc_uid.set_uid('0);
            end
            else if (i == 1) begin
                // set the variable part of the uid to all ones
                picc_uid.set_uid('1);
            end
            else begin
                // randomise the variable part of the UID
                picc_uid.randomize;
            end

            full_uid = picc_uid.get_uid;
            $display("NOTE: New UID: %s", picc_uid.to_string);
            seq.do_reset;

            // Run the tests
            seq.run_all_initialisation_tests();
            seq.run_all_part4_tests();
            seq.run_protocol_tests();
        end

        repeat (5) @(posedge clk) begin end
        $stop;
    end

    // --------------------------------------------------------------
    // Asserts
    // --------------------------------------------------------------


endmodule
