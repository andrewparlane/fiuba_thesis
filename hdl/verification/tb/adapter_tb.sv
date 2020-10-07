/***********************************************************************
        File: adapter_tb.sv
 Description: Testbench for adapter
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

module adapter_tb;

    import protocol_pkg::*;
    import std_block_address_pkg::StdBlockAddress;

    // --------------------------------------------------------------
    // Ports to DUT
    // all named the same as in the DUT, so I can use .*
    // --------------------------------------------------------------

    localparam logic [7:0]  ADAPTER_VERSION         = 8'h01;    // not actually passed in to the DUT, but must match the DUT's own version
    localparam logic [7:0]  ISO_IEC_14443A_VERSION  = 8'h81;
    localparam logic [7:0]  SENSOR_VERSION          = 8'h12;
    localparam logic [7:0]  ADC_VERSION             = 8'hFF;


    logic           clk;
    logic           rst_n;

    logic           pause_n_synchronised;

    rx_interface #(.BY_BYTE(1)) rx_iface (.*);
    tx_interface #(.BY_BYTE(1)) tx_iface (.*);
    logic           app_resend_last;

    logic [2:0]     sens_config;
    logic           sens_enable;
    logic           sens_read;
    logic           adc_enable;
    logic           adc_read;
    logic           adc_conversion_complete;
    logic [15:0]    adc_value;

    // --------------------------------------------------------------
    // DUT
    // --------------------------------------------------------------

    adapter
    #(
        .ISO_IEC_14443A_VERSION (ISO_IEC_14443A_VERSION),
        .SENSOR_VERSION         (SENSOR_VERSION),
        .ADC_VERSION            (ADC_VERSION)
    )
    dut (.*);

    // --------------------------------------------------------------
    // The driver / queue for the rx_iface
    // --------------------------------------------------------------

    // driver
    typedef rx_byte_iface_driver_pkg::RxByteIfaceDriver                     RxDriverType;
    RxDriverType                                                            rx_driver;

    // Rx Transactions
    typedef rx_byte_transaction_pkg::RxByteTransaction                      RxInTransType;
    typedef rx_transaction_converter_pkg::RxByteToByteTransactionConverter  RxTransConvType;

    // the send queue
    typedef RxInTransType                                                   RxInTransQueueType [$];
    typedef wrapper_pkg::Wrapper #(.Type(RxInTransQueueType))               RxInQueueWrapperType;
    RxInQueueWrapperType                                                    rx_send_queue;


    // --------------------------------------------------------------
    // The monitor for the tx_iface
    // --------------------------------------------------------------

    // monitor
    typedef tx_byte_iface_monitor_pkg::TxByteIfaceMonitor                   TxMonitorType;
    TxMonitorType                                                           tx_monitor;

    // Tx Transactions
    typedef tx_byte_transaction_pkg::TxByteTransaction                      TxOutTransType;
    typedef tx_transaction_converter_pkg::TxByteToByteTransactionConverter  TxTransConvType;

    // and the recv_queue
    typedef TxOutTransType                                                  TxOutTransQueueType [$];
    typedef wrapper_pkg::Wrapper #(.Type(TxOutTransQueueType))              TxOutQueueWrapperType;
    TxOutQueueWrapperType                                                   tx_recv_queue;

    // sink driver
    tx_iface_sink_driver_pkg::TxByteIfaceSinkDriver                         tx_sink_driver;

    // --------------------------------------------------------------
    // Transaction Generators
    // --------------------------------------------------------------

    typedef transaction_generator_pkg::TransactionGenerator                 TransGenType;

    TransGenType rx_trans_gen;
    TransGenType tx_trans_gen;

    // --------------------------------------------------------------
    // Clock generator
    // --------------------------------------------------------------

    // use 10MHz to make timing checks easier
    localparam int CLOCK_FREQ_HZ    = 10000000;
    localparam int CLOCK_PERIOD_PS  = 1000000000000.0 / CLOCK_FREQ_HZ;
    clock_source #(.CLOCK_FREQ_HZ(CLOCK_FREQ_HZ)) clock_source_inst (.*);

    // --------------------------------------------------------------
    // ADC model
    // --------------------------------------------------------------

    localparam int ADC_SIM_MIN_CYCLES = 512;
    localparam int ADC_SIM_MAX_CYCLES = 1024;

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
        .adc_conversion_complete    (adc_conversion_complete),
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

    // events that interest us are output signal changes:
    //  sens_config
    //  sens_enable
    //  sens_read
    //  adc_enable
    //  adc_read

    typedef struct
    {
        Signals change_mask;
        Signals new_value;
        int     ticks_since_last_pause;
        int     ticks_since_last_event;
        logic   is_sync;                // 1 -> use ticks_since_last_pause, 0 -> ticks_since_last_event
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

                actual.ticks_since_last_pause   = int'(($time - last_pause_time) / CLOCK_PERIOD_PS);
                actual.ticks_since_last_event   = int'(($time - last_event_time) / CLOCK_PERIOD_PS);

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

                    // if it's the sync part of the operation, we care about the ticks since the last pause
                    // if it's the timing part of the operation, we care about the ticks since the last event
                    if (expected.is_sync) begin
                        res = res && (actual.ticks_since_last_pause == expected.ticks_since_last_pause);
                    end
                    else begin
                        res = res && (actual.ticks_since_last_event == expected.ticks_since_last_event);
                    end

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
        if ($past(rx_iface.eoc)) begin
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

                    // the DUT asserts abort when EOC is detected, and that is seen on the next tick
                    // the changes are therefore seen the tick after.
                    e.ticks_since_last_pause    = 2;
                    // not actually a sync event, but we care about the time sinc teh last pause
                    // since that's asserted on EOC.
                    e.is_sync                   = 1'b1;

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
    // pause_n_synchronised manipulation
    // ----------------------------------------------------------------

    // send a pause_n pulse on each data byte, and EOC, or if we are asked to fake one
    logic fake_pause_n_rising_edge;

    initial begin
        pause_n_synchronised <= 1'b1;
        @(posedge clk) begin end

        forever begin
            wait (rx_iface.data_valid || rx_iface.eoc || fake_pause_n_rising_edge) begin end
            pause_n_synchronised    <= 1'b0;
            @(posedge clk) begin end
            pause_n_synchronised    <= 1'b1;
            last_pause_time         <= $time;
            @(posedge clk) begin end
        end
    end

    // ----------------------------------------------------------------
    // Extend CommsTestsSequence to do TB specific stuff
    // ----------------------------------------------------------------

    class AdapterTbSequence
    extends app_comms_tests_sequence_pkg::AppCommsTestsSequence
    #(
        .RxTransType        (RxInTransType),
        .TxTransType        (TxOutTransType),
        .RxTransConvType    (RxTransConvType),
        .TxTransConvType    (TxTransConvType),
        .RxDriverType       (RxDriverType),
        .TxMonitorType      (TxMonitorType),

        .ADAPTER_VERSION            (ADAPTER_VERSION),
        .ISO_IEC_14443A_VERSION     (ISO_IEC_14443A_VERSION),
        .SENSOR_VERSION             (SENSOR_VERSION),
        .ADC_VERSION                (ADC_VERSION),

        .ADC_SIM_MIN_CYCLES         (ADC_SIM_MIN_CYCLES),
        .ADC_SIM_MAX_CYCLES         (ADC_SIM_MAX_CYCLES)
    );

        // constructor
        function new(TransGenType               _rx_trans_gen,
                     TransGenType               _tx_trans_gen,
                     RxTransConvType            _rx_trans_conv,
                     TxTransConvType            _tx_trans_conv,
                     RxQueueWrapperType         _rx_send_queue,
                     TxQueueWrapperType         _tx_recv_queue,
                     RxDriverType               _rx_driver,
                     TxMonitorType              _tx_monitor,
                     int                        _reply_timeout,
                     int                        _max_rx_msg_ticks);

            // UID is not used in app comms
            const static uid_pkg::UID dummy_uid = uid_pkg::UID::new_single_uid(32'h0);

            super.new(dummy_uid,
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
                      1000);                // TODO: Run optimised builds and test with more than 1000 loops per test

            // assign a random (valid) CID
            picc_target.set_cid(1'b1, $urandom_range(14));
        endfunction

        virtual protected task do_reset;
            rst_n <= 1'b0;
            repeat (5) @(posedge clk) begin end
            rst_n <= 1'b1;
            repeat (5) @(posedge clk) begin end
        endtask

        function void comms_tests_callback(CommsTestsEventCode ec, int arg=0);
            case (ec)
                CommsTestsEventCode_SET_CORRUPT_CRC: begin
                    // iso_14443_4a converts CRC errors to us using an error on the rx_iface
                    rx_driver.set_add_error(arg);
                end
                CommsTestsEventCode_SET_DRIVER_ERRORS: begin
                end
                default: begin
                    $error("Unknown event code %s", ec.name);
                end
            endcase
        endfunction

        // override state transition tasks, as they are not relevant for this TB
        virtual protected task go_to_state_idle;
            $error("State not supported");
        endtask

        virtual protected task go_to_state_ready;
            $error("State not supported");
        endtask

        virtual protected task go_to_state_active;
            $error("State not supported");
        endtask

        virtual protected task go_to_state_halt;
            $error("State not supported");
        endtask

        virtual protected task go_to_state_ready_star;
            $error("State not supported");
        endtask

        virtual protected task go_to_state_active_star;
            $error("State not supported");
        endtask

        virtual protected task go_to_state_expect_rats;
            $error("State not supported");
        endtask

        virtual protected task go_to_state_protocol_pps_allowed(CidType cid_type = CID_CURRENT);
            $error("State not supported");
        endtask

        // this is the only state we care about
        virtual protected task go_to_state_protocol_std_comms(CidType cid_type = CID_CURRENT);
            // reset so we get back to a known state
            do_reset;
            register_state_change(State_PROTOCOL_STD_COMMS);
        endtask

        // pure virtual, must be overwritten, but we don't use the STD Block header
        // in the apapter, so no power signal to set.
        virtual protected function void set_power_input(logic [1:0] _power);
        endfunction

        // pure virtual, must be overwritten, but we don't use the STD Block header
        // in the apapter, so no CID to check
        virtual function logic verify_dut_cid(logic [3:0] expected);
            return 1;
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
            wait (!dut.signal_control_busy) @(posedge clk) begin end
        endtask

        // pure virtual, must be overwritten
        virtual function logic get_signal_control_busy;
            return dut.signal_control_busy;
        endfunction

        // pure virtual, must be overwritten
        virtual function Signals get_current_signals;
            return signals;
        endfunction

        // pure virtual, must be overwritten
        virtual function logic [15:0] get_last_read_adc_value;
            return expected_adc_value;
        endfunction

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

                // takes one extra tick for the event to be detected
                // and a minimum of 3 ticks (start detected, signals changed, event detected)
                e.ticks_since_last_pause    = request_args.sync + 1;
                if (e.ticks_since_last_pause < 3) begin
                    e.ticks_since_last_pause = 3;
                end

                e.is_sync                   = 1'b1;

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

                // takes one extra tick for the event to be detected
                // and a minimum of 3 ticks (start detected, signals changed, event detected)
                e.ticks_since_last_pause    = request_args.sync + 1;
                if (e.ticks_since_last_pause < 3) begin
                    e.ticks_since_last_pause = 3;
                end

                e.is_sync                   = 1'b1;

                new_expected_events.push_back(e);

                // at the end of timing1 sens_read asserts
                e.new_value.sens_read       = 1'b1;
                e.change_mask               = '0;
                e.change_mask.sens_read     = 1'b1;
                e.ticks_since_last_event    = request_args.timing1 + 1;
                e.is_sync                   = 1'b0;

                new_expected_events.push_back(e);

                // at the end of timing2 adc_read asserts
                e.new_value.adc_read        = 1'b1;
                e.change_mask               = '0;
                e.change_mask.adc_read      = 1'b1;
                e.ticks_since_last_event    = request_args.timing2 + 1;
                e.is_sync                   = 1'b0;

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

        // overriden to remove the STD block header
        virtual task send_transaction (rx_byte_transaction_pkg::RxByteTransaction byte_trans, EventMessageID mid);
            automatic logic [7:0] pcb;

            // we only support STD I-Blocks (non chaining)
            onlyStdIBlocks:
            assert (mid == EventMessageID_STD_I_BLOCK_NO_CHAINING)
            else $error("Invalid messages \"%s\" sent", mid.name);

            // pop off the PCB field
            pcb = byte_trans.pop_front;

            // And the CID field if there is one
            if (pcb[3]) begin // has CID
                void'(byte_trans.pop_front);
            end

            // And the NAD field if there is one
            if (pcb[2]) begin // has NAD
                void'(byte_trans.pop_front);
            end

            //$display("transmitting %s", byte_trans.to_string);

            super.send_transaction(byte_trans, mid);
        endtask

        // overriden to remove the STD block header
        virtual function logic verify_trans(TxTransType recv_trans, tx_byte_transaction_pkg::TxByteTransaction byte_expected, int msgType, string trans_name="unknown");
            automatic logic [7:0] pcb;

            // we only support STD I-Blocks (non chaining)
            onlyStdIBlocks:
            assert (msgType == EventMessageID_STD_I_BLOCK_NO_CHAINING)
            else $error("Invalid messages: \"%s\" expected", trans_name);

            // pop off the PCB field
            pcb = byte_expected.pop_front;

            // And the CID field if there is one
            if (pcb[3]) begin // has CID
                void'(byte_expected.pop_front);
            end

            // And the NAD field if there is one
            if (pcb[2]) begin // has NAD
                void'(byte_expected.pop_front);
            end

            //$display("recv_trans: %s, expected: %s", recv_trans.to_string, byte_expected.to_string);

            return super.verify_trans(recv_trans, byte_expected, msgType, trans_name);
        endfunction

        // In order to test the sync and pause detection during AUTO_READ we want to stimulate
        // pause_n_synchronised when the signal_control module is busy. In the final design that is
        // done by sending messages to other PICCs. Normally the iso_iec_14443_4a module would filter
        // out messages that aren't for us, but that's not present in this testbench, so we filter
        // out messages not for us here, and flag that we need to fake a pause_n_synchronised rising edge
        virtual task send_std_i_block(StdBlockAddress addr, logic chaining, logic block_num, logic [7:0] inf [$]);
            if (picc_target.is_for_us(addr) && !chaining) begin
                super.send_std_i_block(addr, chaining, block_num, inf);
            end
            else begin
                fake_pause_n_rising_edge <= 1'b1;
                @(posedge clk)
                fake_pause_n_rising_edge <= 1'b0;
                // delay a bit to ensure the fake pause was detected
                repeat (4) @(posedge clk) begin end
            end

        endtask

        // the DUT does not reply to messages with an invalid magic.
        // In the full design the ISO/IEC 14443-4 block will respond with just the STD I-Block header
        // and CRC, with no INF field. However since the ISO/IEC 14443-4 block is not instantiated in this TB
        // no reply is sent. We override this function to detect that event and to call verify_no_reply instead
        virtual task wait_for_and_verify_std_i_block(StdBlockAddress send_addr, logic [7:0] reply_inf [$]);
            if (reply_inf.size() == 0) begin
                // no reply expected
                verify_no_reply;
                // note it as an empty reply
                last_reply = new();

                // ISO/IEC 14443-4:2016 section 7.5.4, Rule B
                // When an I-block or an R(ACK) block with a block number equal to the current block number
                // is received, the PCD shall toggle the current block number for that PICC before optionally
                // sending a block.
                if (picc_target.picc_and_pcd_block_nums_are_equal) begin
                    picc_target.toggle_pcd_block_num;
                end
            end
            else begin
                super.wait_for_and_verify_std_i_block(send_addr, reply_inf);
            end
        endtask

        // same for wait_for_and_verify_resend_last
        virtual task wait_for_and_verify_resend_last;
            if (last_reply.size() == 0) begin
                // no reply expected
                verify_no_reply;

                // ISO/IEC 14443-4:2016 section 7.5.4, Rule B
                // When an I-block or an R(ACK) block with a block number equal to the current block number
                // is received, the PCD shall toggle the current block number for that PICC before optionally
                // sending a block.
                if (picc_target.picc_and_pcd_block_nums_are_equal) begin
                    picc_target.toggle_pcd_block_num;
                end
            end
            else begin
                super.wait_for_and_verify_resend_last();
            end
        endtask

        // fake this for use with app_resend_last
        virtual task send_std_r_ack(StdBlockAddress addr, logic block_num);
            // this should only be called with block_num == the picc's block num
            // in this testbench, since we have no use for normal ACKs / NAKs
            blockNumsEqual:
            assert (block_num == picc_target.get_picc_block_num)
                else $error("send_std_r_ack() called with unexpected block_num");

            fake_pause_n_rising_edge <= 1'b1;
            @(posedge clk)
            fake_pause_n_rising_edge <= 1'b0;
            // delay a bit to ensure the fake pause was detected
            repeat (4) @(posedge clk) begin end

            app_resend_last <= 1'b1;
            @(posedge clk)
            app_resend_last <= 1'b0;
            repeat (4) @(posedge clk) begin end
        endtask

        // fake this for use with app_resend_last
        virtual task send_std_r_nak(StdBlockAddress addr, logic block_num);
            // this is exactly the same code as for ACKs, since we don't actually send
            // the message in this testbench, and just fake some signals.
            send_std_r_ack(addr, block_num);
        endtask

    endclass

    AdapterTbSequence seq;

    // --------------------------------------------------------------
    // Test stimulus
    // --------------------------------------------------------------

    initial begin
        automatic RxTransConvType   rx_trans_conv;
        automatic TxTransConvType   tx_trans_conv;
        automatic int               reply_timeout;
        automatic int               max_rx_msg_ticks;

        rx_driver           = new(rx_iface);
        tx_monitor          = new(tx_iface);
        tx_sink_driver      = new(tx_iface);

        rx_send_queue       = new('{});
        tx_recv_queue       = new('{});

        rx_trans_gen        = new(1'b1);    // auto append CRCs
        tx_trans_gen        = new(1'b0);    // Tx messages don't have CRCs at this point

        rx_trans_conv       = new;
        tx_trans_conv       = new;

        // longest valid request is the AUTO_READ request with a 5 byte header, 10 bytes of data
        // and 2 bytes of CRC. So 17 bytes.
        max_rx_msg_ticks    = rx_driver.calculate_send_time(rx_trans_gen.generate_random_non_valid(17)) + 32;

        // longest valid reply is the IDENTIFY reply with a 5 byte header and a 5 byte argument.
        // The tx_sink_driver reqs every 16 ticks
        reply_timeout   = 256;
        seq             = new(rx_trans_gen,
                              tx_trans_gen,
                              rx_trans_conv,
                              tx_trans_conv,
                              rx_send_queue,
                              tx_recv_queue,
                              rx_driver,
                              tx_monitor,
                              reply_timeout,
                              max_rx_msg_ticks);

        rx_driver.start         (rx_send_queue.data);
        tx_monitor.start        (tx_recv_queue.data);
        tx_sink_driver.start    ();

        app_resend_last         <= 1'b0;

        // reset for 5 ticks
        rst_n <= 1'b0;
        repeat (5) @(posedge clk) begin end
        rst_n <= 1'b1;
        repeat (5) @(posedge clk) begin end

        seq.run_protocol_tests;

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
        !rst_n |-> (!sens_config && !sens_enable && !sens_read &&
                    !adc_enable && !adc_read))
        else $error("signals in reset not as expected");

endmodule
