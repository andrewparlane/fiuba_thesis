/***********************************************************************
        File: protocol_pkg.sv
 Description: App level protocol for accessing the radiation sensor.
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

package protocol_pkg;

    // ========================================================================
    // Protocol definitions / structures
    // ========================================================================

    // Each message starts with a 4 byte magic.
    // This is so the PCD and PICC can tell that the other is talking the same protocol.
    // Since ISO/IEC 14443A does not specify specific application messages there is no
    // for our PCD to know it's not talking to a bank card, or that our PICC is not being
    // read by a contactless card reader. As such we use this magic. If the PICC receives
    // a message starting with this, it can assume that the PCD is running the radiation
    // sensor application. And if the PCD sends a message starting with this and receives
    // a reply also starting with this magic, then it can assume the PICC is a radiation
    // sensor. There is an obvious issue if it turns out that another application also
    // uses messages that start with this same magic, but I consider that unlikely.

    // THE MAGIC MUST BE CHANGED FOR OTHER APPLICATIONS.
    // My suggestions is that the 3 MSBs stay at 24'hF100BA for FIUBA based projects
    // and the LSB is changed for each application / use. However any scheme works.
    localparam logic [31:0] PROTOCOL_MAGIC      = 32'hF100BA00;

    // Change PROTOCOL_VERSION if anything about the protocol changes
    // (new messages, format change, arguments change, ...)
    // We expect that the PCD can send a IDENTIFY command to any PICC no matter the
    // protocol version. The PCD should be able to interpret the response to detect
    // the protocol version for other messages. If this is no longer the case then
    // those changes are beyond the scope of a protocol version change and require
    // a PROTOCOL_MAGIC change.
    localparam logic [7:0]  PROTOCOL_VERSION    = 8'd1;

    // An enum of commands
    typedef enum logic [7:0]
    {
        Command_IDENTIFY    = 8'h00,
        Command_SET_SIGNAL  = 8'h01,
        Command_AUTO_READ   = 8'h02,
        Command_GET_RESULT  = 8'h03,
        Command_ABORT       = 8'h04
    } Command;

    // An 8 bit struct used by the SET_SIGNAL message
    typedef struct packed
    {
        logic [2:0] sens_config;    // MSb
        logic       sens_enable;
        logic       sens_read;
        logic       adc_enable;
        logic       adc_read;
        logic       padding;        // LSb
    } Signals;

    // An 8 bit struct used by replies
    typedef struct packed
    {
        // The adc_conversion_complete signal was seen to have asserted, and the
        // adc_value was cached. This means the reply to GET_RESULT will contain valid data.
        logic       conv_complete;

        // On any of the below error flags being set the entire sensor read should be
        // abandoned, all PICCs should be reset to a known state without error replies, and
        // the sensor read should be started again.

        // The current command interrupted a SET_SIGNAL
        // or AUTO_READ command that was not yet complete. This means that
        // any timing for the SET_SIGNAL / AUTO_READ command can not be relied upon.
        // If this command is another SET_SIGNAL / AUTO_READ it will not be started.
        logic       already_busy;

        // During the sync period pauses are used to synchronise multiple PICCs so that readings
        // can all occur simultaneously. However during timing1 / timing2 (AUTO_READ only),
        // or while waiting for the ADC read to complete (SET_SIGNAL / AUTO_READ), we don't expect
        // any pauses. Pauses during this period affect timing since the clock stops, and affects
        // our voltage rails since there is no power transferred during a pause. Both of which <could>
        // affect the accuracy of the results, and so we want to detect such pauses and alert the user.
        logic       unexpected_pause;

        // An error for the current command has been detected:
        //  Invalid start state for an AUTO_READ command.
        //  Invalid command / rx length
        logic       error;

        // currently unused flags
        logic [3:0] padding;
    } StatusFlags;

    // Arguments for the Command_SET_SIGNAL request (PCD -> PICC) message
    typedef struct packed
    {
        logic [15:0]    sync;       // 2 bytes
        Signals         mask;       // 1 byte
        Signals         value;      // 1 byte
    } SetSignalRequestArgs;         // total: 4 bytes

    // Arugments for the Command_AUTO_READ request (PCD -> PICC) message
    typedef struct packed
    {
        logic [15:0]    sync;       // 2 bytes
        logic [31:0]    timing1;    // 4 bytes (only use 25 bits)
        logic [31:0]    timing2;    // 4 bytes (only use 25 bits)
    } AutoReadRequestArgs;          // total: 10 bytes

    // Arguments for the Command_IDENTIFY reply (PICC -> PCD) message
    typedef struct packed
    {
        logic [7:0]     protocol_version;       // 1 byte - should be first
        logic [7:0]     adapter_version;        // 1 byte
        logic [7:0]     iso_iec_14443a_version; // 1 byte - top 4 bits digital, bottom 4 bits AFE version
        logic [7:0]     sensor_adc_version;     // 1 byte - top 4 bits sensor, bottom 4 bits ADC
    } IdentifyReplyArgs;                        // total: 4 bytes

    // Arguments for the reply to the GET_RESULT command
    typedef struct packed
    {
        StatusFlags     flags;                  // 1 byte
        logic [15:0]    adc_value;              // 2 bytes - current value from the ADC, not necesarrily valid at this time
    } GetResultReplyArgs;                       // total: 3 bytes

    // Arguments for the reply to any other message (including invalid ones)
    typedef struct packed
    {
        StatusFlags     flags;                  // 1 byte
    } StatusReplyArgs;                          // total: 1 byte

    typedef struct packed
    {
        logic [31:0]    magic;      // 4 bytes
        logic [7:0]     cmd;        // 1 byte
    } Message;                      // total: 5 bytes

    // every Rx message contains magic + cmd (5 bytes), a variable amount of args.
    // and a 2 byte CRC.
    localparam logic [4:0] COMMAND_IDENTIFY_REQUEST_LEN     = 5'd7;
    localparam logic [4:0] COMMAND_SET_SIGNAL_REQUEST_LEN   = 5'd11;
    localparam logic [4:0] COMMAND_AUTO_READ_REQUEST_LEN    = 5'd17;
    localparam logic [4:0] COMMAND_GET_RESULT_REQUEST_LEN   = 5'd7;
    localparam logic [4:0] COMMAND_ABORT_REQUEST_LEN        = 5'd7;

    // 15 bytes (5 bytes for Message, 10 bytes for AutoReadRequestArgs)
    // we don't care about the CRC as it's checked in the ISO/IEC 14443-3A layer,
    // so it gets dropped if it doesn't fit.
    // NOTE: The ISO/IEC 14443A IP core sends only the minimum length ATS reply to
    //       RATS. This has a default max PICC buffer length of 32 bytes.
    //       If the PCD wants to send messages longer than 32 bytes it will use
    //       chaining which is currently not supported. This is fine for us as ATM
    //       the max sized message from the PCD is (PCB + CID + INF + CRC) = 19 bytes.
    //       If the max INF field is increased such that PCD messages could be longer
    //       than 32 bytes, then to stay compliant we must change the ATS to specify a
    //       larger FSCI.
    localparam int RX_BUFF_LEN = 15;

    // Tx message lengths include the magic and command (5 bytes) but not the CRC, which is
    // auto-inserted in the ISO/IEC 14443A IP core.
    localparam logic [3:0] COMMAND_IDENTIFY_REPLY_LEN       = 4'd9;
    localparam logic [3:0] COMMAND_GET_RESULT_REPLY_LEN     = 4'd8;
    localparam logic [3:0] COMMAND_OTHERS_REPLY_LEN         = 4'd6;

    // longest reply is the Command_IDENTIFY, of 10 bytes, so that's what we use here.
    // IMPORTANT NOTE: The ISO/IEC 14443A IP core currently ignores the FSDI field of RATS
    //                 which states the size of the PCD's buffer. The minimum size is 16 bytes.
    //                 Since we ignore that field we MUST make sure all replies are at most
    //                 16 bytes. This includes the ISO/IEC 14443-4 header and CRC. Currently
    //                 that's 4 bytes max since the IP core doesn't support the NAD field.
    //                 That means the largest reply we can send is 12 bytes. If we need
    //                 to send larger replies then either:
    //                      1) they should be split into multiple request / replies.
    //                      2) Modify the IP core to support chaining
    //                      3) Modify the IP core to pass the FSDI field onto the app (us)
    //                         and respond with an error if the FSD is less than necessary
    localparam int TX_BUFF_LEN = 10;

    function automatic logic [3:0] get_reply_len (Command cmd);
        case (cmd)
            Command_IDENTIFY:   return COMMAND_IDENTIFY_REPLY_LEN;
            Command_GET_RESULT: return COMMAND_GET_RESULT_REPLY_LEN;
            default:            return COMMAND_OTHERS_REPLY_LEN;
        endcase
    endfunction

endpackage
