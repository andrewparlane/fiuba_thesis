# ----------------------------------------------------------------------------------
#        File: pnr.tcl
# Description: TCL script to perform Place and Route using Synopsys IC compiler 2
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
# Vars
# =============================================================================
set lib_name                    "work/dlib"
set design_name                 design

# =============================================================================
# Helper functions
# =============================================================================

proc do_check_design {check} {
    set cmd "check_design -ems_database check_design.$check -checks $check"
    puts $cmd
    return [colourise_cmd $cmd]
}

proc create_new_block {new_name} {
    variable lib_name
    variable design_name

    # Create a new block
    save_block -force -label $new_name
    # close the old lib
    close_lib -purge -force -all
    # open the new block
    open_block $lib_name:$design_name/${new_name} -ref_libs_for_edit
}

# This can be used to continue where you left off
proc open_block_name {name} {
    variable lib_name
    variable design_name

    open_block $lib_name:$design_name/${name} -ref_libs_for_edit
}

# =============================================================================
# Design Init
# =============================================================================
puts "[colour $COLOUR_BLUE]Design Init[clear_colour]"

# Copy (open and save as) the lib from the DP stage
open_block ../dp/work/dlib:design/dp_out
save_lib -as work/dlib
close_lib -purge -force -all
open_block work/dlib:design/dp_out

# and create a new block
create_new_block "pnr_design_init"

# Make sure our power/gound nets are connected
connect_pg_net

# Check the power/ground DRC,
# ignore the std cells because we haven't placed them yet
if {[colourise_check_pg_drc -ignore_std_cells] == 0} {
    puts "[colour $COLOUR_RED]Aborting due to PG DRC errors[clear_colour]"
    return
}

# save the lib
save_lib -all

# =============================================================================
# Place OPT
# =============================================================================

create_new_block "pnr_place_opt"

puts ""
puts ""
puts "[colour $COLOUR_BLUE]Place OPT[clear_colour]"
puts ""

if {($pause_between_commands == 1) && ([do_continue] == 0)} {
    return
}

# Checks
# ---------------------------
# Note: there are some constraint issues we need to revisit here when we go back to look at
#       MCMM again
puts "[colour $COLOUR_YELLOW]Warning: TODO - make sure we fix the constraint issues below[clear_colour]"
do_check_design pre_placement_stage

# Note: There are two sets of warnings here:
#       1) "Warning: The spacing of layer 'X' is greater than the difference of the pitch
#          and width of the layer. (DCHK-105)" - I don't know what's going on with this yet.
#       2) "Warning: Track 'TRACK_X' on layer 'METX' does not cross core area. (DCHK-051)
#          This seems to only occur if we use a core_offset of 0 in the initialize_floorplan
#          command in DP. The tracks are routing tracks and so I think they can be ignored
colourise_cmd "check_physical_constraints"

# Setup options
# ---------------------------

# Make all scenarios active
set_scenario_status -active true [all_scenarios]

# try very hard to optimise area
set_app_options -name opt.area.effort -value ultra

# Optimise power
set_app_options -name cts.compile.power_opt_mode -value all

# We don't use a scanchain and therefore don't have a scandef
set_app_options -name place.coarse.continue_on_missing_scandef -value true

# Remove any ideal networks now
remove_ideal_network -all

# Placement
# ---------------------------
place_opt
refine_opt

connect_pg_net

# checks / reports
# ---------------------------

# At this point we've placed all the std_cells so we could do check_pg_drc
# without the -ignore_std_cells option.
# But we get DRC errors, which I'm not actually sure if they are valid or not
# They appear to be inside the cells.
# TODO: figure out DRC errors
if {[colourise_check_pg_drc] == 0} {
    puts "[colour $COLOUR_RED]Aborting due to PG DRC errors[clear_colour]"
#    return
}

route_global -floorplan true -congestion_map_only true
report_qor -summary
report_timing
report_power
report_constraint -all

# save the lib
save_lib -all

# =============================================================================
# CTS
# =============================================================================

create_new_block "pnr_cts"

puts ""
puts ""
puts "[colour $COLOUR_BLUE]Clock Tree Synthesis[clear_colour]"
puts ""

if {($pause_between_commands == 1) && ([do_continue] == 0)} {
    return
}

