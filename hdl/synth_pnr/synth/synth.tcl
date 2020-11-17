# ----------------------------------------------------------------------------------
#        File: synth.tcl
# Description: TCL script to perform synthesis using Synopsys DC compiler
#      Author: Andrew Parlane
# ----------------------------------------------------------------------------------

# This file is part of https://github.com/andrewparlane/fiuba_thesis
# Copyright (c) 2020 Andrew Parlane.
#
# This is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free
# Software Foundation, version 3.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this code. If not, see <http://www.gnu.org/licenses/>.

# =============================================================================
# scripts
# =============================================================================

# colourisation
source ../common/colourisation.tcl

# debug
source ../common/debug.tcl

# libs
source ../common/libraries.tcl

# =============================================================================
# RTL source files
# =============================================================================
set ROOT_DIR		        "../../.."
set ISO_IEC_14443A_RTL_DIR	"$ROOT_DIR/hdl/components/iso_iec_14443a/rtl"
set SRC_DIR					"$ROOT_DIR/hdl/rtl"

# Files - make sure the packages are before the modules that use them
set SRC_FILES {}
append SRC_FILES    [glob -directory $ISO_IEC_14443A_RTL_DIR/pkg            -type {f r} *\.sv] " "
append SRC_FILES    [glob -directory $ISO_IEC_14443A_RTL_DIR/interfaces     -type {f r} *\.sv] " "
append SRC_FILES    [glob -directory $ISO_IEC_14443A_RTL_DIR/iso14443_2a    -type {f r} *\.sv] " "
append SRC_FILES    [glob -directory $ISO_IEC_14443A_RTL_DIR/iso14443_3a    -type {f r} *\.sv] " "
append SRC_FILES    [glob -directory $ISO_IEC_14443A_RTL_DIR/iso14443_4a    -type {f r} *\.sv] " "
append SRC_FILES    [glob -directory $ISO_IEC_14443A_RTL_DIR                -type {f r} *\.sv] " "
append SRC_FILES    [glob -directory $SRC_DIR/pkg                           -type {f r} *\.sv] " "
append SRC_FILES    [glob -directory $SRC_DIR                               -type {f r} *\.sv] " "

puts "[colour $COLOUR_BLUE]Found sources:[clear_colour]"

foreach fileName $SRC_FILES {
    puts "  $fileName"
}

puts ""
puts ""

if {($pause_between_commands == 1) && ([do_continue] == 0)} {
    return
}

# =============================================================================
# Set up libraries
# =============================================================================
puts "[colour $COLOUR_BLUE]Setting up libraries[clear_colour]"
puts "[colour $COLOUR_YELLOW]WARNING: Confirm all these are correct.[clear_colour]"

# Max libs
set_app_var target_library  "$TARGET_MAX_LIBS"

# Iterate through each of the MAX libs and set the corresponding min lib
set lib_idx 0
foreach max_lib ${TARGET_MAX_LIBS} {
   set min_lib [lindex ${TARGET_MIN_LIBS} ${lib_idx}]
   set_min_library   ${max_lib} -min_version ${min_lib}
   set lib_idx [expr ${lib_idx} + 1]
}

set_app_var synthetic_library   "$SYNTHETIC_LIBRARY"
set_app_var symbol_library      "$SYMBOL_LIBRARY"
set_app_var link_library        "$LINK_LIBRARY"

# Create (and open) our milkyway lib
set mw_design_lib "work/mw_lib"
if {[file isdirectory $mw_design_lib]} {
    # delete the old one first
    exec rm -rf $mw_design_lib
}
colourise_cmd "create_mw_lib -open -technology $MW_TECHFILE -mw_reference_library \"$MILKYWAY_REF_LIB\" $mw_design_lib"

# Add the TLU+ files
set_tlu_plus_files -max_tluplus $TLUP_MAX -min_tluplus $TLUP_MIN -tech2itf_map  $TLUP_MAP
check_tlu_plus_files

# Set up our WORK lib
define_design_lib WORK -path "work"

