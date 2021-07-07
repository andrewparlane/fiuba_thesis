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
# Helpers
# =============================================================================

proc set_and_report_false_path {arg} {
    # set the false path
    set set_cmd "set_false_path $arg"
    eval $set_cmd

    set get_cmd "get_timing_paths -max_paths 10 $arg"
    set paths [eval $get_cmd]

    # report which paths were set, reporting max of 10
    puts "running $set_cmd"
    puts "Affected paths (reporting max of 10):"
    foreach_in_collection path $paths {
       set startpoint   [get_attribute [get_attribute $path startpoint] full_name]
       set endpoint     [get_attribute [get_attribute $path endpoint]   full_name]
       puts [format "  from: %-20s to: %-20s" $startpoint $endpoint]
    }
}

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

# =============================================================================
# Set up libraries
# =============================================================================
puts "[colour $COLOUR_BLUE]Setting up libraries[clear_colour]"

if {($pause_between_commands == 1) && ([do_continue] == 0)} {
    return
}

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

# =============================================================================
# Analyze source files
# =============================================================================

puts "[colour $COLOUR_BLUE]Analysing source files[clear_colour]"

if {($pause_between_commands == 1) && ([do_continue] == 0)} {
    return
}

# Initialise the name mapping database for SAIF files
# This has to be done before reading the source files
saif_map -start

foreach file_name $SRC_FILES {
    puts "[colour $COLOUR_BLUE]Analysing $file_name[clear_colour]"
    if {[expr [colourise_cmd "analyze -library WORK -format sverilog $file_name"] == 0]} {
        # failed, abort
        puts "[colour $COLOUR_RED]Aborting due to error analysing $fileName[clear_colour]"
        return
    }
}

# =============================================================================
# Elaborate design
# =============================================================================

puts "[colour $COLOUR_BLUE]Elaborating design[clear_colour]"

if {($pause_between_commands == 1) && ([do_continue] == 0)} {
    return
}

# We get a lot of VER-735 infos, so limit it to just 5. This makes it easier to read the log
# VER-735 (information) %s Variables crossing hierarchy: %s%s%s
# From what I understand this is when I instantiate an interface without using a modport
# AKA not as the port to a module. Therefore it doesn't know what direction each signal
# is defined as. This should be fine.
set_message_info -id VER-735 -limit 5

if {[expr [colourise_cmd "elaborate radiation_sensor_digital_top -work WORK"] == 0]} {
    puts "[colour $COLOUR_RED]Aborting due to error elaborating design[clear_colour]"
    return
}

# =============================================================================
# Set synthesis variables
# =============================================================================

puts "[colour $COLOUR_BLUE]Setting synthesis variables[clear_colour]"

if {($pause_between_commands == 1) && ([do_continue] == 0)} {
    return
}

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

# =============================================================================
# Checking design
# =============================================================================

puts "[colour $COLOUR_BLUE]Checking design[clear_colour]"

if {($pause_between_commands == 1) && ([do_continue] == 0)} {
    return
}

if {[expr [colourise_cmd "check_design -summary"] == 0]} {
    puts "[colour $COLOUR_RED]Aborting due to error checking design[clear_colour]"
    return
}

# Save the full check_design output (not just the sumarry)
check_design > logs/check_design.log

# =============================================================================
# Uniquify
# =============================================================================

puts "[colour $COLOUR_BLUE]Uniquifying design[clear_colour]"

if {($pause_between_commands == 1) && ([do_continue] == 0)} {
    return
}

# Uniquify duplicates modules that have been instantiated more than once
# thus allowing the tools to optimise each separately. AFAICT this is done automatically in
# compile_ultra, so we can maybe remove this.
uniquify

# =============================================================================
# Constraints
# =============================================================================

puts "[colour $COLOUR_BLUE]Setting design constraints[clear_colour]"
puts "[colour $COLOUR_YELLOW]Warning: Revisit these constraints when we have the analogue parts of the design (14443, sensor, ADC).[clear_colour]"

if {($pause_between_commands == 1) && ([do_continue] == 0)} {
    return
}

