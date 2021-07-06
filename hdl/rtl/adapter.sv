/***********************************************************************
        File: adapter.sv
 Description: The adapter between the ISO/IEC 14443A IP core
              and the radiation sensor / ADC.
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

module adapter
(
    // clk is our 13.56MHz input clock.
    input                   clk,

    // rst_n is our active low synchronised asynchronous reset signal
    input                   rst_n,

    // pause_n_synchronised is the synchronised pause_n signal.
    // since the clock stops during pause frames, we can only expect pause_n_synchronised
    // to be asserted (0) for a couple of clock ticks.
    // So we just look for rising edges (end of pause).
    // We use this to synchronise certain actions between multiple PICCs
    input                   pause_n_synchronised,

    // Interface with the ISO/IEC 14443A IP core
    rx_interface.in_byte    rx_iface,
    tx_interface.out_byte   tx_iface,
    input                   app_resend_last,

    // Interface with the radiation sensor / ADC
    output logic    [2:0]   sens_config,
    output logic            sens_enable,
    output logic            sens_read,
    output logic            adc_enable,
    output logic            adc_read,
    input                   adc_conversion_complete,
    input           [15:0]  adc_value,

    // Version info, passed from the relevant blocks
    logic [3:0]             const_iso_iec_14443a_digital_version,
    logic [3:0]             const_iso_iec_14443a_AFE_version,
    logic [3:0]             const_sensor_version,
    logic [3:0]             const_adc_version
);

    import protocol_pkg::*;

    // The version of this adapter
    // bump this before fabrication if there has been any change to this adapter
    // or the protocol.
    localparam logic [7:0]  ADAPTER_VERSION     = 8'd1;

    // ========================================================================
    // Rx buffer and decoding
    // ========================================================================

    // actual receive buffer
    logic [7:0] rx_buffer [RX_BUFF_LEN];

    // These are directly mapped from the buffer, and as such the byte orders are swapped
    // don't use these, use the decoded values below
    Message                 rx_msg;
    SetSignalRequestArgs    set_signal_req_args;
    AutoReadRequestArgs     auto_read_req_args;

    // decoded values, use these
    logic [31:0]    rx_magic;
    Command         rx_cmd;
    logic [15:0]    sync_timing;
    logic [31:0]    auto_read_timing1;
    logic [31:0]    auto_read_timing2;
    Signals         set_signals_mask;
    Signals         set_signals_value;

    assign rx_magic = {<<byte{rx_msg.magic}};
    assign rx_cmd   = Command'({<<byte{rx_msg.cmd}});

    // I designed the SET_SIGNAL and AUTO_READ commands so that the sync argument
    // comes at the same place in the buffer in each. So this mux should get optimised
    // out. I wanted to add it anyway to be more explicit, and so that things continue
    // to work if the messages get adjusted.
    assign sync_timing          = (rx_cmd == Command_SET_SIGNAL)
                                        ? {<<byte{set_signal_req_args.sync}}
                                        : {<<byte{auto_read_req_args.sync}};

    assign auto_read_timing1    = {<<byte{auto_read_req_args.timing1}};
    assign auto_read_timing2    = {<<byte{auto_read_req_args.timing2}};

    assign set_signals_mask     = Signals'({<<byte{set_signal_req_args.mask}});
    assign set_signals_value    = Signals'({<<byte{set_signal_req_args.value}});

    // fill in the above structs from the rx_buffer
    always_comb begin
        // header
        rx_msg              = {>>byte{rx_buffer[0:4]}};

        // arguments for Command_SET_SIGNAL
        set_signal_req_args = {>>byte{rx_buffer[5:8]}};

        // arguments for Command_AUTO_READ
        auto_read_req_args  = {>>byte{rx_buffer[5:14]}};

        // The remaining messages don't have any arguments to decode
    end

    // ========================================================================
    // Tx buffer and encoding
    // ========================================================================

    logic [7:0] tx_buffer [TX_BUFF_LEN];

    Command             reply_cmd;
    logic [15:0]        cached_adc_value;
    StatusFlags         status_flags;

    // These are all encoded with the byte order swapped using the {<<byte{...}} streaming
    // operator. This lets us encode the tx_buffer easier, but means you shouldn't read
    // directly from any of these.
    Message             tx_msg;
    IdentifyReplyArgs   identify_reply_args;
    StatusReplyArgs     status_reply_args;
    GetResultReplyArgs  get_result_reply_args;

    // header (5 bytes)
    assign tx_msg.magic                                 = {<<byte{PROTOCOL_MAGIC}};
    assign tx_msg.cmd                                   = {<<byte{reply_cmd}};

    // the identify reply is based off parameters and inputs that should be constant
    assign identify_reply_args.protocol_version         = PROTOCOL_VERSION;
    assign identify_reply_args.adapter_version          = ADAPTER_VERSION;
    assign identify_reply_args.iso_iec_14443a_version   = {const_iso_iec_14443a_digital_version,
                                                           const_iso_iec_14443a_AFE_version};
    assign identify_reply_args.sensor_adc_version       = {const_sensor_version,
                                                           const_adc_version};

    // GetResultReplyArgs and StatusReplyArgs both contain StatusFlags
    assign status_reply_args.flags                      = {<<byte{status_flags}};
    assign get_result_reply_args.flags                  = {<<byte{status_flags}};

    assign status_flags.padding                         = '0;

    // GetResultReplyArgs also contains the cached ADC value
    assign get_result_reply_args.adc_value              = {<<byte{cached_adc_value}};

    // fill in the tx_buffer based on the reply we want to send
    always_comb begin
        // header (5 bytes) (little endian encoded)
        tx_buffer[0:4] = {>>byte{tx_msg}};

        case(reply_cmd)
            Command_IDENTIFY:   tx_buffer[5:TX_BUFF_LEN-1] = {>>byte{identify_reply_args}};
            Command_GET_RESULT: tx_buffer[5:TX_BUFF_LEN-1] = {>>byte{get_result_reply_args}};
            default:            tx_buffer[5:TX_BUFF_LEN-1] = {>>byte{status_reply_args}};
        endcase
    end

    // ========================================================================
    // Signal Control
    // ========================================================================
    logic           signal_control_start;
    logic           signal_control_abort;
    logic           signal_control_result_read;
    logic           signal_control_busy;
    logic           signal_control_unexpected_pause;
    logic           signal_control_conversion_complete;
    logic   [15:0]  signal_control_adc_value;
    Signals         signals;

    assign sens_config  = signals.sens_config;
    assign sens_enable  = signals.sens_enable;
    assign sens_read    = signals.sens_read;
    assign adc_enable   = signals.adc_enable;
    assign adc_read     = signals.adc_read;

    signal_control signal_control_inst
    (
        .clk                            (clk),
        .rst_n                          (rst_n),

        .pause_n_synchronised           (pause_n_synchronised),

        .sync_timing                    (sync_timing),
        .auto_read_timing1              (auto_read_timing1[24:0]),
        .auto_read_timing2              (auto_read_timing2[24:0]),

        .cmd                            (rx_cmd),

        .set_signals_mask               (set_signals_mask),
        .set_signals_value              (set_signals_value),

        .start                          (signal_control_start),
        .abort                          (signal_control_abort),

        .result_read                    (signal_control_result_read),

        .signals                        (signals),
        .adc_conversion_complete        (adc_conversion_complete),
        .adc_value                      (adc_value),

        .busy                           (signal_control_busy),
        .unexpected_pause               (signal_control_unexpected_pause),
        .cached_adc_conversion_complete (signal_control_conversion_complete),
        .cached_adc_value               (signal_control_adc_value)
    );

    // ========================================================================
    // Receive data from the rx_iface into the rx_buffer
    // ========================================================================

    // max message length is 17 bytes (including CRC) -> 5 bits
    logic [4:0] rx_count;
    logic       rx_error_flag;

    always_ff @(posedge clk, negedge rst_n) begin
        if (!rst_n) begin
            rx_count        <= '0;
            rx_error_flag   <= 1'b0;
        end
        else begin
            if (rx_iface.soc) begin
                // start of a new message
                rx_count        <= '0;
                rx_error_flag   <= 1'b0;
            end

            if (rx_iface.error) begin
                rx_error_flag <= 1'b1;
            end

            if (rx_iface.data_valid) begin
                if (rx_count < $bits(rx_count)'(RX_BUFF_LEN)) begin
                    rx_buffer[rx_count] <= rx_iface.data;
                end

                // keep counting even if the buffer is full
                // this is so we can compare the received bytes with the expected
                // number of bytes for each message (including the CRC)
                if (rx_count != '1) begin
                    rx_count <= rx_count + 1'd1;
                end
            end
        end
    end

    // ========================================================================
    // Handle Rx messages
    // ========================================================================

    logic is_rx_cmd_identify;
    logic is_rx_cmd_set_signal;
    logic is_rx_cmd_auto_read;
    logic is_rx_cmd_get_result;
    logic is_rx_cmd_abort;

    assign is_rx_cmd_identify       = (rx_cmd == Command_IDENTIFY) &&
                                      (rx_count == COMMAND_IDENTIFY_REQUEST_LEN);

    assign is_rx_cmd_set_signal     = (rx_cmd == Command_SET_SIGNAL) &&
                                      (rx_count == COMMAND_SET_SIGNAL_REQUEST_LEN);

    assign is_rx_cmd_auto_read      = (rx_cmd == Command_AUTO_READ) &&
                                      (rx_count == COMMAND_AUTO_READ_REQUEST_LEN);

    assign is_rx_cmd_get_result     = (rx_cmd == Command_GET_RESULT) &&
                                      (rx_count == COMMAND_GET_RESULT_REQUEST_LEN);

    assign is_rx_cmd_abort          = (rx_cmd == Command_ABORT) &&
                                      (rx_count == COMMAND_ABORT_REQUEST_LEN);

    logic send_reply;
    logic last_rx_had_invalid_magic;

    always_ff @(posedge clk, negedge rst_n) begin
        if (!rst_n) begin
            send_reply <= 1'b0;

            // We need to initialise this, so that if app_resend_last asserts
            // before we send any reply, we actually have something valid to send.
            // This should never happen as the ISO/IEC 14443A IP core should never
            // assert app_resend_last until a STD I-Block has been received and a
            // reply has been sent.
            // We use Command_IDENTIFY here so that the reply is our version info
            reply_cmd                       <= Command_IDENTIFY;

            last_rx_had_invalid_magic       <= 1'b0;

            status_flags.already_busy       <= 1'b0;
            status_flags.conv_complete      <= 1'b0;
            status_flags.error              <= 1'b0;

            cached_adc_value                <= '0;

            signal_control_result_read      <= 1'b0;
        end
        else begin
            // should only assert for one tick
            send_reply                  <= 1'b0;
            signal_control_start        <= 1'b0;
            signal_control_abort        <= 1'b0;
            signal_control_result_read  <= 1'b0;

            if (app_resend_last && !last_rx_had_invalid_magic) begin
                // we already have reply_cmd set, so just indicate that we want to reply
                send_reply  <= 1'b1;
            end
            else if (rx_iface.eoc) begin
                // received a packet
                // rx_iface.error can be set on the EOC, and in that case the rx_error_flag
                // won't have been updated yet.
                if (!rx_error_flag && !rx_iface.error) begin
                    // valid packet

                    // check if the magic is correct
                    if (rx_magic != PROTOCOL_MAGIC) begin
                        // it's not. We don't respond when there's an invalid magic
                        // but if an app_resend_last comes in next we need to make sure
                        // we still don't respond
                        last_rx_had_invalid_magic   <= 1'b1;
                    end
                    else begin
                        last_rx_had_invalid_magic   <= 1'b0;

                        // at this point we always respond
                        send_reply  <= 1'b1;
                        reply_cmd   <= rx_cmd;

                        // assume there's no error, this can be overridden below
                        status_flags.error <= 1'b0;

                        // update the other status flags
                        status_flags.conv_complete      <= signal_control_conversion_complete;
                        status_flags.already_busy       <= signal_control_busy;
                        status_flags.unexpected_pause   <= signal_control_unexpected_pause;

                        if (is_rx_cmd_identify) begin
                            // IDENTIFY
                            // nothing to do here, since the response is always the same
                            // and is already set up.
                        end
                        else if (is_rx_cmd_set_signal) begin
                            // SET_SIGNAL
                            // start the signal_control logic
                            // everything else is passed in directly
                            signal_control_start <= 1'b1;
                        end
                        else if (is_rx_cmd_auto_read) begin
                            // AUTO_READ
                            // only valid if sens_enable, sens_read, adc_enable and adc_read
                            // are not currently asserted
                            if (sens_enable || sens_read || adc_enable || adc_read) begin
                                // invalid start conditions
                                status_flags.error <= 1'b1;
                            end
                            else begin
                                // start the signal_control logic
                                // everything else is passed in directly
                                signal_control_start <= 1'b1;
                            end
                        end
                        else if (is_rx_cmd_get_result) begin
                            // GET_RESULT

                            // update the reported result with the value reported by the signal_control module
                            cached_adc_value            <= signal_control_adc_value;

                            if (signal_control_conversion_complete) begin
                                // clear the signal_control_conversion_complete flag
                                // as we have now read the result
                                signal_control_result_read  <= 1'b1;
                            end
                        end
                        else if (is_rx_cmd_abort) begin
                            // ABORT
                            // abort any current signal_control operation
                            signal_control_abort    <= 1'b1;
                            // and clear the status_flags
                            status_flags.conv_complete      <= 1'b0;
                            status_flags.already_busy       <= 1'b0;
                            status_flags.unexpected_pause   <= 1'b0;
                        end
                        else begin
                            // unknown message or invalid length
                            // we respond with the appropriate command and the error flag set
                            status_flags.error <= 1'b1;
                        end
                    end
                end
            end
        end
    end

    // ========================================================================
    // Transmit Tx messages
    // ========================================================================

    logic [3:0] tx_len;
    logic [3:0] tx_idx;
    assign tx_len = get_reply_len(reply_cmd);

    // since tx_idx is not initialised until rst_n asserts
    // VCS doesn't like it if we use it as an index:
    // assign tx_iface.data = tx_buffer[tx_idx];
    // However if we initialise tx_idx in the declaration to '0; then
    // dc_compiler complains about initial assignments being ignored.
    // the below code should synthesise to a mux with inputs 0 to TX_BUFF_LEN-1
    // being tx_buffer[0] to tx_buffer[TX_BUFF_LEN-1], and all remaining inputs being
    // tx_buffer[0]. Both synthesis and simulation are happy with this
    always_comb begin
        tx_iface.data = tx_buffer[0]; // default to [0]
        for (int unsigned i = 0; i < TX_BUFF_LEN; i++) begin
            if (tx_idx == 4'(i)) begin
                tx_iface.data = tx_buffer[i];
                break;
            end
        end
    end
    assign tx_iface.data_bits   = 3'd0;         // all transfers are 8 bits wide

    // VCS doesn't generate a valid SAIF file, if I assign to interface members directly
    // in a sequential block.
    logic tx_iface_data_valid;
    assign tx_iface.data_valid = tx_iface_data_valid;

    always_ff @(posedge clk, negedge rst_n) begin
        if (!rst_n) begin
            tx_iface_data_valid <= 1'b0;
            tx_idx              <= 4'b0;
        end
        else begin
            if (send_reply) begin
                tx_iface_data_valid <= 1'b1;
                tx_idx              <= 4'b0;
            end

            if (tx_iface.req) begin
                if ((tx_idx + 1'd1) == tx_len) begin
                    // done
                    tx_iface_data_valid <= 1'b0;
                end
                else begin
                    tx_idx <= tx_idx + 1'd1;
                end
            end
        end
    end

endmodule
