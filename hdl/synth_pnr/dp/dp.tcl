# ----------------------------------------------------------------------------------
#        File: dp.tcl
# Description: TCL script to perform Design Planning using Synopsys IC compiler 2
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

# =============================================================================
# Design Init
# =============================================================================
puts "[colour $COLOUR_BLUE]Design Init[clear_colour]"

# Creating a design library using the CLIBs created by the lib_prep script
# paths are from the work dir, hence extra ../
create_lib  -use_technology_lib ../../lib_prep/work/tech_only.ndm      \
            -ref_libs { ../../lib_prep/work/tech_only.ndm              \
                        ../../lib_prep/work/d_cells_hd.ndm             \
                        ../../lib_prep/work/d_cells_hdll.ndm }         \
            $lib_name

# Read the netlist in (result of synthesis)
colourise_cmd "read_verilog -design $design_name/dp_init ../synth/work/final_netlist.v"

# Link the netlist to the reference libraries
colourise_cmd "link_block"

# As per XFab's 0.18um-ApplicationNote-Digital_Implementation_Guidelines-v1_1_0.pdf
# Version November 2008, section 7.1,
# When you have METTHK (or METTPL) as top metal:
#   Block METTHK/METTPL for normal signal routing due to too high parasitics.
# So set the max routing layer to METTP (one below METTPL)
set_ignored_layers -max_routing_layer METTP

do_check_design "dp_pre_floorplan"

# Create the floorplan
#   control_type:       die     - this defines the maximum size of my design, but since there are no IO cells the
#                                 core and the die have the same size.
#   core_utilisation:   0.7     - This is the default (70% cells, 30% routing)
#   core_offset:        0.1     - There are no IO cells so no need for difference between the core and the boundary
#                                 However I get warnings during PnR when using 0 about tracks not crossing the core
#                                 area. Using 0.1 here fixes that, and doesn't really affect our overall area
#   shape:              R       - Rectangular
#   side_length:        260,260 - Synthesis reports cell area as ~52,000 um^2, if that counts for 70% of the area
#                                 then 100% is 74,286 um^2, so for a square the side lengths would be 272.6 um.
#                                 I've since determined that 260x260 works pretty well. Giving decent cell density
#                                 and congestion statistics.
#   site_def:           hd      - Site def to use in the floorplan (Note: the lib_prep script converts
#                                 the HDLL lib to use the hd site too)
initialize_floorplan    -control_type die       \
                        -core_utilization 0.7   \
                        -core_offset 0.1        \
                        -shape R                \
                        -side_length {260 260}  \
                        -site_def hd

# Load timing constraints from synthesis
colourise_cmd "source ../synth/work/constraints/top.tcl"

# save the lib
save_lib -all

# =============================================================================
# Pre Shaping
# =============================================================================

create_new_block "dp_pre_shaping"

puts ""
puts ""
puts "[colour $COLOUR_BLUE]Pre Shaping[clear_colour]"
puts ""

if {($pause_between_commands == 1) && ([do_continue] == 0)} {
    return
}

# Connect all the std_cells to the power and ground nets (VDD/VSS)
colourise_cmd "connect_pg_net -automatic -all_blocks"

colourise_cmd "check_mv_design -erc_mode"
colourise_cmd "check_mv_design -power_connectivity"

# save the lib
save_lib -all

# =============================================================================
# Shaping
# =============================================================================

create_new_block "dp_shaping"

puts ""
puts ""
puts "[colour $COLOUR_BLUE]Shaping[clear_colour]"
puts ""

if {($pause_between_commands == 1) && ([do_continue] == 0)} {
    return
}

do_check_design "dp_pre_block_shaping"

# Not sure if this is necessary, I think it's only if you have multiple blocks to layout
colourise_cmd "shape_blocks -channels false"

# save the lib
save_lib -all

# =============================================================================
# Placement
# =============================================================================

create_new_block "dp_placement"

puts ""
puts ""
puts "[colour $COLOUR_BLUE]Placement[clear_colour]"
puts ""

if {($pause_between_commands == 1) && ([do_continue] == 0)} {
    return
}

# TODO: Read pin constraints (once I've decided on them) with one of
#read_pin_constraints -file_name $CUSTOM_PIN_CONSTRAINT_FILE
#set_*_pin_constraints ...

do_check_design "dp_pre_macro_placement"

