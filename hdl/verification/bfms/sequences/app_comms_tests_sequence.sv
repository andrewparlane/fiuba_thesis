/***********************************************************************
        File: app_comms_tests_sequence.sv
 Description: Tests all the app level comms messages
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

package app_comms_tests_sequence_pkg;

    import std_block_address_pkg::StdBlockAddress;
    import rx_byte_transaction_pkg::RxByteTransaction;

    import protocol_pkg::*;

    // virtual because the TB must override several functions/tasks:
    //      do_reset
    //      set_power_input
    //      verify_dut_cid
    //      wait_for_ticks_since_last_pause
    //      wait_for_signal_control_idle
    //      get_signal_control_busy
    //      get_current_signals
    //      get_last_read_adc_value
    virtual class AppCommsTestsSequence
    #(
        // These must extend QueueTransaction
        type RxTransType,
        type TxTransType,

        // This must be / extend TransactionGenerator
        type TransGenType   = transaction_generator_pkg::TransactionGenerator,

        // These must extend TransactionConverter
        type RxTransConvType,
        type TxTransConvType,

        // This must extend RxDriver
        type RxDriverType,

        // This must extend TxMonitor
        type TxMonitorType,

        // For the identify reply
        parameter logic [7:0] ADAPTER_VERSION,
        parameter logic [7:0] ISO_IEC_14443A_VERSION,
        parameter logic [7:0] SENSOR_VERSION,
        parameter logic [7:0] ADC_VERSION,

        // For timing purposes
        parameter int ADC_SIM_MIN_CYCLES,
        parameter int ADC_SIM_MAX_CYCLES
    )
    extends comms_tests_sequence_pkg::CommsTestsSequence
    #(
        .RxTransType        (RxTransType),
        .TxTransType        (TxTransType),
        .TransGenType       (TransGenType),
        .RxTransConvType    (RxTransConvType),
        .TxTransConvType    (TxTransConvType),
        .RxDriverType       (RxDriverType),
        .TxMonitorType      (TxMonitorType)
    );

        typedef enum
        {
            AppMsgType_IDENTIFY     = 0,
            AppMsgType_SET_SIGNAL,
            AppMsgType_AUTO_READ,
            AppMsgType_GET_RESULT,
            AppMsgType_ABORT,
            AppMsgType_UNSUPPORTED_CMD,
            AppMsgType_INVALID_MAGIC,
            AppMsgType_ERROR
        } AppMsgType;

        typedef enum
        {
            // After waiting for the request, receiving the reply and sending some optional extra pauses
            // during the sync period, do one of the following:

            // wait until the operation has completed
            ExitAction_WAIT_FOR_IDLE            = 0,

            // send an unexpected pause during the timing1, timing2 or wait_for_adc periods
            // and then wait for idle.
            ExitAction_SEND_UNEXPECTED_PAUSE,

            // send an abort before the operation completes.
            ExitAction_SEND_EARLY_ABORT,

            // return immediately from the task, the operation should still be ongoing
            // unless the sync time was less than the time it took for the reply to be received.
            // The last_op_had_unexpected_pause will be cleared since nothing extra was sent after
            // any extra pauses in the sync period.
            // The last_op_caused_adc_read may be sent (will be for AUTO_READ), however the operation
            // may not yet have completed, and so it can't be guaranteed that the next response will
            // have that bit set.
            // The caller is responsible for making sure these flags are set correctly
            ExitAction_IMMEDIATE_RETURN
        } ExitAction;

        logic   last_op_caused_adc_read;
        logic   last_op_had_unexpected_pause;
        logic   last_op_still_busy;

        int     max_rx_msg_ticks;

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
                     int                        _max_rx_msg_ticks,
                     int                        _num_loops_per_test=1000);
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
                      _num_loops_per_test);

            last_op_caused_adc_read         = 1'b0;
            last_op_had_unexpected_pause    = 1'b0;
            last_op_still_busy              = 1'b0;
            max_rx_msg_ticks                = _max_rx_msg_ticks;
        endfunction

        // ====================================================================
        // Pure Virtual functions / tasks
        // must be overriden by a child class
        // ====================================================================
        // defined in SpecificTargetSequence
        //pure virtual task                do_reset;
        //pure virtual function logic      verify_dut_cid      (logic [3:0] expected);
        //pure virtual function void       set_power_input(logic [1:0] _power);

        // we need to be able to send another message at various points during an app operation
        // so we use a delay function that waits for a number of ticks since the last pause rising edge
        pure virtual task wait_for_ticks_since_last_pause(int ticks);

        // This should just hook into the signal_control_busy signal. It allows us a way of knowing
        // when a new send can start without affecting status bits, and without requiring an abort
        // which would clear those status bits.
        pure virtual task wait_for_signal_control_idle;

        // should return if the signal_control module is busy or not
        pure virtual function logic get_signal_control_busy;

        // returns the current value of the DUT's outputs to the sensor / adc
        pure virtual function Signals get_current_signals;

        // returns the last value the ADC returned
        pure virtual function logic [15:0] get_last_read_adc_value;

        // ====================================================================
        // checks
        // ====================================================================

        virtual function void check_signal_control_busy(logic expected);
            automatic logic actual = get_signal_control_busy;
            signalControlBusyAsExpected:
            assert (expected == actual) else $error("signal_control_busy %b not as expected", actual);
        endfunction

        // ====================================================================
        // Generate INF field for STD I-Blocks and S(PARAMAETERS)
        // ====================================================================

        // overrides CommsTestSequence::generate_inf(). This is just used to generate random
        // INFs for S(PARAMAETERS) or STD I-Blocks. It complicates the process too much here
        // to send valid protocol messages, since tracking what is sent and how that affects
        // the current state is pretty complex. So here we just send messages with an invalid
        // magic, so that the app does not respond to them, and the state shouldn't change.
        // This is fine because we test valid protocol messages later on, and the iso_iec_14443_4a
        // module should respond with an empty INF field.
        virtual protected function ByteQueue generate_inf(MsgType msg_type);
            return protocol_generator_pkg::generate_invalid_magic();
        endfunction

        // overriden from SpecificTargetSequence.
        // get_std_i_reply_inf is only used to send generic STD I-Blocks in the CommsTestsSequence
        // when paired with generate_inf(). Since we only ever generate messages with an invalid magic
        // we don't expect any reply from the app.
        virtual function ByteQueue get_std_i_reply_inf(logic [7:0] inf [$]);
            return '{};
        endfunction

        // ====================================================================
        // send message
        // ====================================================================

        // override this to disable power randomisation for messages not sent to us
        // When the PCD receives an R(ACK) / R(NAK) with the PCD block num equal to the PICC's own block num
        // the PICC resends it's last reply. The standard never makes it clear as to whether or not the
        // power field of the CID byte of the header can change or not at this point. I've chosen to allow
        // it to change. Since it's better if the PCD knows it needs to provide more power earlier rather
        // than later. However since these sequence classes are designed to work with different Tx transaction
        // (bytes / bits, with / without parity, ..), it's not easy to compare two transactions that only
        // differ in the power bits. For that reason I disable the power randomisation during the resend last
        // tests, in CommsTestSequence and here. However here we also send STD I-Blocks to other PICCs,
        // in order to cause pauses to reset sync times / causes unexpected pauses (see do_set_signal() and
        // do_auto_read(). If these occur between a valid message with a reply and the R(ACK/NAK) then they
        // would result in the testbench changing the power input to the DUT. Thus causing the resend last
        // tests to fail. So we simply disable that randomisation of the power field if the message is not
        // for us.
        virtual task send_std_i_block(StdBlockAddress addr, logic chaining, logic block_num, logic [7:0] inf [$]);
            automatic logic old_randomise_power = randomise_power;

            if (!picc_target.is_for_us(addr)) begin
                randomise_power = 1'b0;
            end
            super.send_std_i_block(addr, chaining, block_num, inf);

            randomise_power = old_randomise_power;
        endtask

        // ====================================================================
        // send message verify reply tasks
        // ====================================================================

        virtual task send_app_identify_request_verify_reply(StdBlockAddress addr);
            automatic logic [7:0]       send_inf  [$]   = protocol_generator_pkg::generate_identify_request();
            automatic logic [7:0]       reply_inf [$];
            automatic IdentifyReplyArgs identify_reply_args;

            identify_reply_args.protocol_version        = PROTOCOL_VERSION;
            identify_reply_args.adapter_version         = ADAPTER_VERSION;
            identify_reply_args.iso_iec_14443a_version  = ISO_IEC_14443A_VERSION;
            identify_reply_args.sensor_version          = SENSOR_VERSION;
            identify_reply_args.adc_version             = ADC_VERSION;

            reply_inf = protocol_generator_pkg::generate_identify_reply(identify_reply_args);

            send_std_i_block_verify_reply(addr, send_inf, reply_inf);
        endtask

        virtual task send_app_set_signal_request_verify_reply(StdBlockAddress addr, SetSignalRequestArgs request_args, StatusReplyArgs reply_args);
            automatic logic [7:0] send_inf  [$] = protocol_generator_pkg::generate_set_signal_request(request_args);
            automatic logic [7:0] reply_inf [$] = protocol_generator_pkg::generate_set_signal_reply(reply_args);

            send_std_i_block_verify_reply(addr, send_inf, reply_inf);
        endtask

        virtual task send_app_auto_read_request_verify_reply(StdBlockAddress addr, AutoReadRequestArgs request_args, StatusReplyArgs reply_args);
            automatic logic [7:0] send_inf  [$] = protocol_generator_pkg::generate_auto_read_request(request_args);
            automatic logic [7:0] reply_inf [$] = protocol_generator_pkg::generate_auto_read_reply(reply_args);

            send_std_i_block_verify_reply(addr, send_inf, reply_inf);
        endtask

        virtual task send_app_get_result_request_verify_reply(StdBlockAddress addr, GetResultReplyArgs reply_args);
            automatic logic [7:0] send_inf  [$] = protocol_generator_pkg::generate_get_result_request();
            automatic logic [7:0] reply_inf [$] = protocol_generator_pkg::generate_get_result_reply(reply_args);

            send_std_i_block_verify_reply(addr, send_inf, reply_inf);
        endtask

        virtual task send_app_abort_request_verify_reply(StdBlockAddress addr, StatusReplyArgs reply_args);
            automatic logic [7:0] send_inf  [$] = protocol_generator_pkg::generate_abort_request();
            automatic logic [7:0] reply_inf [$] = protocol_generator_pkg::generate_abort_reply(reply_args);

            send_std_i_block_verify_reply(addr, send_inf, reply_inf);
        endtask

        virtual task send_app_invalid_cmd_verify_reply(StdBlockAddress addr, StatusReplyArgs reply_args);
            automatic logic [7:0] send_inf  [$] = protocol_generator_pkg::generate_random_non_valid();
            automatic logic [7:0] reply_inf [$] = protocol_generator_pkg::generate_status_reply(send_inf[4], reply_args);

            send_std_i_block_verify_reply(addr, send_inf, reply_inf);
        endtask

        // ISO/IEC 14443-4 requires a reply to STD I-Blocks whether or not they speak our protocol
        // Our adapter does not respnod, but the iso_14443_4a module will send a response with
        // an empty INF
        virtual task send_app_invalid_magic_verify_no_app_reply(StdBlockAddress addr);
            automatic logic [7:0] send_inf  [$] = protocol_generator_pkg::generate_invalid_magic();

            send_std_i_block_verify_reply(addr, send_inf, '{});
        endtask

        virtual function AppMsgType pick_random_app_message(logic identify,
                                                            logic set_signal,       logic auto_read,
                                                            logic get_result,       logic abort,
                                                            logic unsupported_cmd,  logic invalid_magic,
                                                            logic error);
            automatic AppMsgType allowed [$] = '{};
            automatic AppMsgType to_send;

            if (identify) begin
                allowed.push_back(AppMsgType_IDENTIFY);
            end
            if (set_signal) begin
                allowed.push_back(AppMsgType_SET_SIGNAL);
            end
            if (auto_read) begin
                allowed.push_back(AppMsgType_AUTO_READ);
            end
            if (get_result) begin
                allowed.push_back(AppMsgType_GET_RESULT);
            end
            if (abort) begin
                allowed.push_back(AppMsgType_ABORT);
            end
            if (unsupported_cmd) begin
                allowed.push_back(AppMsgType_UNSUPPORTED_CMD);
            end
            if (invalid_magic) begin
                allowed.push_back(AppMsgType_INVALID_MAGIC);
            end
            if (error) begin
                allowed.push_back(AppMsgType_ERROR);
            end

            std::randomize(to_send) with {to_send inside {allowed};};
            return to_send;
        endfunction

        // This expects the replies to come with all the correct status bits set.
        // so don't use this with set_corrupt_crc / set_driver_add_error
        virtual task do_random_app_msg_test(logic           identify,
                                            logic           set_signal,         logic       auto_read,
                                            logic           get_result,         logic       abort,
                                            logic           unsupported_cmd,    logic       invalid_magic,
                                            logic           error,
                                            StdBlockAddress addr,               ExitAction  exit_action);

            automatic AppMsgType            to_send;
            automatic SetSignalRequestArgs  set_signal_args;
            automatic AutoReadRequestArgs   auto_read_args;
            automatic int                   extra_pauses_in_sync;

            to_send = pick_random_app_message
            (
                .identify           (identify),
                .set_signal         (set_signal),       .auto_read      (auto_read),
                .get_result         (get_result),       .abort          (abort),
                .unsupported_cmd    (unsupported_cmd),  .invalid_magic  (invalid_magic),
                .error              (error)
            );

            //$display("do_random_app_msg_test: %s, exit_action: %s", to_send.name, exit_action.name);

            if (to_send == AppMsgType_SET_SIGNAL) begin
                set_signal_args.sync = reply_timeout + max_rx_msg_ticks + $urandom_range(512);
            end

            if (to_send == AppMsgType_AUTO_READ) begin
                auto_read_args.sync     = reply_timeout + max_rx_msg_ticks + $urandom_range(512);
                auto_read_args.timing1  = reply_timeout + max_rx_msg_ticks + $urandom_range(512);
                auto_read_args.timing2  = reply_timeout + max_rx_msg_ticks + $urandom_range(512);
            end

            if ((to_send == AppMsgType_SET_SIGNAL) || (to_send == AppMsgType_AUTO_READ)) begin
                extra_pauses_in_sync = $urandom_range(0,2);
            end

            case (to_send)
                AppMsgType_IDENTIFY:        send_app_identify_request_verify_reply(addr);
                AppMsgType_SET_SIGNAL:      do_set_signal_random_change(addr, set_signal_args.sync, extra_pauses_in_sync, exit_action);
                AppMsgType_AUTO_READ:       do_auto_read(addr, auto_read_args, extra_pauses_in_sync, exit_action);
                AppMsgType_GET_RESULT:      do_get_result(addr);
                AppMsgType_ABORT:           do_abort(addr);
                AppMsgType_UNSUPPORTED_CMD: do_unsupported_cmd(addr);
                AppMsgType_INVALID_MAGIC:   send_app_invalid_magic_verify_no_app_reply(addr);
                AppMsgType_ERROR:           send_app_msg_with_error(addr);
            endcase
        endtask

        // This sends messages and verifies there was no reply, it does not update any of the tracked
        // status bits. So if you use this combined with ExitAction_IMMEDIATE_RETURN, you'll have issues
        virtual task send_app_msg_with_error(StdBlockAddress addr);
            // TODO: Add an option of parity errors if rx messages have parity bits?

            automatic logic                 error_type = 1'($urandom);  // 0 -> error, 1 -> corrupt crc
            automatic AppMsgType            to_send;
            automatic SetSignalRequestArgs  set_signal_args;
            automatic AutoReadRequestArgs   auto_read_args;
            automatic logic [7:0]           inf [$];

            // send anything
            to_send = pick_random_app_message
            (
                .identify           (1'b1),
                .set_signal         (1'b1), .auto_read      (1'b1),
                .get_result         (1'b1), .abort          (1'b1),
                .unsupported_cmd    (1'b1), .invalid_magic  (1'b1),
                .error              (1'b0)  // it's already an error
            );

            if (to_send == AppMsgType_SET_SIGNAL) begin
                set_signal_args.sync    = reply_timeout + max_rx_msg_ticks + $urandom_range(512);
                set_signal_args.mask    = 8'($urandom);
                set_signal_args.value   = 8'($urandom);
            end

            if (to_send == AppMsgType_AUTO_READ) begin
                auto_read_args.sync     = reply_timeout + max_rx_msg_ticks + $urandom_range(512);
                auto_read_args.timing1  = reply_timeout + max_rx_msg_ticks + $urandom_range(512);
                auto_read_args.timing2  = reply_timeout + max_rx_msg_ticks + $urandom_range(512);
            end

            case (to_send)
                AppMsgType_IDENTIFY:        inf = protocol_generator_pkg::generate_identify_request();
                AppMsgType_SET_SIGNAL:      inf = protocol_generator_pkg::generate_set_signal_request(set_signal_args);
                AppMsgType_AUTO_READ:       inf = protocol_generator_pkg::generate_auto_read_request(auto_read_args);
                AppMsgType_GET_RESULT:      inf = protocol_generator_pkg::generate_get_result_request();
                AppMsgType_ABORT:           inf = protocol_generator_pkg::generate_abort_request();
                AppMsgType_UNSUPPORTED_CMD: inf = protocol_generator_pkg::generate_random_non_valid();
                AppMsgType_INVALID_MAGIC:   inf = protocol_generator_pkg::generate_invalid_magic();
            endcase

            // enable the correct error
            if (error_type == 0) begin
                set_driver_add_error(1'b1);
            end
            else begin
                set_corrupt_crc(1'b1);
            end

            send_std_i_block(addr, 1'b0, picc_target.get_pcd_block_num(), inf);
            verify_no_reply;

            // disable the error
            if (error_type == 0) begin
                set_driver_add_error(1'b0);
            end
            else begin
                set_corrupt_crc(1'b0);
            end
        endtask

        // ====================================================================
        // Helpers
        // ====================================================================

        virtual task do_abort (StdBlockAddress addr);
            automatic StatusReplyArgs   status_reply_args;
            automatic Signals           signals;

            // Abort always responds with all status flags at 0, as they get cleared by the ABORT
            status_reply_args.flags         = '0;
            send_app_abort_request_verify_reply(addr, status_reply_args);

            // abort resets flags
            last_op_caused_adc_read         = 1'b0;
            last_op_had_unexpected_pause    = 1'b0;
            last_op_still_busy              = 1'b0;

            // validate the abort worked
            signals = get_current_signals();
            abortResetSignals:
            assert (!signals.sens_enable && !signals.sens_read &&
                    !signals.adc_enable  && !signals.adc_read)
                else $error("signals not as expected after an abort: %p", signals);

            // we should immediately not be busy
            check_signal_control_busy(1'b0);
        endtask

        // sync must be greater than reply_timeout for messages_in_sync_period / pause_in_adc_read to work
        virtual task do_set_signal (StdBlockAddress addr, SetSignalRequestArgs set_signal_args, int messages_in_sync_period, ExitAction exit_action);
            automatic StatusReplyArgs       status_reply_args;
            automatic Signals               current_signals     = get_current_signals;

            // if the last operation caused an ADC read, then the conversion should be complete
            status_reply_args.flags.conv_complete       = last_op_caused_adc_read;
            // we wait for each command to finish before sending the next
            // so we can't already be busy
            status_reply_args.flags.already_busy        = last_op_still_busy;
            // if the last operation had an unexpected pause, then the flag should be set
            status_reply_args.flags.unexpected_pause    = last_op_had_unexpected_pause;
            // we send a valid command and we are not in an invalid start state for AUTO_READ
            status_reply_args.flags.error               = 1'b0;
            status_reply_args.flags.padding             = '0;

            //$display("  sending SET_SIGNAL %p, expecting reply: %p, current_signals: %p", set_signal_args, status_reply_args, current_signals);

            send_app_set_signal_request_verify_reply(addr, set_signal_args, status_reply_args);

            if (last_op_still_busy) begin
                // this new operation won't start
                // this flag should only be set if ExitAction_IMMEDIATE_RETURN was used
                // it's up to the caller to figure out when the current operation has finished
                return;
            end

            // does this operation cause an ADC read?
            last_op_caused_adc_read =   !current_signals.adc_read       &&
                                        set_signal_args.mask.adc_read   &&
                                        set_signal_args.value.adc_read;

            //$display("  causes adc read: %b", last_op_caused_adc_read);
            //$display("  messages_in_sync_period %d", messages_in_sync_period);

            // if requested we send some fake messages during the sync period to cause pauses resetting
            // the sync period.
            repeat (messages_in_sync_period) begin
                automatic int wait_ticks = $urandom_range(32, set_signal_args.sync - 64);
                //$display("    waiting for %d ticks since the last pause", wait_ticks);

                // leave at least 64 ticks left in the sync period so we don't run into edge cases
                // we proved the sync period timings are correct in the signal_control_tb
                wait_for_ticks_since_last_pause(wait_ticks);

                check_signal_control_busy(1'b1); // make sure signal_control is still busy

                // send a STD I-Block to another PICC
                //$display("    sending a STD I-Block to a different PICC");
                send_std_i_block(get_std_block_address(CID_RANDOM_NOT_CURRENT, NAD_NONE),
                                 1'b0, 1'b0, '{});
            end

            if (exit_action == ExitAction_IMMEDIATE_RETURN) begin
                // not sending anything else, so no unexpected pauses
                // the caller may send additional messages while the operation is still ongoing
                // in which case they must deal with updating this flag
                last_op_had_unexpected_pause = 1'b0;
                return;
            end

            if (last_op_caused_adc_read) begin
                if (exit_action == ExitAction_SEND_EARLY_ABORT) begin
                    // we need time to send the full Command_ABORT message before the SET_SIGNAL completes.
                    // This is to make sure the abort occurs while the signal_control module is busy
                    // so make sure there's enough time for that.
                    // Additionally to avoid the edge of the end of the sync period we randomly decide
                    // if the abort should occur in the sync period or the wait_for_adc period.
                    automatic int wait_ticks;

                    if (1'($urandom)) begin
                        // start in the sync period (will reset the sync period for every pause)
                        wait_ticks = $urandom_range(set_signal_args.sync - 32);
                    end
                    else begin
                        wait_ticks = set_signal_args.sync + 16 + $urandom_range(ADC_SIM_MIN_CYCLES  -
                                                                                max_rx_msg_ticks);
                    end

                    //$display("  early_abort wait ticks: %d", wait_ticks);
                    wait_for_ticks_since_last_pause(wait_ticks);

                    check_signal_control_busy(1'b1); // make sure signal_control is still busy

                    // send an abort command
                    // this causes an unexpected pause, but the abort clears that flag anyway
                    //$display("  sending abort");
                    do_abort(addr);
                end
                else if (exit_action == ExitAction_SEND_UNEXPECTED_PAUSE) begin
                    // wait until the middle of the ADC read period
                    automatic int wait_ticks = set_signal_args.sync + 16 +
                                               $urandom_range(ADC_SIM_MIN_CYCLES - 32);

                    wait_for_ticks_since_last_pause(wait_ticks);

                    check_signal_control_busy(1'b1); // make sure signal_control is still busy

                    // send a STD I-Block to another PICC
                    send_std_i_block(get_std_block_address(CID_RANDOM_NOT_CURRENT, NAD_NONE),
                                     1'b0, 1'b0, '{});

                    last_op_had_unexpected_pause = 1'b1;

                    // we just caused a new pause, but this doesn't change when the operation should end
                    // the operation should run for at most sync + ADC_SIM_MAX_CYCLES, since the last pause
                    // (not this one), but we know we are wait_ticks into that.
                    wait_for_ticks_since_last_pause(set_signal_args.sync + ADC_SIM_MAX_CYCLES - wait_ticks + 16);
                end
                else begin
                    // after the sync period there's the ADC read period, then the operation ends
                    last_op_had_unexpected_pause = 1'b0;
                    wait_for_ticks_since_last_pause(set_signal_args.sync + ADC_SIM_MAX_CYCLES + 512);
                end
            end
            else begin
                if (exit_action == ExitAction_SEND_EARLY_ABORT) begin
                    // we need time to send the full Command_ABORT message before the SET_SIGNAL completes.
                    // This is to make sure the abort occurs while the signal_control module is busy
                    // so make sure there's enough time for that.
                    automatic int wait_ticks = $urandom_range(set_signal_args.sync - max_rx_msg_ticks);

                    //$display("  wait_tick %d", wait_ticks);
                    wait_for_ticks_since_last_pause(wait_ticks);

                    check_signal_control_busy(1'b1); // make sure signal_control is still busy

                    // send an abort command
                    // this causes an unexpected pause, but the abort clears that flag anyway
                    //$display("  sending abort");
                    do_abort(addr);
                end
                else begin
                    // the operation ends after the sync period, so wait for that to expire plus a little bit
                    last_op_had_unexpected_pause = 1'b0;
                    wait_for_ticks_since_last_pause(set_signal_args.sync + 16);
                end
            end

            //$display("  done");
            check_signal_control_busy(1'b0); // make sure we're not busy any more
            last_op_still_busy = 1'b0;
        endtask

        // same as do_set_signal but set mask and value randomly
        virtual task do_set_signal_random_change (StdBlockAddress addr, int sync, int messages_in_sync_period, ExitAction exit_action);
            SetSignalRequestArgs set_signal_args;

            // sanity check
            if (sync > int'(16'hFFFF)) begin
                $error("sync %d is too large, must fit in 16 bits", sync);
            end

            set_signal_args.sync    = 16'(sync);
            set_signal_args.mask    = 8'($urandom);
            set_signal_args.value   = 8'($urandom);

            do_set_signal (addr, set_signal_args, messages_in_sync_period, exit_action);
        endtask

        // sync must be greater than reply_timeout for messages_in_sync_period / add_unexpected_pause to work
        // if the sens_enable, sens_read, adc_enable, adc_read are already asserted, this will return an error
        // and the process will not be started, so messages_in_sync_period / add_unexpected_pause won't work
        virtual task do_auto_read (StdBlockAddress addr, AutoReadRequestArgs auto_read_args, int messages_in_sync_period, ExitAction exit_action);
            automatic StatusReplyArgs   status_reply_args;
            automatic Signals           current_signals     = get_current_signals;

            // if the last operation caused an ADC read, then the conversion should be complete
            status_reply_args.flags.conv_complete       = last_op_caused_adc_read;
            // we wait for each command to finish before sending the next
            // so we can't already be busy
            status_reply_args.flags.already_busy        = last_op_still_busy;
            // if the last operation had an unexpected pause, then the flag should be set
            status_reply_args.flags.unexpected_pause    = last_op_had_unexpected_pause;
            // the error flag will be set if any of sens_enable, sens_read, adc_enable, adc_read are set
            status_reply_args.flags.error               = current_signals.sens_enable   |
                                                          current_signals.sens_read     |
                                                          current_signals.adc_enable    |
                                                          current_signals.adc_read;
            status_reply_args.flags.padding             = '0;


            //$display("  args: %p, expected reply args: %p", auto_read_args, status_reply_args);
            send_app_auto_read_request_verify_reply(addr, auto_read_args, status_reply_args);

            if (last_op_still_busy) begin
                // this new operation won't start
                // this flag should only be set if ExitAction_IMMEDIATE_RETURN was used
                // it's up to the caller to figure out when the current operation has finished
                return;
            end

            if (status_reply_args.flags.error) begin
                //$display("  error flag set");
                // didn't start the actual operation, so we're done
                check_signal_control_busy(1'b0); // make sure signal_control is not busy
                return;
            end

            // AUTO_READ always causes an ADC read (assuming it gets started)
            last_op_caused_adc_read = 1'b1;

            // if requested we send some fake messages during the sync period to cause pauses resetting
            // the sync period.
            //$display("  messages_in_sync_period: %d", messages_in_sync_period);
            repeat (messages_in_sync_period) begin
                // leave at least 64 ticks left in the sync period so we don't run into edge cases
                // we proved the sync period timings are correct in the signal_control_tb
                automatic int wait_ticks = $urandom_range(64, auto_read_args.sync - 64);
                //$display("    wait_ticks: %d", wait_ticks);
                wait_for_ticks_since_last_pause(wait_ticks);

                check_signal_control_busy(1'b1); // make sure signal_control is still busy

                // send a STD I-Block to another PICC
                send_std_i_block(get_std_block_address(CID_RANDOM_NOT_CURRENT, NAD_NONE),
                                 1'b0, 1'b0, '{});
            end

            if (exit_action == ExitAction_IMMEDIATE_RETURN) begin
                // not sending anything else, so no unexpected pauses
                // the caller may send additional messages while the operation is still ongoing
                // in which case they must deal with updating this flag
                last_op_had_unexpected_pause = 1'b0;
                return;
            end

            if (exit_action == ExitAction_SEND_EARLY_ABORT) begin
                // wait until we're in timing1, timing2 or the adc read period
                // we need time to send the full Command_ABORT message before the AUTO_READ completes.
                // This is to make sure the abort occurs while the signal_control module is busy
                // so make sure there's enough time for that.
                // Additionally to avoid the edge of the end of the sync period we randomly decide
                // if the abort should occur in the sync period or the wait_for_adc period.
                automatic int wait_ticks;

                if (1'($urandom)) begin
                    // starts in the sync period, each pause will reset the sync period
                    wait_ticks = $urandom_range(auto_read_args.sync - 32);
                end
                else begin
                    wait_ticks = auto_read_args.sync + 16 + $urandom_range(auto_read_args.timing1 +
                                                                           auto_read_args.timing2 +
                                                                           ADC_SIM_MIN_CYCLES     -
                                                                           max_rx_msg_ticks);
                end

                wait_for_ticks_since_last_pause(wait_ticks);

                check_signal_control_busy(1'b1); // make sure signal_control is still busy

                // send an abort command
                // this causes an unexpected pause, but the abort clears that flag anyway
                do_abort(addr);
            end
            else if (exit_action == ExitAction_SEND_UNEXPECTED_PAUSE) begin
                // wait until we're in timing1, timing2 or the adc read period
                automatic int wait_ticks = auto_read_args.sync + 16 +
                                           $urandom_range(auto_read_args.timing1 +
                                                          auto_read_args.timing2 +
                                                          ADC_SIM_MIN_CYCLES     -
                                                          32);

                wait_for_ticks_since_last_pause(wait_ticks);

                check_signal_control_busy(1'b1); // make sure signal_control is still busy

                // just send a fake message to cause a pause
                // send a STD I-Block to another PICC
                send_std_i_block(get_std_block_address(CID_RANDOM_NOT_CURRENT, NAD_NONE),
                                 1'b0, 1'b0, '{});

                last_op_had_unexpected_pause = 1'b1;

                // we just caused a new pause, but this doesn't change when the operation should end
                // the operation should run for at most sync + timing1 + timing2 + ADC_SIM_MAX_CYCLES,
                // since the last pause (not this one), but we know we are wait_ticks into that.
                wait_for_ticks_since_last_pause(auto_read_args.sync     +
                                                auto_read_args.timing1  +
                                                auto_read_args.timing2  +
                                                ADC_SIM_MAX_CYCLES      -
                                                wait_ticks              +
                                                512);
            end
            else begin
                // we have the sync period, timing1, timing2 and adc read.
                // plus there are up to two bit times of idle before the EOC is detected
                // so add an extra 512 ticks, to be sure.
                automatic int wait_ticks = auto_read_args.sync     +
                                           auto_read_args.timing1  +
                                           auto_read_args.timing2  +
                                           ADC_SIM_MAX_CYCLES      +
                                           512;

                last_op_had_unexpected_pause = 1'b0;

                //$display("  waiting for idle: %d", wait_ticks);
                wait_for_ticks_since_last_pause(wait_ticks);
            end

            //$display("  done");
            check_signal_control_busy(1'b0); // make sure we're not busy any more
            last_op_still_busy = 1'b0;
        endtask

        virtual task do_get_result (StdBlockAddress addr);
            automatic GetResultReplyArgs reply_args;

            // if the last operation caused an ADC read, then the conversion should be complete
            reply_args.flags.conv_complete      = last_op_caused_adc_read;
            // we wait for each command to finish before sending the next
            // so we can't already be busy
            reply_args.flags.already_busy       = last_op_still_busy;
            // if the last operation had an unexpected pause, then the flag should be set
            reply_args.flags.unexpected_pause   = last_op_had_unexpected_pause;
            // we send a valid command and we are not in an invalid start state for AUTO_READ
            reply_args.flags.error              = 1'b0;
            reply_args.flags.padding            = '0;

            reply_args.adc_value                = get_last_read_adc_value();

            send_app_get_result_request_verify_reply (addr, reply_args);

            // get result clear the conversion_complete flag.
            last_op_caused_adc_read             = 1'b0;
        endtask

        virtual task do_unsupported_cmd(StdBlockAddress addr);
            automatic StatusReplyArgs reply_args;

            // if the last operation caused an ADC read, then the conversion should be complete
            reply_args.flags.conv_complete      = last_op_caused_adc_read;
            // we wait for each command to finish before sending the next
            // so we can't already be busy
            reply_args.flags.already_busy       = last_op_still_busy;
            // if the last operation had an unexpected pause, then the flag should be set
            reply_args.flags.unexpected_pause   = last_op_had_unexpected_pause;
            // we send an invalid command, so we expect an error
            reply_args.flags.error              = 1'b1;
            reply_args.flags.padding            = '0;

            send_app_invalid_cmd_verify_reply(addr, reply_args);

            // get result does not resets flags, so they remain the same.
        endtask

        // ====================================================================
        // Tests
        // ====================================================================

        virtual task run_protocol_tests;
            automatic StdBlockAddress addr;

            // make sure we are in the protocol state and get our address
            go_to_state_protocol_std_comms(CID_RANDOM);
            addr = get_std_block_address(CID_CURRENT);

            // 1) Command_IDENTIFY
            // this command has a constant request and constant reply, there's no real reason to test it
            // lots, but it should also be quick, so test it the same as everything else.
            $display("1) Testing Command_IDENTIFY");
            repeat (num_loops_per_test) begin
                send_app_identify_request_verify_reply(addr);
            end

            // tests:
            //  2) Command_SET_SIGNAL, flags need to be tracked, but we should never respond with busy / error
            //      a) short sync time with no extra pauses
            $display("2a) Command_SET_SIGNAL, short sync time, no extra pauses");
            repeat (num_loops_per_test) begin
                do_set_signal_random_change(addr,
                                            $urandom_range(20),         // sync
                                            0,                          // messages_in_sync_period
                                            ExitAction_WAIT_FOR_IDLE);
            end

            //      b) long sync time with no extra pauses
            $display("2b) Command_SET_SIGNAL, long sync time, no extra pauses");
            repeat (num_loops_per_test) begin
                do_set_signal_random_change(addr,
                                            reply_timeout +             // sync
                                                $urandom_range(128),
                                            0,                          // messages_in_sync_period
                                            ExitAction_WAIT_FOR_IDLE);
            end

            //      c) with extra pauses during the sync period / wait_for_adc period (if any)
            $display("2c) Command_SET_SIGNAL with extra pauses");
            repeat (num_loops_per_test) begin
                do_set_signal_random_change(addr,
                                            reply_timeout +                                 // sync
                                                $urandom_range(128, 256),
                                            $urandom_range(0,2),                            // messages_in_sync_period
                                            1'($urandom) ? ExitAction_WAIT_FOR_IDLE
                                                         : ExitAction_SEND_UNEXPECTED_PAUSE);
            end

            // 3) Command_ABORT + Command_AUTO_READ + Command_GET_RESULT
            //      a) no extra pauses, short times
            $display("3a) Command_AUTO_READ, short times, no extra pauses");
            repeat (num_loops_per_test) begin
                automatic AutoReadRequestArgs args;
                args.sync       = $urandom_range(20);
                args.timing1    = $urandom_range(20);
                args.timing2    = $urandom_range(20);

                // resets the signals back to 0s, so the auto_read can run without an error occurring
                do_abort(addr);

                do_auto_read(addr,
                             args,
                             0,                         // messages_in_sync_period
                             ExitAction_WAIT_FOR_IDLE);

                do_get_result(addr);
            end

            //      b) no extra pauses, long sync time
            $display("3b) Command_AUTO_READ, long sync time, no extra pauses");
            repeat (num_loops_per_test) begin
                automatic AutoReadRequestArgs args;
                args.sync       = $urandom_range(reply_timeout, reply_timeout + 128);
                args.timing1    = $urandom_range(64, 128);
                args.timing2    = $urandom_range(64, 128);

                // resets the signals back to 0s, so the auto_read can run without an error occurring
                //$display("sending abort");
                do_abort(addr);

                //$display("sending auto_read");
                do_auto_read(addr,
                             args,
                             0,                         // messages_in_sync_period
                             ExitAction_WAIT_FOR_IDLE);

                //$display("sending get_result");
                do_get_result(addr);
            end

            //      c) with extra pauses during the sync period / timing1 / timing2 / wait_for_adc
            $display("3c) Command_AUTO_READ with extra pauses");
            repeat (num_loops_per_test) begin
                automatic AutoReadRequestArgs args;
                args.sync       = $urandom_range(reply_timeout, reply_timeout + 128);
                args.timing1    = $urandom_range(64, 128);
                args.timing2    = $urandom_range(64, 128);

                // resets the signals back to 0s, so the auto_read can run without an error occurring
                do_abort(addr);

                do_auto_read(addr,
                             args,
                             $urandom_range(0,2),                               // messages_in_sync_period
                             1'($urandom) ? ExitAction_WAIT_FOR_IDLE
                                          : ExitAction_SEND_UNEXPECTED_PAUSE);  // add_unexpected_pause

                do_get_result(addr);
            end

            //      d) SET_SIGNAL first to set up an error state and then AUTO_READ
            $display("3d) Command_AUTO_READ, from invalid start state");
            repeat (num_loops_per_test) begin
                automatic AutoReadRequestArgs args;
                args.sync       = $urandom_range(20);
                args.timing1    = $urandom_range(20);
                args.timing2    = $urandom_range(20);

                // quick SET_SIGNAL to randomise the signals
                do_set_signal_random_change(addr,
                                            $urandom_range(20),     // sync
                                            0,                      // messages_in_sync_period
                                            ExitAction_WAIT_FOR_IDLE);

                // This will probably return an error (unless SET_SIGNAL set the signals correctly)
                do_auto_read(addr,
                             args,
                             0,                         // messages_in_sync_period
                             ExitAction_WAIT_FOR_IDLE);
            end

            // 4) Command_SET_SIGNAL / Command_AUTO_READ + Command_ABORT
            //      a) Command_SET_SIGNAL
            $display("4a) Command_SET_SIGNAL + Command_ABORT");

            // resets the signals back to 0s, so the auto_read can run without an error occurring
            // do this outside of the loop because each call to do_auto_read is aborted and so
            // we can guarantee our state before each new AUTO_READ
            do_abort(addr);

            repeat (num_loops_per_test) begin
                do_set_signal_random_change(addr,
                                            reply_timeout + max_rx_msg_ticks +  // sync
                                                $urandom_range(32, 128),
                                            $urandom_range(0,1),                // messages_in_sync_period
                                            ExitAction_SEND_EARLY_ABORT);
            end

            //      b) Command_AUTO_READ
            $display("4b) Command_AUTO_READ + Command_ABORT");
            repeat (num_loops_per_test) begin
                automatic AutoReadRequestArgs args;
                args.sync       = reply_timeout + max_rx_msg_ticks + $urandom_range(32, 128);
                args.timing1    = max_rx_msg_ticks + $urandom_range(32, 128);
                args.timing2    = max_rx_msg_ticks + $urandom_range(32, 128);

                do_auto_read(addr,
                             args,
                             $urandom_range(0,1),   // messages_in_sync_period
                             ExitAction_SEND_EARLY_ABORT);

                // we aborted the read, so don't get the result
            end

            // 5) Manual Read (multiple SET_SIGNAL commands) + Command_GET_RESULT
            $display("5) Manual reads using Command_SET_SIGNAL");
            repeat (num_loops_per_test) begin
                automatic SetSignalRequestArgs args;

                // send an abort to ensure we're in a valid state to start
                do_abort(addr);

                // set sens_config
                args.sync = reply_timeout + $urandom_range(128, 256);
                args.mask = '0;
                args.value = '0;
                args.mask.sens_config = 3'($urandom);
                args.value.sens_config = 3'($urandom);

                do_set_signal(addr,
                              args,
                              $urandom_range(0,2),  // messages_in_sync_period
                              ExitAction_WAIT_FOR_IDLE);

                // set sens_enable
                args.sync = reply_timeout + $urandom_range(128, 256);
                args.mask = '0;
                args.value = '0;
                args.mask.sens_enable = 1'b1;
                args.value.sens_enable = 1'b1;

                do_set_signal(addr,
                              args,
                              $urandom_range(0,2),  // messages_in_sync_period
                              ExitAction_WAIT_FOR_IDLE);

                // set sens_read
                args.sync = reply_timeout + $urandom_range(128, 256);
                args.mask = '0;
                args.value = '0;
                args.mask.sens_read = 1'b1;
                args.value.sens_read = 1'b1;

                do_set_signal(addr,
                              args,
                              $urandom_range(0,2),  // messages_in_sync_period
                              ExitAction_WAIT_FOR_IDLE);

                // set adc_enable
                args.sync = reply_timeout + $urandom_range(128, 256);
                args.mask = '0;
                args.value = '0;
                args.mask.adc_enable = 1'b1;
                args.value.adc_enable = 1'b1;

                do_set_signal(addr,
                              args,
                              $urandom_range(0,2),  // messages_in_sync_period
                              ExitAction_WAIT_FOR_IDLE);

                // set adc_read
                args.sync = reply_timeout + $urandom_range(128, 256);
                args.mask = '0;
                args.value = '0;
                args.mask.adc_read = 1'b1;
                args.value.adc_read = 1'b1;

                do_set_signal(addr,
                              args,
                              $urandom_range(0,2),  // messages_in_sync_period
                              ExitAction_WAIT_FOR_IDLE);

                // finally get the result
                do_get_result(addr);
            end

            // 6) Test the busy flag is returned correctly
            // send SET_SIGNAL / AUTO_READ followed by SET_SIGNAL / AUTO_READ / GET_RESULT / unsupported command
            // before the first op has time to finish
            $display("6) Testing the busy flag is set");

            // send an abort to ensure we're in a valid state to start
            // each loop ends with an abort too
            do_abort(addr);

            repeat (num_loops_per_test) begin
                automatic int wait_ticks;

                // send a Command_SET_SIGNAL or a Command_AUTO_READ
                if (1'($urandom)) begin
                    // SET_SIGNAL
                    automatic SetSignalRequestArgs args;
                    args.sync   = reply_timeout + max_rx_msg_ticks + $urandom_range(128, 256);
                    args.mask   = 8'($urandom);
                    args.value  = 8'($urandom);

                    do_set_signal(addr,
                                  args,
                                  $urandom_range(0,2),          // messages_in_sync_period
                                  ExitAction_IMMEDIATE_RETURN);

                    // we need time to send the next message before the SET_SIGNAL completes.
                    // This is to make sure that the busy flag of the reply will be set,
                    // so make sure there's enough time for that.
                    // Additionally to avoid the edge of the end of the sync period we randomly decide
                    // if the abort should occur in the sync period or the wait_for_adc period.
                    if (1'($urandom) || !args.mask.adc_read || !args.value.adc_read) begin
                        wait_ticks = $urandom_range(args.sync) - 32;

                        // the next message will start in the sync period, and so unexpected_pause
                        // won't be set.
                        last_op_had_unexpected_pause = 1'b0;
                    end
                    else begin
                        wait_ticks = args.sync + 16 + $urandom_range(ADC_SIM_MIN_CYCLES  -
                                                                     max_rx_msg_ticks);

                        // the next message will start in the wait_for_adc period, and so unexpected_pause
                        // will be set.
                        last_op_had_unexpected_pause = 1'b1;
                    end
                end
                else begin
                    // AUTO_READ
                    automatic AutoReadRequestArgs args;
                    args.sync       = reply_timeout + max_rx_msg_ticks + $urandom_range(128, 256);
                    args.timing1    = max_rx_msg_ticks + $urandom_range(128, 256);
                    args.timing2    = max_rx_msg_ticks + $urandom_range(128, 256);

                    do_auto_read(addr,
                                 args,
                                 $urandom_range(0,2),          // messages_in_sync_period
                                 ExitAction_IMMEDIATE_RETURN);

                    if (1'($urandom)) begin
                        // starts in the sync period, each pause will reset the sync period
                        wait_ticks = $urandom_range(args.sync - 32);

                        // the next message will start in the sync period, and so unexpected_pause
                        // won't be set.
                        last_op_had_unexpected_pause = 1'b0;
                    end
                    else begin
                        wait_ticks = args.sync + 16 + $urandom_range(args.timing1       +
                                                                     args.timing2       +
                                                                     ADC_SIM_MIN_CYCLES -
                                                                     (max_rx_msg_ticks + 32));

                        // the next message will start in the timing1 / timing2 / wait_for_adc period,
                        // and so unexpected_pause will be set.
                        last_op_had_unexpected_pause = 1'b1;
                    end
                end

                // wait a bit
                wait_for_ticks_since_last_pause(wait_ticks);

                check_signal_control_busy(1'b1); // check we're still busy

                // we've set it up so that the next message will be received before the current operation
                // finishes. Meaning that last_op_caused_adc_read should not be set, but already_busy will be.
                // we've already dealt with last_op_had_unexpected_pause
                last_op_caused_adc_read = 1'b0;
                last_op_still_busy      = 1'b1;

                // Send one of SET_SIGNAL, AUTO_READ, GET_RESULT, unsupported message
                do_random_app_msg_test
                (
                    .identify           (1'b0),
                    .set_signal         (1'b1), .auto_read      (1'b1),
                    .get_result         (1'b1), .abort          (1'b0),
                    .unsupported_cmd    (1'b1), .invalid_magic  (1'b0),
                    .error              (1'b0),
                    .addr               (addr), .exit_action    (ExitAction_IMMEDIATE_RETURN)
                );

                // finally reset our state for the next test, this resets the stored flags and stops
                // the current operation.
                do_abort(addr);
            end

            // 7) invalid magic / errrors / invalid CRC
            //      a) invalid magic
            $display("7a) Invalid magic");
            repeat (num_loops_per_test) begin
                send_app_invalid_magic_verify_no_app_reply(addr);
            end

            //      b) errors / CRC corruption
            $display("7b) Errors / CRC corruption");
            repeat (num_loops_per_test) begin
                send_app_msg_with_error(addr);
            end

            // 8) random message + ACK with invalid block num (app_resend_last)
            //      a) wait for the first operation to complete before asserting app_resend_last
            //         so that we don't change any of the status bits
            $display("8a) Testing sending an ACK/NACK to test app_resend_last while idle");
            repeat (num_loops_per_test) begin
                automatic ExitAction exit_action;

                // first send a random valid message
                case ($urandom_range(2))
                    0: exit_action = ExitAction_WAIT_FOR_IDLE;
                    1: exit_action = ExitAction_SEND_UNEXPECTED_PAUSE;
                    2: exit_action = ExitAction_SEND_EARLY_ABORT;
                endcase

                // allow invalid magic / unsupported command, but not errors / crc corruption
                // AKA at least iso_14443_4a should respond.
                do_random_app_msg_test
                (
                    .identify           (1'b1),
                    .set_signal         (1'b1), .auto_read      (1'b1),
                    .get_result         (1'b1), .abort          (1'b1),
                    .unsupported_cmd    (1'b1), .invalid_magic  (1'b1),
                    .error              (1'b0),
                    .addr               (addr), .exit_action    (exit_action)
                );

                // toggle the PCD block num (fake not having received the reply)
                picc_target.toggle_pcd_block_num;

                // ISO/IEC 14443-4:2016 section 7.5.5.3 rule 11) states that
                // When an R(ACK) or an R(NAK) block is received, if it's block number is equal
                // to the PICC's current block number, the last block shall be re-transmitted.
                // Wheras section 7.5.6.2 b) states:
                // toggle its block number then send an R(NAK) block and expect to receive
                // the last I-block from the PICC [rule 11].
                // So as a sanity check, thest these are the same thing (aka, toggling pcd_block_num
                // means the pcd's and picc's are equeal
                if (!picc_target.picc_and_pcd_block_nums_are_equal) begin
                    // The PCD's is not equal to the PICC's block num.
                    // we want to test when they are equal
                    $fatal(0, "PCD block num != PICC block num (in the DUT)");
                end

                // send an R(ACK) or R(NAK)
                // don't randomize the power signal
                // or this beraks the verify_repeat_last checking
                randomise_power = 1'b0;

                // send an ACK or a NAK
                if (1'($urandom)) begin
                    send_std_r_ack_verify_resend_last(addr);
                end
                else begin
                    send_std_r_nak_verify_resend_last(addr);
                end

                // go back to randomising the power signal after every transmit
                randomise_power = 1'b1;
            end

            //      b) while not idle
            $display("8b) Testing sending an ACK/NACK to test app_resend_last while busy");

            // make sure we start in a valid state
            do_abort(addr);

            repeat (num_loops_per_test) begin
                automatic int   wait_ticks;
                automatic logic starts_adc_read;

                // send a Command_SET_SIGNAL or a Command_AUTO_READ
                if (1'($urandom)) begin
                    // SET_SIGNAL
                    automatic SetSignalRequestArgs args;
                    args.sync   = reply_timeout + max_rx_msg_ticks + $urandom_range(128, 256);
                    args.mask   = 8'($urandom);
                    args.value  = 8'($urandom);

                    do_set_signal(addr,
                                  args,
                                  $urandom_range(0,2),          // messages_in_sync_period
                                  ExitAction_IMMEDIATE_RETURN);

                    // we need time to send the next message before the SET_SIGNAL completes.
                    // This is to make sure that the busy flag of the reply will be set,
                    // so make sure there's enough time for that.
                    // Additionally to avoid the edge of the end of the sync period we randomly decide
                    // if the abort should occur in the sync period or the wait_for_adc period.
                    if (1'($urandom) || !args.mask.adc_read || !args.value.adc_read) begin
                        wait_ticks = $urandom_range(args.sync) - 32;

                        // the next message will start in the sync period, and so unexpected_pause
                        // won't be set.
                        last_op_had_unexpected_pause = 1'b0;
                    end
                    else begin
                        wait_ticks = args.sync + 16 + $urandom_range(ADC_SIM_MIN_CYCLES  -
                                                                     max_rx_msg_ticks);

                        // the next message will start in the wait_for_adc period, and so unexpected_pause
                        // will be set.
                        last_op_had_unexpected_pause = 1'b1;
                    end

                    starts_adc_read = (args.mask.adc_read && args.value.adc_read);
                end
                else begin
                    // AUTO_READ
                    automatic AutoReadRequestArgs args;
                    args.sync       = reply_timeout + max_rx_msg_ticks + $urandom_range(128, 256);
                    args.timing1    = max_rx_msg_ticks + $urandom_range(128, 256);
                    args.timing2    = max_rx_msg_ticks + $urandom_range(128, 256);

                    do_auto_read(addr,
                                 args,
                                 $urandom_range(0,2),          // messages_in_sync_period
                                 ExitAction_IMMEDIATE_RETURN);

                    if (1'($urandom)) begin
                        // starts in the sync period, each pause will reset the sync period
                        wait_ticks = $urandom_range(args.sync - 32);

                        // the next message will start in the sync period, and so unexpected_pause
                        // won't be set.
                        last_op_had_unexpected_pause = 1'b0;
                    end
                    else begin
                        wait_ticks = args.sync + 16 + $urandom_range(args.timing1       +
                                                                     args.timing2       +
                                                                     ADC_SIM_MIN_CYCLES -
                                                                     (max_rx_msg_ticks + 32));

                        // the next message will start in the timing1 / timing2 / wait_for_adc period,
                        // and so unexpected_pause will be set.
                        last_op_had_unexpected_pause = 1'b1;
                    end

                    starts_adc_read = 1'b1;
                end

                // wait a bit
                wait_for_ticks_since_last_pause(wait_ticks);

                //$display("here");
                check_signal_control_busy(1'b1); // check we're still busy

                // we've set it up so that the next message will be received before the current operation
                // finishes. Meaning that last_op_caused_adc_read should not be set, but already_busy will be.
                // we've already dealt with last_op_had_unexpected_pause.
                // NOTE: These only affect the next STD I-Block sent and not the R(ACK) / R(NAK) we send now
                last_op_caused_adc_read = 1'b0;
                last_op_still_busy      = 1'b1;

                // toggle the PCD block num (fake not having received the reply)
                picc_target.toggle_pcd_block_num;

                // ISO/IEC 14443-4:2016 section 7.5.5.3 rule 11) states that
                // When an R(ACK) or an R(NAK) block is received, if it's block number is equal
                // to the PICC's current block number, the last block shall be re-transmitted.
                // Wheras section 7.5.6.2 b) states:
                // toggle its block number then send an R(NAK) block and expect to receive
                // the last I-block from the PICC [rule 11].
                // So as a sanity check, thest these are the same thing (aka, toggling pcd_block_num
                // means the pcd's and picc's are equeal
                if (!picc_target.picc_and_pcd_block_nums_are_equal) begin
                    // The PCD's is not equal to the PICC's block num.
                    // we want to test when they are equal
                    $fatal(0, "PCD block num != PICC block num (in the DUT)");
                end

                // send an R(ACK) or R(NAK)
                // don't randomize the power signal
                // or this beraks the verify_repeat_last checking
                randomise_power = 1'b0;

                // send an ACK or a NAK
                // this automatically verifies the response is exactly the same as the last one
                // and that the sending of the R(ACK) / R(NAK) does not affect the status bits
                // of that reply
                if (1'($urandom)) begin
                    send_std_r_ack_verify_resend_last(addr);
                end
                else begin
                    send_std_r_nak_verify_resend_last(addr);
                end

                // go back to randomising the power signal after every transmit
                randomise_power = 1'b1;

                // wait until we are idle
                wait_for_signal_control_idle();

                // any ADC conversion will now be completed
                last_op_caused_adc_read = starts_adc_read;
                // we will no longer be busy
                last_op_still_busy      = 1'b0;

                // send a get_result message to check that the status bits are correct as calculated before
                do_get_result(addr);

                // finally reset our state for the next test, this resets the stored flags and stops
                // the current operation.
                do_abort(addr);
            end
        endtask
    endclass

endpackage
