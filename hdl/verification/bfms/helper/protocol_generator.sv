/***********************************************************************
        File: protocol_generator.sv
 Description: class for generation of our protocol messages
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

package protocol_generator_pkg;

    import protocol_pkg::*;

    typedef logic [7:0] ByteQueue [$];

    // Messages
    //  IDENTIFY
    //  SET_SIGNAL
    //  AUTO_READ
    //  GET_RESULT
    //  ABORT

    // ====================================================================
    // Generic (ByteQueueTransaction)
    // ====================================================================

    function ByteQueue generate_message (logic [7:0] cmd, logic [7:0] args [$] = '{}, logic [31:0] magic = PROTOCOL_MAGIC);
        automatic logic [7:0] inf [$] = '{};

        // add magic (little endian)
        inf.push_back(magic[7:0]);
        inf.push_back(magic[15:8]);
        inf.push_back(magic[23:16]);
        inf.push_back(magic[31:24]);
        // add cmd
        inf.push_back(cmd);

        // add args
        inf = {inf, args};

        return inf;
    endfunction

    // ====================================================================
    // For Rx (Requests)
    // ====================================================================

    function ByteQueue generate_identify_request;
        return generate_message(Command_IDENTIFY);
    endfunction

    function ByteQueue generate_set_signal_request (SetSignalRequestArgs set_signal_args);
        automatic logic [7:0] args [4];

        args[0] = set_signal_args.sync[7:0];
        args[1] = set_signal_args.sync[15:8];

        args[2] = set_signal_args.mask;
        args[3] = set_signal_args.value;

        return generate_message(Command_SET_SIGNAL, args);
    endfunction

    function ByteQueue generate_auto_read_request (AutoReadRequestArgs auto_read_args);
        automatic logic [7:0] args [10];

        args[0] = auto_read_args.sync[7:0];
        args[1] = auto_read_args.sync[15:8];

        // we only use 25 bits for timing1 / timing2, randomise the unused MSbs
        args[2] = auto_read_args.timing1[7:0];
        args[3] = auto_read_args.timing1[15:8];
        args[4] = auto_read_args.timing1[23:16];
        args[5] = {7'($urandom), auto_read_args.timing1[24]};

        args[6] = auto_read_args.timing2[7:0];
        args[7] = auto_read_args.timing2[15:8];
        args[8] = auto_read_args.timing2[23:16];
        args[9] = {7'($urandom), auto_read_args.timing2[24]};

        return generate_message(Command_AUTO_READ, args);
    endfunction

    function ByteQueue generate_get_result_request;
        return generate_message(Command_GET_RESULT);
    endfunction

    function ByteQueue generate_abort_request;
        return generate_message(Command_ABORT);
    endfunction

    function ByteQueue generate_random_non_valid;
        automatic logic [7:0]   cmd;
        automatic int           args_len    = $urandom_range(10);   // 10 is the max length of a valid request
        automatic logic [7:0]   args [$]    = '{};

        std::randomize(cmd) with
        {
            cmd != Command_IDENTIFY;
            cmd != Command_SET_SIGNAL;
            cmd != Command_AUTO_READ;
            cmd != Command_GET_RESULT;
            cmd != Command_ABORT;
        };

        repeat(args_len) begin
            args.push_back($urandom);
        end

        return generate_message(cmd, args);
    endfunction

    function ByteQueue generate_invalid_magic;
        automatic logic [31:0]  magic;
        automatic logic [7:0]   cmd;
        automatic int           args_len;
        automatic logic [7:0]   args [$] = '{};

        std::randomize(magic) with { magic != PROTOCOL_MAGIC; };

        // cmd can be anything valid or invalid
        cmd = 8'($urandom);

        args_len = $urandom_range(32);
        repeat(args_len) begin
            args.push_back($urandom);
        end

        return generate_message(cmd, args, magic);
    endfunction

    // ====================================================================
    // For Tx (Replies)
    // ====================================================================

    function ByteQueue generate_identify_reply (IdentifyReplyArgs identify_reply_args);
        automatic logic [7:0] args [4];

        // we use parameters here because this reply is static in the DUT too.
        args[0] = identify_reply_args.protocol_version;
        args[1] = identify_reply_args.adapter_version;
        args[2] = identify_reply_args.iso_iec_14443a_version;
        args[3] = identify_reply_args.sensor_adc_version;

        return generate_message(Command_IDENTIFY, args);
    endfunction

    function ByteQueue generate_get_result_reply (GetResultReplyArgs get_result_args);
        automatic logic [7:0] args [3];

        args[0] = get_result_args.flags;
        args[1] = get_result_args.adc_value[7:0];
        args[2] = get_result_args.adc_value[15:8];

        return generate_message(Command_GET_RESULT, args);
    endfunction

    function ByteQueue generate_status_reply (logic [7:0] cmd, StatusReplyArgs status_reply_args);
        automatic logic [7:0] args [1];

        args[0] = status_reply_args.flags;

        return generate_message(cmd, args);
    endfunction

    function ByteQueue generate_set_signal_reply (StatusReplyArgs status_reply_args);
        return generate_status_reply(Command_SET_SIGNAL, status_reply_args);
    endfunction

    function ByteQueue generate_auto_read_reply (StatusReplyArgs status_reply_args);
        return generate_status_reply(Command_AUTO_READ, status_reply_args);
    endfunction

    function ByteQueue generate_abort_reply (StatusReplyArgs status_reply_args);
        return generate_status_reply(Command_ABORT, status_reply_args);
    endfunction

endpackage
