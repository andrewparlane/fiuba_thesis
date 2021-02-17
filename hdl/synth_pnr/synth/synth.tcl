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
set ROOT_DIR                "../../.."
set ISO_IEC_14443A_RTL_DIR  "$ROOT_DIR/hdl/components/iso_iec_14443A/rtl"
set SRC_DIR                 "$ROOT_DIR/hdl/rtl"

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

puts "[colour $COLOUR_BLUE]Analysing source files[clear_colour]"
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

# See "Fixing Nets Connected to Multiple Ports" in the Design Compiler User Guide for more information.
# A feedthrough path is one where an output of a module is directly connected to an input.
# Multiple Output Ports describes when two outputs of the same module are logically identical.
# These two types of signals are represented in the netlist using an assign statement which some
# tools can have problems with. This option enables rewiring the connections in the heirarchy
# for example connecting a feedthrough path outside of the module.0
set_app_var compile_advanced_fix_multiple_port_nets              "true"
set_fix_multiple_port_nets -all -buffer_constants

# From the Design Compiler Synthesis Variables and Attributes doc:
#   Controls whether High Level synthesis should use additional algorithms to pursuit better area
#   through increased resource sharing.
# But also:
#   Variable is deprecated and feature will be obsolete in future releases due to added complexity
#   for formal verification.
# I'm enabling this because it is not yet deprecated and we are interested in optimising the area
set_app_var compile_enhanced_resource_sharing                    "true"

# Attempt to fix all DRC (Design Rule Checking) errors
set_app_var compile_final_drc_fix                                "all"

# From the Design Compiler Synthesis Variables and Attributes doc:
#   Controls whether a warning message is issued for latches inferred by incomplete combinational assignments.
# I don't expect there to be any latches in my design, so if there are I'd like to know about it
set_app_var hdlin_check_no_latch                                 "true"

# Set the preferred routing directions
# 0.18um-ApplicationNote-Digital_Implementation_Guidelines-v1_1_0.pdf section 7.1 states
# that for a 6 metal layer process MET5 is horizontal and MET6 is vertical.
# Alternating each layer, we can infer that MET1, MET3, MET5 are horizontal and
# MET2, MET4, MET6 are vertical. MET5 is known as METTP and MET6 is known as METTPL
set_preferred_routing_direction -layers "MET1 MET3 METTP" -direction horizontal
set_preferred_routing_direction -layers "MET2 MET4 METTPL" -direction vertical
colourise_cmd report_preferred_routing_direction

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

# =============================================================================
# Uniquify
# =============================================================================

puts "[colour $COLOUR_BLUE]Uniquifying design[clear_colour]"

# Uniquify duplicates modules that have been instantiated more than once
# thus allowing the tools to optimise each separately. AFAICT this is done automatically in
# compile_ultra, so we can maybe remove this.
uniquify

if {($pause_between_commands == 1) && ([do_continue] == 0)} {
    return
}

# =============================================================================
# Constraints
# =============================================================================

puts "[colour $COLOUR_BLUE]Setting design constraints[clear_colour]"
puts "[colour $COLOUR_YELLOW]Warning: Revisit these constraints when we have the analogue parts of the design (14443, sensor, ADC).[clear_colour]"