# redirect all of this into $buffer, so we can colourise it
redirect -variable buffer {
    # Only needed if we use compile instead of compile_ultra
    # Request that the tools optimise for the smallest possible area that meets timing
    set_max_area 0

    # ---------------------------
    # Ports
    # ---------------------------

    # ISO 14443A Analogue block (AFE)
    #   clk                         - input clock, 13.56MHz +/- 7KHz
    #   rst_n_async                 - input asynchronous reset
    #
    #   power[1:0]                  - input synchronous
    #
    #   pause_n_async               - input asynchronous (from envelope detector)
    #
    #   lm_out                      - output asynchronous (to load modulator)
    #
    #   afe_version                 - input must be constant, set to the version of the AFE
    #
    # Chip configuration
    #   uid_variable[2:0]           - constant at least while this design is out of reset
    #
    # Sensor
    #   sens_version                - input must be constant, set to the version of the sensor
    #   sens_config[2:0]            - output asynchronous
    #   sens_enable                 - output asynchronous
    #   sens_read                   - output asynchronous
    #
    # ADC
    #   adc_version                 - input must be constant, set to the version of the ADC
    #   adc_enable                  - output synchronous
    #   adc_read                    - output synchronous
    #   adc_conversion_complete     - input synchronous
    #   adc_value[15:0]             - input synchronous

    # ---------------------------
    # Clock
    # ---------------------------

    # Create our clock (13.56MHz), currently assuming a 50% duty cycle
    # But the analogue block could potentially distort that?
    set clk_freq_hz     13560000.0
    set clk_period_ns   [expr 1000000000.0 / $clk_freq_hz]
    create_clock -name clk -period $clk_period_ns [get_ports clk]

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

    # Constants, some of our input signals are constants, they should never change.
    # at least while this block is out of reset.
    set_and_report_false_path {-from [get_ports afe_version]}
    set_and_report_false_path {-from [get_ports adc_version]}
    set_and_report_false_path {-from [get_ports sens_version]}
    set_and_report_false_path {-from [get_ports uid_variable]}
    set_switching_activity -static_probability 0.5 -toggle_rate 0 [get_ports afe_version]
    set_switching_activity -static_probability 0.5 -toggle_rate 0 [get_ports adc_version]
    set_switching_activity -static_probability 0.5 -toggle_rate 0 [get_ports sens_version]
    set_switching_activity -static_probability 0.5 -toggle_rate 0 [get_ports uid_variable]

    # We cut async inputs and outputs.
    set_and_report_false_path {-from [get_ports rst_n_async]}
    set_and_report_false_path {-to [get_ports sens_config]}
    set_and_report_false_path {-to [get_ports sens_enable]}
    set_and_report_false_path {-to [get_ports sens_read]}

    # The FDT timings require a fixed number of cycles from the end of the PCD's pause
    # to the start of the reply. There's a margin of error of +400ns. I compensate for full cycles
    # of delay inside my block. That 500ns has to be split into:
    #   pcd_pause_n deasserting -> pause_n_async deasserting        - max 300ns
    #   pause_n_async internal input delay                          - max 5ns
    #   pause_n_latch_and_synchroniser max delay - min delay        - 1 tick at min frequency = 73.78ns
    #   lm_out internal output delay                                - max 5ns
    #   clock latency / uncertainty                                 - remainder ~12ns
    # To enforce the internal input and output delays of pause_n_async and lm_out
    # We use the set_max_delay constraint. Ignoring clock latency, so we can specify the absolute
    # delay as 5ns each.
    set_max_delay 5.0 -from [get_ports pause_n_async] -ignore_clock_latency
    set_max_delay 5.0 -to [get_ports lm_out] -ignore_clock_latency

    # The ADC inputs/outputs and the AFE's power output are synchronous.
    # TODO: Constrain these correctly
    # we want mins and maxes for the input/output delays, and we should take clock latency into account
    # the ADC may be source synchronous
    set_input_delay [expr $clk_period_ns/2.0] -clock [get_clocks clk] [get_ports power]
    set_output_delay [expr $clk_period_ns/2.0] -clock [get_clocks clk] [get_ports adc_enable]
    set_output_delay [expr $clk_period_ns/2.0] -clock [get_clocks clk] [get_ports adc_read]
    set_input_delay [expr $clk_period_ns/2.0] -clock [get_clocks clk] [get_ports adc_value]
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

report_timing_requirements
report_timing_requirements -nosplit > logs/timing_requirements.log
colourise_cmd "check_timing"
# This is the same as report_constraint -verbose, but without the min path delay (hold analysis)
# Hold analysis doesn't make sense to do during synthesis
colourise_cmd "report_constraint -verbose -max_delay -max_transition -max_fanout -max_capacitance -max_area"
report_constraint -verbose -max_delay -max_transition -max_fanout -max_capacitance -max_area -all_violators > logs/constraint_violations.log

# =============================================================================
# Operating conditions
# =============================================================================

puts "[colour $COLOUR_BLUE]Setting up Operating conditions[clear_colour]"

if {($pause_between_commands == 1) && ([do_continue] == 0)} {
    return
}

# Enable dynamic power optimisations
set_dynamic_optimization true

# Use best case / worst case analysis with the correct operating conditions
set_operating_conditions -analysis_type bc_wc -max $OPERATING_CONDITION_MAX -min $OPERATING_CONDITION_MIN

# =============================================================================
# Read SAIF
# =============================================================================

puts "[colour $COLOUR_BLUE]Reading .saif[clear_colour]"

if {($pause_between_commands == 1) && ([do_continue] == 0)} {
    return
}

# PWR-12:   Warning: The derived static probability value (0.500000) for the clock net 'clk'
#           conflicts with the annotated value (0.555463). Using the annotated value.
#               This is expected, since the clock stops during pauses, and so the .saif shows it
#               at one value more than at the other. With the configuration of the AFE model in
#               my simulation, this turns out that the clock pauses while high.
suppress_message PWR-12

read_saif -input radiation_sensor_digital_top.saif -auto_map_names -instance_name generate_top_saif_tb/dut -verbose
report_saif -missing -rtl_saif -hier
report_saif -missing -rtl_saif -hier > logs/report_saif.log

# =============================================================================
# Compile design
# =============================================================================

puts "[colour $COLOUR_BLUE]Compiling design[clear_colour]"

if {($pause_between_commands == 1) && ([do_continue] == 0)} {
    return
}

# My colourise_cmd proc buffers the output and then outputs all of it at once
# Meaning we don't get any output until compile_ultra finishes. It would be nice to
# output data as we get it, but I can't figure out how to do that. I looked at creating
# a new write channel and redirecting to that, but dc_shell crashes with redirect.
# I think it's because it tries to redirect everything away from stdout, and so the puts
# in the custom channel gets redirected to the custom channel and we get infinite recursion.
puts "[colour $COLOUR_BLUE]This may take awhile with no output[clear_colour]"

if {[colourise_cmd "compile_ultra"] == 0} {
    puts "[colour $COLOUR_RED]Aborting due to error checking design[clear_colour]"
    return
}

# =============================================================================
# Clock Gating
# =============================================================================

puts "[colour $COLOUR_BLUE]Inserting Clock Gating[clear_colour]"

if {($pause_between_commands == 1) && ([do_continue] == 0)} {
    return
}

# Initial results at this point:
# Without clock gating:
#   Power
#       Internal:   0.4752 mW
#       Switching:  8.8977 uW
#       Leakage:    432.92 nW
#       Total:      0.4845 mW
#   Area
#       Total cell area:    57,166 um^2
# With compile_ultra -incremental -gate_clock
#   Power
#       Internal:   0.1976 mW
#       Switching:  27.535 uW
#       Leakage:    412.05 nW
#       Total:      0.2255 mW
#   Area
#       Total cell area:    54,539 um^2
# With compile_ultra -incremental -gate_clock -self_gating
#   Less total power but higher leakage and larger area
#   Power
#       Internal:   0.1463 mW
#       Switching:  28.321 uW
#       Leakage:    441.28 nW
#       Total:      0.1751 mw
#   Area
#       Total cell area:    57,082 um^2

colourise_cmd "compile_ultra -incremental -gate_clock"

# =============================================================================
# Parasitics extraction
# =============================================================================

puts "[colour $COLOUR_BLUE]Extracting RC estimates[clear_colour]"

if {($pause_between_commands == 1) && ([do_continue] == 0)} {
    return
}

# Estimates the RC values for nets, so that report_timing will be more accurate
colourise_cmd "extract_rc -estimate"

# =============================================================================
# Optimise registers
# =============================================================================

puts "[colour $COLOUR_BLUE]Optimising registers[clear_colour]"

if {($pause_between_commands == 1) && ([do_continue] == 0)} {
    return
}

colourise_cmd "optimize_registers -justification_effort high"

# Not entirely sure if this is necessary
colourise_cmd "compile_ultra -incremental -gate_clock"

# =============================================================================
# Reports
# =============================================================================

puts "[colour $COLOUR_BLUE]Generating reports[clear_colour]"

if {($pause_between_commands == 1) && ([do_continue] == 0)} {
    return
}

# Actually output this so we can see if timing has failed
colourise_cmd report_timing

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

if {($pause_between_commands == 1) && ([do_continue] == 0)} {
    return
}

# netlist
colourise_cmd "write -hierarchy -format ddc -output \"work/final_netlist.ddc\""
colourise_cmd "write -hierarchy -format verilog -output \"work/final_netlist.v\""

# milkyway
write_milkyway -overwrite -output post_synth

# SDC/constraints
write_sdc work/constraints.sdc
write_timing_contex -format icc2 -output work/constraints

# saif
write_saif -rtl -output work/out.saif
write_saif -rtl -propagated -output work/out_prop.saif

# Output a summary of message types
redirect -variable message_info { print_message_info }
puts "[colour $COLOUR_BLUE]$message_info[clear_colour]"

puts "[colour $COLOUR_GREEN]Script finished successfully[clear_colour]"