# setup
# ---------------------------
# activate all scenarios
set_scenario_status -active true [all_scenarios]

# checks
# ---------------------------
do_check_design pre_clock_tree_stage
check_clock_trees

# Classic CTS
# ---------------------------
colourise_cmd clock_opt
connect_pg_net

# reports / checks
# ---------------------------
check_routes -open_net false
report_clock_qor
report_clock_timing -type summary

# save the lib
save_lib -all

# =============================================================================
# Routing
# =============================================================================

create_new_block "pnr_route"

puts ""
puts ""
puts "[colour $COLOUR_BLUE]Routing[clear_colour]"
puts ""

if {($pause_between_commands == 1) && ([do_continue] == 0)} {
    return
}

# setup
# ---------------------------
# activate all scenarios
set_scenario_status -active true [all_scenarios]

# Antenna rules
# These commands are ported from $PDK_NDM_TECH_FILE_DIR/xx018.ante.rules
# we can't just source that file directly, since it uses commands designed for ICC (not ICC2)
# My analysis suggests these modified commands will still work correctly in ICC2
remove_antenna_rules

# metal rules
define_antenna_rule -mode 4 -diode_mode 4 -metal_ratio 400 -cut_ratio 0
define_antenna_layer_rule -mode 4 -layer "MET1"   -ratio 400 -diode_ratio {0 0 0 1e+07}
define_antenna_layer_rule -mode 4 -layer "MET2"   -ratio 400 -diode_ratio {0 0 0 1e+07}
define_antenna_layer_rule -mode 4 -layer "MET3"   -ratio 400 -diode_ratio {0 0 0 1e+07}
define_antenna_layer_rule -mode 4 -layer "MET4"   -ratio 400 -diode_ratio {0 0 0 1e+07}
define_antenna_layer_rule -mode 4 -layer "METTP"  -ratio 400 -diode_ratio {0 0 0 1e+07}
define_antenna_layer_rule -mode 4 -layer "METTPL" -ratio 200 -diode_ratio {0 0 0 1e+07}

# cut rules
define_antenna_rule -mode 1 -diode_mode 4 -metal_ratio 0 -cut_ratio 20
define_antenna_layer_rule -mode 1 -layer "VIA1"   -ratio 20  -diode_ratio {0 0 0 1e+07}
define_antenna_layer_rule -mode 1 -layer "VIA2"   -ratio 20  -diode_ratio {0 0 0 1e+07}
define_antenna_layer_rule -mode 1 -layer "VIA3"   -ratio 20  -diode_ratio {0 0 0 1e+07}
define_antenna_layer_rule -mode 1 -layer "VIATP"  -ratio 20  -diode_ratio {0 0 0 1e+07}
define_antenna_layer_rule -mode 1 -layer "VIATPL" -ratio 20  -diode_ratio {0 0 0 1e+07}

report_antenna_rules

# checks
# ---------------------------
# There's a few errors/warnings to look at here
do_check_design pre_route_stage
puts "[colour $COLOUR_YELLOW]Warning: TODO - Out of bound ports??[clear_colour]"
check_routability

# Route
# ---------------------------
# initial attempt
colourise_cmd route_auto
# incremental routing to fix DRC issues - maybe not needed?
colourise_cmd "route_detail -incremental true"
# Optimise routing
colourise_cmd route_opt

connect_pg_net

# reports / checks
# ---------------------------
check_routes
check_lvs -checks all -open_reporting detailed

if {[colourise_check_pg_drc] == 0} {
    puts "[colour $COLOUR_RED]Aborting due to PG DRC errors[clear_colour]"
#   return
}

# save the lib
save_lib -all

# =============================================================================
# Finishing
# =============================================================================

create_new_block "pnr_finishing"

puts ""
puts ""
puts "[colour $COLOUR_BLUE]Finishing[clear_colour]"
puts ""

if {($pause_between_commands == 1) && ([do_continue] == 0)} {
    return
}

# ... TODO ...


# Finished - create the final output library block
create_new_block "pnr_out"

# Output a summary of message types
redirect -variable message_info { print_message_info }
puts "[colour $COLOUR_BLUE]$message_info[clear_colour]"

puts "[colour $COLOUR_GREEN]Script finished successfully[clear_colour]"