# redirect all of this into $buffer, so we can colourise it
redirect -variable buffer {
    # Only needed if we use compile instead of compile_ultra
    # Request that the tools optimise for the smallest possible area that meets timing
    set_max_area 0

    # ---------------------------
    # Clock
    # ---------------------------

    # Create our clock (13.56MHz), currently assuming a 50% duty cycle
    # But the analogue block could potentially distort that?
    set clk_freq_hz     13560000.0
    set clk_period_ns   [expr 1000000000.0 / $clk_freq_hz]
    create_clock -name clk -period $clk_period_ns [get_ports clk]

    # set the rise and fall times of the clock, can also set the min time with -min
    # we need to have models of the analogue block before it makes sense to set these
    # set_clock_transition <transition_time_ns> -rise [get_clocks clk]
    # set_clock_transition <transition_time_ns> -fall [get_clocks clk]

    # 0.18um-ApplicationNote-Digital_Implementation_Guidelines-v1_1_0.pdf says
    # use 10% or higher for setup clock uncertainty. I'm using 20%
    set_clock_uncertainty -setup [expr $clk_period_ns * 0.20] [get_clocks clk]

    # The same document says to use the aprox delay of an INHDX1 in typical operating conditions
    # for the hold uncertainty. I'm not entirely sure how to get that value.
    # D_CELLS_HD_LPMOS_typ_1_80V_25C.lib has timing values for that cell, but it has 49 values depending on
    # input transition and output load, not sure which to use.
    # Using 500ps for now, on the suggestion of Octavio.
    set_clock_uncertainty -hold 0.5 [get_clocks clk]

    # ---------------------------
    # I/O
    # ---------------------------

    # We have a few async inputs that we pass through synchronisers
    # So we need to cut those paths
    # I'm cutting paths using -to / -through, so that if the input is accidentally used
    # instead of the output of the synchroniser, there'll be a warning.
    # pause_n_async goes through a reset synchroniser instead of a normal synchroniser
    # this is because the clock will stop during pauses, and it's unclear if we'll ever
    # see the signal low on a clock edge.
    set_false_path -to reset_synchroniser/rst_n_in
    set_false_path -to pause_n_synchroniser/rst_n_in
    set_false_path -through [get_pins power_synch_inst/d*]

    # uid_variable is a constant set using wire bonding
    set_false_path -from [get_ports uid_variable]

    # The lm_out output goes to the load modulator analogue circuit.
    # I think this is async, but it's possible that the ISO/IEC standard requires it to be driven in
    # phase with the carrier signal. Additionally it can't take "forever" for this signal to reach the
    # load_modulator, the FDT timing of the spec limits how long this can take. As such I'm constraining
    # it to take at most 1/2 a clock cycle to get out of my block. We should refine this later when we
    # have more information about the analogue part of the design.
    set_output_delay [expr $clk_period_ns/2.0] -clock [get_clocks clk] [get_ports lm_out]

    # TODO: Are the sensor and ADC signal asynch or synch? How to constrain them when we don't have
    #       the designs yet (or at least we don't have the ADC design)
    # Using the example from 0.18um-ApplicationNote-Digital_Implementation_Guidelines-v1_1_0.pdf for now
    set_output_delay [expr $clk_period_ns/2.0] -clock [get_clocks clk] [get_ports sens_*]
    set_output_delay [expr $clk_period_ns/2.0] -clock [get_clocks clk] [get_ports adc_enable]
    set_output_delay [expr $clk_period_ns/2.0] -clock [get_clocks clk] [get_ports adc_read]
    set_input_delay [expr $clk_period_ns/2.0] -clock [get_clocks clk] [get_ports adc_value*]
    set_input_delay [expr $clk_period_ns/2.0] -clock [get_clocks clk] [get_ports adc_conversion_complete]

    # environment of the IO signals from 0.18um-ApplicationNote-Digital_Implementation_Guidelines-v1_1_0.pdf:
    # assuming a weak driver from outside and a reasonable load (0.4 pf is approx.. 2 mm of wiring in 180nm).
    # TODO: We should revisit this when we know what's on the other end
    set_driving_cell -lib_cell INHDX1 [all_inputs]
    set_load 0.4 [all_outputs]
}

# Colourise the output
puts [colourise $buffer]

# =============================================================================
# Flatten design
# =============================================================================

# This fixes some of the warnings in the report_constraint -verbose below since the
# multiport_nets are flattened and dealt with via the set_fix_multiple_port_nets command above
ungroup -flatten -all -all_instances

# =============================================================================
# Check constraints
# =============================================================================

colourise_cmd "check_timing"
colourise_cmd "report_constraint -verbose"

report_constraint -verbose -all_violators > logs/constraint_violations.log

if {($pause_between_commands == 1) && ([do_continue] == 0)} {
    return
}

# =============================================================================
# Operating conditions
# =============================================================================

# Enable dynamic power optimisations
set_dynamic_optimization true

# Use best case / worst case analysis with the correct operating conditions
set_operating_conditions -analysis_type bc_wc -max $OPERATING_CONDITION_MAX -min $OPERATING_CONDITION_MIN

# =============================================================================
# Compile design
# =============================================================================

puts "[colour $COLOUR_BLUE]Compiling design[clear_colour]"

