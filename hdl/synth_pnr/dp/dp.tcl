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
    set cmd "check_design -ems_database logs/check_design.$check -checks $check"
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

# =============================================================================
# SVF for formality guidance
# =============================================================================
set_svf work/dp.svf

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

# I initially created the floorplan using the following options. The problem with this is that
# a small change in the output of the synthesis script could lead to a slightly different sized
# floorplan, causing issues with some of the hard coded numbers in this script. Such as the offsets
# for the PG mesh that mean all our site rows are correctly connected to the PG nets, and the PG
# terminales for connecting to the outside world.

#   control_type:       core    - We specify the size of the core, the boundary is offset from the core
#                                 by the core_offset, and contains the PG rings
#   core_utilisation:   0.75    - Size our core so that the std_cells take up 75% of the space
#   core_offset:        12.6    - The PG rings are 5um wide each with 2.5um spacing, so in total they
#                                 take up 12.5um of space, I give them 0.1um extra.
#   shape:              R       - Rectangular
#   side_ratio:         1       - Aim to make the design square. It may not quite be since
#                                 the height has to be a multiple of the pitch, but the width
#                                 can be anything.
#   site_def:           hd      - Site def to use in the floorplan (Note: the lib_prep script converts
#                                 the HDLL lib to use the hd site too)
#initialize_floorplan    -control_type core          \
#                        -core_utilization 0.75      \
#                        -core_offset {12.6 12.6}    \
#                        -shape R                    \
#                        -side_ratio 1               \
#                        -site_def hd

# Now that I have the basic shape that works I create the floorplan using specific sizes.
# If the output of synthesis changes now, the size of our design will not change unless we
# decide to resize it

#   control_type:       die             - We specify the size of the die
#   core_offset:        12.6            - core is offset from the boundary of the die by 12.6um
#   shape:              R               - Rectangular
#   side_length:        {x y}           - size
#   site_def:           hd              - Site def to use in the floorplan (Note: the lib_prep
#                                         script converts the HDLL lib to use the hd site too)
initialize_floorplan    -control_type die               \
                        -core_offset {12.6 12.6}        \
                        -shape R                        \
                        -side_length {295.68 294.0}     \
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

# Set the pin constraints so that the placement engine can do a better job with coarse cell placement
# We can either read the preferred_port_locations.tcl file, which contains the exact pin locations
# from a previous run of this DP script. Or we can manually set the constraints. Either way a new
# preferred_port_locations.tcl script will be created with the pin locations used by this run.
if {[file exists preferred_port_locations.tcl]} {
    puts "[colour $COLOUR_BLUE]Loading pin constraints from preferred_port_locations.tcl[clear_colour]"
    read_pin_constraints -file_name preferred_port_locations.tcl
} else {
    puts "[colour $COLOUR_BLUE]Setting pin constraints manually[clear_colour]"

    # NOTE: If you modify these constraints, you must delete preferred_port_locations.tcl
    #       and then re-run this script.

    # Ports:
    #   from/to the iso14443a_analogue block    - top edge
    #       clk             - should we treat this separately?
    #       rst_n_async
    #       pause_n_async
    #       lm_out
    #       power[1:0]
    #       afe_version[3:0]
    #
    #   wire bonded constants                   - anywhere
    #       uid_variable[2:0]
    #
    #   from/to the sensor block                - right edge, bottom half
    #       sens_version[3:0]
    #       sens_config[2:0]
    #       sens_enable
    #       sens_read
    #
    #   from/to the adc block                   - right edge top half
    #       adc_version[3:0]
    #       adc_enable
    #       adc_read
    #       adc_conversion_complete
    #       adc_value[15:0]

    set analog_nets [get_nets -expect 10  "clk rst_n_async pause_n_async lm_out power afe_version"]
    set uid_nets    [get_nets -expect 3  "uid_variable"]
    set sens_nets   [get_nets -expect 9  "sens_*"]
    set adc_nets    [get_nets -expect 23 "adc_*"]

    set analog_nets [sort_collection $analog_nets full_name]
    set uid_nets    [sort_collection $uid_nets    full_name]
    set sens_nets   [sort_collection $sens_nets   full_name]
    set adc_nets    [sort_collection $adc_nets    full_name]

    create_bundle -name bundle_iso14443a_analog $analog_nets
    create_bundle -name bundle_uid              $uid_nets
    create_bundle -name bundle_sensor           $sens_nets
    create_bundle -name bundle_adc              $adc_nets

    # The ISO14443A Analogue block goes on top (side 2)
    # no limits as of yet as to where
    # no need to order the ports
    set_bundle_pin_constraints  -bundles bundle_iso14443a_analog    \
                                -self                               \
                                -keep_pins_together true            \
                                -sides 2

    # The UID signals can go anywhere
    set_bundle_pin_constraints  -bundles bundle_uid                 \
                                -self                               \
                                -keep_pins_together true

    # The sensor signals should go on the right hand edge (side 3) in the bottom half
    set_bundle_pin_constraints  -bundles bundle_sensor              \
                                -self                               \
                                -keep_pins_together true            \
                                -bundle_order ordered               \
                                -sides 3                            \
                                -range {180 240}

    # The ADC signals should go on the right hand edge (side 3) in the top half
    set_bundle_pin_constraints  -bundles bundle_adc                 \
                                -self                               \
                                -keep_pins_together true            \
                                -bundle_order ordered               \
                                -sides 3                            \
                                -range {40 100}
}

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
# NOTE: Our boundary is only ~290um * ~290um ATM so not sure if there's a need for the mesh.
#       I'm adding it because we're not short on space on the top metals.
# NOTE: I picked the Y offset_start and the horizontal layer spacing to line the VDD mesh up
#       with a VDD rail, and the VSS mesh to line up with a VSS rail. This allows us to via down
#       to the rails. If the VDD mesh is too close to a VSS rail or vice versa, the VIAs can't fit
#       due to DRC issues.
create_pg_mesh_pattern pg_mesh -layers {{{vertical_layer: METTPL} {spacing: 5}      \
                                          {width: 5} {pitch: 145} {trim: false}}    \
                                        {{horizontal_layer: METTP} {spacing: 7.4}    \
                                          {width: 5} {pitch: 145} {trim: false}}}