if {[expr [colourise_cmd "check_library"] == 0]} {
    # failed, abort
    puts "[colour $COLOUR_RED]Aborting due to error checking library setup[clear_colour]"
    return
}

puts ""
puts ""

if {($pause_between_commands == 1) && ([do_continue] == 0)} {
    return
}

# =============================================================================
# Analyze source files
# =============================================================================

puts "[colour $COLOUR_BLUE]Setting up libraries[clear_colour]"
foreach file_name $SRC_FILES {
    puts "[colour $COLOUR_BLUE]Analysing $file_name[clear_colour]"
    if {[expr [colourise_cmd "analyze -library WORK -format sverilog $file_name"] == 0]} {
        # failed, abort
        puts "[colour $COLOUR_RED]Aborting due to error analysing $fileName[clear_colour]"
        return
    }
}

if {($pause_between_commands == 1) && ([do_continue] == 0)} {
    return
}

# =============================================================================
# Elaborate design
# =============================================================================

puts "[colour $COLOUR_BLUE]Elaborating design[clear_colour]"

set elab_args ""
# these parameters are necessary to synthesise the design
# however their values depend on the analogue parts (AFE, ADC and the sensor)
# don't check the uncommented version of this in until we have the final values
#set FDT_TIMING_ADJUST   0
#set SENSOR_VERSION      1
#set ADC_VERSION         1
#set elab_args "-param FDT_TIMING_ADJUST=>$FDT_TIMING_ADJUST,SENSOR_VERSION=>$SENSOR_VERSION,ADC_VERSION=>$ADC_VERSION"

if {[expr [colourise_cmd "elaborate radiation_sensor_digital_top -work WORK $elab_args"] == 0]} {
    puts "[colour $COLOUR_RED]Aborting due to error elaborating design[clear_colour]"
    return
}

if {($pause_between_commands == 1) && ([do_continue] == 0)} {
    return
}

# =============================================================================
# Set synthesis variables
# =============================================================================
puts "[colour $COLOUR_YELLOW]Warning: TODO: set synthesis variables[clear_colour]"
#set_app_var compile_advanced_fix_multiple_port_nets              "true"
#set_app_var compile_delete_unloaded_sequential_cells             "true"
#set_app_var compile_enable_register_merging                      "true"
#set_app_var compile_enable_register_merging_with_exceptions      "true"
#set_app_var compile_enhanced_resource_sharing                    "true"
#set_app_var compile_final_drc_fix                                "all"
#set_app_var compile_register_replication                         "true"
#set_app_var compile_register_replication_across_hierarchy        "true"
#set_app_var compile_register_replication_do_size_only            "true"
#set_app_var compile_seqmap_propagate_constants                   "true"
#set_app_var compile_seqmap_propagate_constants_size_only         "true"
#set_app_var hdlin_check_no_latch                                 "true"
#set_app_var hdlin_ff_always_async_set_reset                      "true"
#set_app_var verilogout_no_tri                                    "true"
#set_app_var verilogout_equation                                  "false"
#set_fix_multiple_port_nets -all -buffer_constants

# =============================================================================
# Linking design
# =============================================================================

puts "[colour $COLOUR_BLUE]Linking design[clear_colour]"

if {[expr [colourise_cmd "link"] == 0]} {
    puts "[colour $COLOUR_RED]Aborting due to error linking design[clear_colour]"
    return
}

if {($pause_between_commands == 1) && ([do_continue] == 0)} {
    return
}

# =============================================================================
# Checking design
# =============================================================================

puts "[colour $COLOUR_BLUE]Checking design[clear_colour]"

if {[expr [colourise_cmd "check_design -summary"] == 0]} {
    puts "[colour $COLOUR_RED]Aborting due to error checking design[clear_colour]"
    return
}

# Save the full check_design output (not just the sumarry)
check_design > logs/check_design.log

if {($pause_between_commands == 1) && ([do_continue] == 0)} {
    return
}

puts "[colour $COLOUR_GREEN]Script finished successfully[clear_colour]"