# My colourise_cmd proc buffers the output and then outputs all of it at once
# Meaning we don't get any output until compile_ultra finishes. It would be nice to
# output data as we get it, but I can't figure out how to do that. I looked at creating
# a new write channel and redirecting to that, but dc_shell crashes with redirect.
# I think it's because it tries to redirect everything away from stdout, and so the puts
# in the custom channel gets redirected to the custom channel and we get infinite recursion.
puts "[colour $COLOUR_BLUE]This may take awhile with no output[clear_colour]"

# TODO: compile or compile_ultra?
if {[colourise_cmd "compile_ultra"] == 0} {
    puts "[colour $COLOUR_RED]Aborting due to error checking design[clear_colour]"
    return
}

if {($pause_between_commands == 1) && ([do_continue] == 0)} {
    return
}

# =============================================================================
# Clock Gating
# =============================================================================

# Initial results at this point:
# Without clock gating:
#   Power
#       Internal:   0.5049 mW
#       Switching:  8.6456 uW
#       Leakage:    407.25e nW
#       Total:      0.5140 mW
#   Area
#       Total cell area:    56101.515282 - this seems rather large?
# With compile_ultra -incremental -gate_clock
#   Power
#       Internal:   0.1756 mW
#       Switching:  21.326 uW
#       Leakage:    384.87 nW
#       Total:      0.1973 mW
#   Area
#       Total cell area:    52699.991055 - huh, that's actuall smaller
# With compile_ultra -incremental -gate_clock -self_gating
#   Less total power but higher leakage and larger area
#   Power
#       Internal:   0.1161 mW
#       Switching:  22.761 uW
#       Leakage:    418.33 nW
#       Total:      0.1393 mw
#   Area
#       Total cell area:    55390.833464

# There's probably other arguments to look at too, such as: set_clock_gating_style
# -minimum_bitwidth and -control_point arguments, maybe others
# for now just use the defaults.

puts "[colour $COLOUR_BLUE]Inserting Clock Gating[clear_colour]"

colourise_cmd "compile_ultra -incremental -gate_clock"

if {($pause_between_commands == 1) && ([do_continue] == 0)} {
    return
}

# =============================================================================
# Parasitics extraction
# =============================================================================

puts "[colour $COLOUR_BLUE]Extracting RC estimates[clear_colour]"

# Estimates the RC values for nets, so that report_timing will be more accurate
colourise_cmd "extract_rc -estimate"

if {($pause_between_commands == 1) && ([do_continue] == 0)} {
    return
}

# =============================================================================
# Optimise registers
# =============================================================================

puts "[colour $COLOUR_BLUE]Optimising registers[clear_colour]"

colourise_cmd "optimize_registers -justification_effort high"

# Not entirely sure if this is necessary
colourise_cmd "compile_ultra -incremental -gate_clock"

if {($pause_between_commands == 1) && ([do_continue] == 0)} {
    return
}

# =============================================================================
# Reports
# =============================================================================

puts "[colour $COLOUR_BLUE]Generating reports[clear_colour]"

# Actually output this so we can see if timing has failed
colourise_cmd report_timing

if {($pause_between_commands == 1) && ([do_continue] == 0)} {
    return
}

report_timing -nosplit -delay_type max -max_paths 10 > logs/timing.log
report_area -nosplit > logs/area.log
report_clock_gating > logs/clock_gating.log
report_clock_tree -nosplit > logs/clock_tree.log
report_design -nosplit > logs/design.log
report_power -nosplit -verbose -analysis_effort high > logs/power.log
report_qor > logs/qor.log

# =============================================================================
# Write out files
# =============================================================================

puts "[colour $COLOUR_BLUE]Writing output files[clear_colour]"

# netlist
colourise_cmd "write -hierarchy -format ddc -output \"work/final_netlist.ddc\""
colourise_cmd "write -hierarchy -format verilog -output \"work/final_netlist.v\""

# milkyway
write_milkyway -overwrite -output post_synth

# SDC
write_sdc work/constraints.sdc

# Output a summary of message types
redirect -variable message_info { print_message_info }
puts "[colour $COLOUR_BLUE]$message_info[clear_colour]"

puts "[colour $COLOUR_GREEN]Script finished successfully[clear_colour]"