set_pg_strategy s_mesh -pattern {{pattern: pg_mesh} {nets: {VDD, VSS}} {offset_start: 141.16 138.56}} \
                       -core -extension {{stop: outermost_ring}}

compile_pg -strategies s_mesh

# Comments from XFab's 0.18um-ApplicationNote-Digital_Implementation_Guidelines-v1_1_0.pdf
#   -   Make the horizontal stripes first, then the vertical ones (allow “wrong direction”
#       routing for the metal layer under the thick metal for the crossings). This allows
#       easy access for the via stacks to the cell rows
#   -   Having routing blockages in the metal layer below METTHK/METTPL in all places where you
#       need to access the “inner ring” of the supply system
# I don't think either of these are necessary. The setup I've got works fine with no DRC issues
# or routing problems.

# RAILS:
# using a width of 0.8um as that's what the std cells use.
create_pg_std_cell_conn_pattern pg_std_cell_rail  -layers {MET1} -rail_width 0.8
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

# create PG terminals
# These boundries are the bounding boxes of the VIAs that connect the
# top edge of the rings to the vertical stripes.
# First build a bounding box that we know should contain these vias
set height [get_attribute [current_design] -name height]
set width [get_attribute [current_design] -name width]
set llx [expr ($width/2)-20]
set lly [expr $height - 13]
set urx [expr ($width/2)+20]
set ury $height
set bbox "{$llx $lly} {$urx $ury}"
# Then get all VIAS within that BBOX that go from METTP to METTPL for nets VDD and VSS
set layerFilter "lower_layer_name==METTP && upper_layer_name==METTPL"
set vddVIA [index_collection [get_vias -filter "$layerFilter && net.full_name==VDD" \
                                       -within $bbox -expect 1] 0]
set vssVIA [index_collection [get_vias -filter "$layerFilter && net.full_name==VSS" \
                                       -within $bbox -expect 1] 0]
# Then create new shapes from the boundary of those VIAS
set vddShape [create_shape -shape_type rect -boundary [get_attribute $vddVIA bounding_box] -layer METTP]
set vssShape [create_shape -shape_type rect -boundary [get_attribute $vssVIA bounding_box] -layer METTP]
# Finally create the terminal using that shape
create_terminal -port VDD -name VDD -object $vddShape
create_terminal -port VSS -name VSS -object $vssShape

# Check the expected IR drop over our PG rails.
# Current power usage estimation at the output of PnR is 251uW Let's use 400uW to be sure.
# analyze_power_plan seems to take -power_budget in mW, so 0.4mW
# The current result of this is:
#   VDD - max IR drop = 0.036mV
#   VSS - max IR drop = 0.039mV
# XFab's 0.18um-ApplicationNote-Digital_Implementation_Guidelines-v1_1_0.pdf says that the PG rings
# and stripes so that the max IR drop is no more than 100mV. So we are fine. We'd have to use >1W
# of power to reach 100mV IR drop.
colourise_cmd "analyze_power_plan -use_terminals_as_pads -voltage 1.8 -nets {VDD VSS} -power_budget 0.4"

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

# write_verilog for LVS (with pg, and with physical only cells)
write_verilog -exclude {scalar_wire_declarations leaf_module_declarations empty_modules} -hierarchy all work/netlist_lvs.v

# write_verilog for PrimeTime (no pg, no physical only cells, and no supply statments)
write_verilog -exclude {scalar_wire_declarations leaf_module_declarations end_cap_cells well_tap_cells filler_cells pad_spacer_cells physical_only_cells cover_cells supply_statements pg_netlist} -hierarchy all work/netlist_pt.v

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