# Rough placement of std_cells for design floorplaning purposes
colourise_cmd "create_placement -floorplan"
report_placement -physical_hierarchy_violations all -wirelength all -hard_macro_overlap -verbose high

# save the lib
save_lib -all

# =============================================================================
# Create Power
# =============================================================================

create_new_block "dp_create_power"

puts ""
puts ""
puts "[colour $COLOUR_BLUE]Create Power[clear_colour]"
puts ""

if {($pause_between_commands == 1) && ([do_continue] == 0)} {
    return
}

do_check_design "dp_pre_power_insertion"

# RINGS:
#   As per XFab's 0.18um-ApplicationNote-Digital_Implementation_Guidelines-v1_1_0.pdf
#   Version November 2008, section 7.1,
#     Rings and stripes in general should have 10 um width
#     When you have METTHK (or METTPL) as top metal:
#         Use METTHK/METTPL for vertical and horizontal rings/stripes
#         Width can be reduced to 5 um
#   Design rules state min spacing of METTPL is 2.5 um
#   Not sure if I should go higher than that?
#
# Note: It states that I should put both horizontal and vertical rings on METTPL
#       but I'm currently using METTPL and METTP, as elsewhere it suggests using the top two
#       layers, which makes life simpler when it comes to the mesh
create_pg_ring_pattern pg_ring  -horizontal_layer METTP     \
                                -horizontal_width {5}       \
                                -horizontal_spacing {2.5}   \
                                -vertical_layer METTPL      \
                                -vertical_width {5}         \
                                -vertical_spacing {2.5}     \
                                -corner_bridge false

set_pg_strategy s_core_ring -core -pattern {{pattern: pg_ring}{nets: {VDD VSS}}} \
                                  -extension {{stop: core_boundary}}

compile_pg -strategies s_core_ring

# MESH:
#   As per XFab's 0.18um-ApplicationNote-Digital_Implementation_Guidelines-v1_1_0.pdf
#   Version November 2008, section 7.1,
#     The distance between stripes should be 250 … 350 um
#
# NOTE: Our floorplan is only 260um * 260um ATM so not sure if there's a need for the mesh.
#       However I can't get the rails (below) to connect directly to the rings, so I'm adding
#       the mesh in, as a single horizontal and vertical stripe for each of ground and power
#       about the center of the design
create_pg_mesh_pattern pg_mesh -layers {{{vertical_layer: METTPL} {spacing: 5}      \
                                          {width: 5} {pitch: 130} {trim: false}}    \
                                        {{horizontal_layer: METTP} {spacing: 4}     \
                                          {width: 5} {pitch: 130} {trim: false}}}

set_pg_strategy s_mesh -pattern {{pattern: pg_mesh} {nets: {VDD, VSS}} {offset_start: 130 130}} \
                       -core -extension {{stop: outermost_ring}}

compile_pg -strategies s_mesh

# TODO: do we need to do these? Might help, but probably not essential
puts "[colour $COLOUR_YELLOW]Warning: TODO - do we need wrong direction routing and routing blockages under power rings/stripes[clear_colour]"
# Comments from XFab's 0.18um-ApplicationNote-Digital_Implementation_Guidelines-v1_1_0.pdf
#   -   Make the horizontal stripes first, then the vertical ones (allow “wrong direction”
#       routing for the metal layer under the thick metal for the crossings). This allows
#       easy access for the via stacks to the cell rows
#   -   Having routing blockages in the metal layer below METTHK/METTPL in all places where you
#       need to access the “inner ring” of the supply system

# RAILS:
create_pg_std_cell_conn_pattern pg_std_cell_rail  -layers {MET1} -rail_width 0.23
set_pg_strategy s_std_cell_rail -core -pattern {{name: pg_std_cell_rail} {nets: VDD VSS}} -extension {{{stop : outermost_ring}}}
compile_pg -strategies s_std_cell_rail

# Make sure everything is connected
resolve_pg_nets
connect_pg_net -automatic

# Check phyiscal connectivity
colourise_cmd "check_pg_connectivity -check_std_cell_pins none"

# Create error report for PG ignoring std cells because they are not legalized
if {[colourise_check_pg_drc -ignore_std_cells] == 0} {
    puts "[colour $COLOUR_RED]Aborting due to PG DRC errors[clear_colour]"
    return
}

