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

    # save the old block
    save_block
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

proc load_antenna_rules {} {
    # These commands are ported from $PDK_NDM_TECH_FILE_DIR/xx018.ante.rules
    # we can't just source that file directly for either techNDM v8.0.1 nor v8.1.1:
    #   v8.0.1 uses commands designed for ICC nto ICC2
    #   v8.1.1 defines antenna rules for MET5 and VIA4, which we don't have
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

    # Assume that all top-level ports are connect to a huge antenna.
    # The antenna is broken by jumping to the top metal layer:
    set_app_options -name route.detail.port_antenna_mode -value jump

    # Without this input nets are not checked for antenna violations by ICC2,
    # but ICV checks them and generates an error.
    # I think this means that ICC2 assumes there's no gates connected to these
    # nets outside of this block. Which is fair enough. The other blocks can add their
    # own antenna protections and the final run of ICV should detect any remaining issues.
    set_app_options -name route.detail.default_port_external_gate_size -value 0

    report_antenna_rules
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

# At this point we've placed all the std_cells so we check_pg_drc
# without the -ignore_std_cells option.
if {[colourise_check_pg_drc] == 0} {
    puts "[colour $COLOUR_RED]Aborting due to PG DRC errors[clear_colour]"
    return
}

route_global -floorplan true -congestion_map_only true
report_qor -summary
report_timing
report_power
report_constraint -all -scenarios [all_scenarios]

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
load_antenna_rules

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
    return
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

# Insert redundant vias
# There's a script to do this in the techNDM dir, specifically $NDM_REDUNDANT_VIA_SCRIPT
# Unfortunately it doesn't work. It appears to be written for a process with more metal layers.
# We can fix this by tweaking the list of VIA names it uses.
set pattern     "^set souVList \"VIA12D_R VIA23D_R VIA34D_R VIA45D_R VIA5TD_R\""
set replacement "set souVList \"VIA12D_R VIA23D_R VIA34D_R VIA4TD_R\""
exec sed "s/$pattern/$replacement/" $NDM_REDUNDANT_VIA_SCRIPT > work/redundant_vias.tcl
# Additionally it expects MetToRoute to be defined before it's run. From what I understand
# we can just set it to "".
set MetToRoute ""
source work/redundant_vias.tcl

# Insert filler cells
# Types:
#   DECAP*  - Filler cell with buffering capacitance, ESD optimized
#             Glue cell with decoupling capacitor between the power rails to decrease power/ground
#             supply bouncing effects. The DECAP cells are built on 1.8V cmos transistors
#             whose gate is not connected to power/ground supply rails. It is recommended to use
#             the DECAP cells in ESD sensible projects. Layout of DECAP cells is optimized for
#             usage them in multi-threshold projects.
#   FCNE*   - filler cell with buffering capacitance, built on NE transistor
#             Glue cell with decoupling capacitor between the power rails to decrease power/ground
#             supply bouncing effects. As the gate of the 1.8V nmos transistor is directly tied to
#             power supply it is recommended to use the FCNE* cells only in projects with XFAB
#             IO_CELLS* pad cells resp. with pad cells which contain XFAB ESD protection structures.
#   FEED*   - Glue cell used to connect the power and ground rails across the row of cells and prevent
#             gaps between well or implant layers in the row which might lead to DRC violations.

# First insert metal filler cells. I'm using DECAP* for now, since FCNE* is recommended for only
# projects that use the IO_CELLS* lib, which we do not.
set CHIP_FINISH_METAL_FILLER_LIB_CELL_LIST d_cells_hdll/DECAP*
set create_stdcell_filler_metal_lib_cell_sorted [get_object_name [sort_collection -descending [get_lib_cells $CHIP_FINISH_METAL_FILLER_LIB_CELL_LIST] area]]
create_stdcell_fillers -lib_cell $create_stdcell_filler_metal_lib_cell_sorted -smallest_cell_size 3
connect_pg_net

# Remove any filler cells that cause DRC violations
remove_stdcell_fillers_with_violation

# Then insert non metal filler cells into any remaining gaps
set CHIP_FINISH_NON_METAL_FILLER_LIB_CELL_LIST d_cells_hdll/FEED*
set create_stdcell_filler_non_metal_lib_cell_sorted [get_object_name [sort_collection -descending [get_lib_cells $CHIP_FINISH_NON_METAL_FILLER_LIB_CELL_LIST] area]]
create_stdcell_fillers -lib_cell $create_stdcell_filler_non_metal_lib_cell_sorted
connect_pg_net

# Check the legality of the currently placed cells
check_legality

# Fix any DRCs caused by redundant via and filler cell insertion
colourise_cmd route_auto

# ... TODO ...
# Fix EM problems - requires EM constraints

# check for more DRC violations
load_antenna_rules
check_routes

# =============================================================================
# ICV in-design
# =============================================================================

create_new_block "pnr_icv_in_design"

puts ""
puts ""
puts "[colour $COLOUR_BLUE]ICV in-design[clear_colour]"
puts ""

if {($pause_between_commands == 1) && ([do_continue] == 0)} {
    return
}

# setup
# ---------------------------

# The foundry runset for ICV used by signoff_check_drc
set ICV_IN_DESIGN_DRC_CHECK_RUNSET 	"$PDK_ICV_DIR/xh018_1143_DRC_MET4_METMID_METTHK.rs"
set_app_options -name signoff.check_drc.runset -value $ICV_IN_DESIGN_DRC_CHECK_RUNSET

# Add $PDK_ICV_DIR to the include path so that the #includes in our runset can be used
set_app_options -name signoff.check_drc.user_defined_options -value "-I $PDK_ICV_DIR"

# save the results in signoff_check_drc/
set signoff_check_drc_run_dir signoff_check_drc
set_app_options -name signoff.check_drc.run_dir -value $signoff_check_drc_run_dir

# Use the layout view not the frame view
set_app_options -name signoff.check_drc.read_layout_views -value {*}

# signoff_check_drc - initial
# ---------------------------

# We need to save to disk as ICV reads from disk file instead of memory
save_block
signoff_check_drc -error_data $signoff_check_drc_run_dir

# signoff_fix_drc
# ---------------------------

# Leaving this commented out for now as we don't currently have any DRC issues
# Attempt to automatically fix any DRC errors
#set_app_options -name signoff.fix_drc.init_drc_error_db -value $signoff_check_drc_run_dir
#set_app_options -name signoff.fix_drc.run_dir -value signoff_fix_drc_rundir
#save_block
#signoff_fix_drc

# Post-fix recheck
#set_app_options -name signoff.check_drc.run_dir -value signoff_check_drc_postfix
#signoff_check_drc

# signoff_create_metal_fill
# ---------------------------

# Create metal fills to meet density requirements
save_block
signoff_create_metal_fill -track_fill generic -select_layers [get_layers MET*] -fill_all_tracks true

# signoff_check_drc - final
# ---------------------------

# Enable the DENSITY_LAY DRC to check that we have a high enough metal density
set_app_options -name signoff.check_drc.user_defined_options -value "-I $PDK_ICV_DIR -D DENSITY_LAY"
set_app_options -name signoff.check_drc.run_dir -value signoff_check_drc_post_metal_fill
save_block
signoff_check_drc

# TODO: Presrumably this doesn't actually do any extraction?
#       what do I have to do to run full timing analysis with metal fill parasitics?
set_extraction_options -real_metalfill_extraction floating

# Final reports
# ---------------------------

check_pg_connectivity -check_std_cell_pins all
check_pg_drc -ignore_clock_nets false -check_metal_on_track true -load_routing_of_all_nets
check_lvs -check_child_cells true -check_zero_spacing_blockages true -report_floating_pins true -open_reporting detailed

# =============================================================================
# Write Data
# =============================================================================

create_new_block "pnr_write_data"

puts ""
puts ""
puts "[colour $COLOUR_BLUE]Write Data[clear_colour]"
puts ""

if {($pause_between_commands == 1) && ([do_continue] == 0)} {
    return
}


# change any names that violate our verilog netlist rules
change_names -rules verilog -hierarchy

# write out the netlist for LVS (with pg, physical only cells)
write_verilog -exclude {scalar_wire_declarations leaf_module_declarations empty_modules} -hierarchy all work/netlist_lvs.v

# write the DEF
write_def -version 5.8 work/design.def

# write the GDS
# XFAB expects different layer numbers to what ICC2 uses.
write_gds -hierarchy all -long_names -keep_data_type work/design_icc2_layers.gds
write_gds -hierarchy all -long_names -keep_data_type -layer_map $NDM_OUT_LAYER_MAP -layer_map_format icc_default work/design_xfab_layers.gds

# Finished - create the final output library block
create_new_block "pnr_out"
close_lib -purge -force -all

# Output a summary of message types
redirect -variable message_info { print_message_info }
puts "[colour $COLOUR_BLUE]$message_info[clear_colour]"

puts "[colour $COLOUR_GREEN]Script finished successfully[clear_colour]"
