/***********************************************************************
        File: generate_top_saif_tb.sv
 Description: Testbench to generate a .saif file for power analysis
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

// This is based on radiation_sensor_digital_top_tb
// I've removed a lot of the verification code as the goal here is not to verify the behaviour
// but generate a .saif with an accurate representation of design use.

module generate_top_saif_tb;

    import protocol_pkg::*;
    import std_block_address_pkg::StdBlockAddress;

    // --------------------------------------------------------------
    // Ports to DUT
    // all named the same as in the DUT, so I can use .*
    // --------------------------------------------------------------

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

    // We don't know what the actual clock frequency the PCD will use. To be in spec
    // it has to be 13.56 MHz +/- 7KHz. Power usage is based on switching frequency,
    // so I use the max possible.
    localparam real CLOCK_FREQ_HZ       = 13560000.0 + 7000.0;  // 13.56MHz + 7KHz
    localparam real CLOCK_PERIOD_PS     = 1000000000000.0 / CLOCK_FREQ_HZ;
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

    // In order to minimise idle periods in the .saif, I've reduced these compared to
    // in the radiation_sensor_digital_top_tb. This works OK for now, but could cause
    // problems if we expand this TB to include messages in the sync period.
    localparam int ADC_SIM_MIN_CYCLES = 5000;
    localparam int ADC_SIM_MAX_CYCLES = 8000;

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

    // ----------------------------------------------------------------
    // pause_n_synchronised monitoring
    // ----------------------------------------------------------------

    longint last_pause_time;
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

    // ----------------------------------------------------------------
    // Extend AppCommsTestsSequence to do TB specific stuff
    // ----------------------------------------------------------------

    class SAIF_TbSequence
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
                      0);                   // we don't actually run any of the tests

        endfunction

        virtual task do_reset;
            rst_n <= 1'b0;
            repeat (5) @(posedge clk) begin end
            rst_n <= 1'b1;
            repeat (5) @(posedge clk) begin end
        endtask

        virtual protected function void set_power_input(logic [1:0] _power);
            power = _power;
        endfunction

        // pure virtual, must be overwritten
        virtual function logic verify_dut_cid(logic [3:0] expected);
            // don't care about verifying anything here
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
            identify_reply_args.adapter_version         = dut.adapter_inst.ADAPTER_VERSION;
            identify_reply_args.iso_iec_14443a_version  = {4'(dut.iso14443a_inst.ISO_IEC_14443A_VERSION),
                                                           afe_version};
            identify_reply_args.sensor_adc_version      = {sens_version,
                                                           adc_version};

            return identify_reply_args;
        endfunction

        task generate_saif;
            automatic StdBlockAddress       addr;
            automatic AutoReadRequestArgs   auto_read_args;
            automatic SetSignalRequestArgs  set_signal_args;

            auto_read_args.sync     = 10;
            auto_read_args.timing1  = 10;
            auto_read_args.timing2  = 10;

            set_signal_args.sync    = 10;
            set_signal_args.mask    = '1;   // set all signals
            set_signal_args.value   = '0;   // to 0

            // Set up to generate the .saif
            $set_gate_level_monitoring("rtl_on", "sv");
            $set_toggle_region(dut);
            $toggle_start;

            // run all the initialisation comms to enter protocol state, then get our address
            go_to_state_protocol_std_comms(CID_RANDOM);
            addr = get_std_block_address(CID_CURRENT);

            // Command_IDENTIFY
            send_app_identify_request_verify_reply(addr);

            // make a few readings
            repeat (5) begin

                // Command_AUTO_READ
                do_auto_read(addr, auto_read_args, 0, ExitAction_WAIT_FOR_IDLE);

                // Command_GET_RESULT
                do_get_result(addr);

                // Command_SET_SIGNAL (reset back to idle, ready to start again)
                do_set_signal(addr, set_signal_args, 0, ExitAction_WAIT_FOR_IDLE);
            end

            $toggle_stop;
            $toggle_report("radiation_sensor_digital_top.saif", 1.0e-9, dut);

        endtask

    endclass

    SAIF_TbSequence seq;

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

        power           = 2'b00;

        // Set these once (they are constants in the real design)
        afe_version     = 4'($urandom);
        adc_version     = 4'($urandom);
        sens_version    = 4'($urandom);

        analogue_sim_inst.init();   // inits the RxDriver

        tx_monitor          = new(lm_iface);

        rx_send_queue       = new('{});
        tx_recv_queue       = new('{});

        rx_trans_gen        = new(1'b1);    // Rx messages must have CRCs applied
        tx_trans_gen        = new(1'b1);    // Tx messages will have CRCs applied

        rx_trans_conv       = new(1'b1);    // Rx messages must have parity bits
        tx_trans_conv       = new(1'b1);    // Tx messages will have parity bits

        picc_uid            = new('x);

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

        // randomise the variable part of the UID
        picc_uid.randomize;
        full_uid = picc_uid.get_uid;
        $display("NOTE: New UID: %s", picc_uid.to_string);
        seq.do_reset;

        // send messages
        seq.generate_saif;

        repeat (5) @(posedge clk) begin end

        $stop;
    end

    // --------------------------------------------------------------
    // Asserts
    // --------------------------------------------------------------


endmodule