# check_mv_design -erc_mode and -power_connectivity
colourise_cmd "check_mv_design -erc_mode"
colourise_cmd "check_mv_design -power_connectivity"

# TODO: Analyse power network correctly (need a sensible power_budget)
set_virtual_pad -net VDD -coordinate {140 0}
set_virtual_pad -net VSS -coordinate {140 0}
colourise_cmd "analyze_power_plan -nets {VDD VSS} -power_budget 1000"

# save the lib
save_lib -all

# =============================================================================
# Place Pins
# =============================================================================

create_new_block "dp_place_pins"

puts ""
puts ""
puts "[colour $COLOUR_BLUE]Place Pins[clear_colour]"
puts ""

if {($pause_between_commands == 1) && ([do_continue] == 0)} {
    return
}

do_check_design "dp_pre_pin_placement"

# create PG terminals
# These boundries are the bounding boxes of the VIAs that connect the
# top edge of the rings to the vertical stripes.
# They will need to be adjusted if the boundry / stripes or rings are adjusted.
set shape [create_shape -shape_type rect -boundary {{{127.5500 255.5100} {132.4500 260.4100}}} -layer METTP]
create_terminal -port VDD -name VDD -object [get_shape $shape]

set shape [create_shape -shape_type rect -boundary {{137.5500 263.0100} {142.4500 267.9100}} -layer METTP]
create_terminal -port VSS -name VSS -object [get_shape $shape]

colourise_cmd "place_pins -self"
write_pin_constraints -self -file_name preferred_port_locations.tcl     \
                      -physical_pin_constraint {side | offset | layer}  \
                      -from_existing_pins

colourise_cmd "check_pin_placement -self -pre_route true -pin_spacing true -sides true -layers true -stacking true"

# save the lib
save_lib -all

# =============================================================================
# Estimate Timing
# =============================================================================

create_new_block "dp_estimate_timing"

puts ""
puts ""
puts "[colour $COLOUR_BLUE]Estimate Timing[clear_colour]"
puts ""

if {($pause_between_commands == 1) && ([do_continue] == 0)} {
    return
}

do_check_design "dp_pre_timing_estimation"

current_scenario virtual_scenario
colourise_cmd "estimate_timing"

colourise_cmd "report_timing -corner estimated_corner -mode [all_modes]"
colourise_cmd "report_qor    -corner estimated_corner"
colourise_cmd "report_qor    -summary"

# Remove that estimated_corner now
remove_corners estimated_corner

# save the lib
save_lib -all

# =============================================================================
# Write Data
# =============================================================================

create_new_block "dp_write_data"

puts ""
puts ""
puts "[colour $COLOUR_BLUE]Write Data[clear_colour]"
puts ""

if {($pause_between_commands == 1) && ([do_continue] == 0)} {
    return
}

# TODO: UPF stuff
# Write full UPF
#save_upf $path_dir/${block_refname_no_label}.icc2.out.upf
# Write supplimental UPF
#set_app_options -name mv.upf.enable_golden_upf -value true
#save_upf -format supplemental $path_dir/${block_refname_no_label}.sup.icc2.out.upf

# write_verilog for LVS (with pg, and with physical only cells)
write_verilog -exclude {scalar_wire_declarations leaf_module_declarations empty_modules} -hierarchy all work/netlist_lvs.v

# write_verilog for PrimeTime (no pg, no physical only cells, and no supply statments)
write_verilog -exclude {scalar_wire_declarations leaf_module_declarations end_cap_cells well_tap_cells filler_cells pad_spacer_cells physical_only_cells cover_cells supply_statements pg_netlist} -hierarchy all work/netlist_pt.v

# Write out the LEF - not sure what this is for
write_lef work/design_plan_out.lef

# Write out the floorplan (maybe not needed)
write_floorplan -output work/design.floorplan -force -nosplit -format icc2

# Write out constraints for each scenario
foreach_in_collection sce [get_scenarios] {
    write_sdc -output work/${sce}.sdc -scenario $sce -nosplit
}

# create a new final block for importing into the PnR script
create_new_block "dp_out"

save_lib -all
close_lib

# Output a summary of message types
redirect -variable message_info { print_message_info }
puts "[colour $COLOUR_BLUE]$message_info[clear_colour]"

puts "[colour $COLOUR_GREEN]Script finished successfully[clear_colour]"
