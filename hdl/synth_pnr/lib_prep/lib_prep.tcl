# ----------------------------------------------------------------------------------
#        File: lib_prep.tcl
# Description: TCL script to prepare NDM libraries for use with ICC2
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
# Helper functions
# =============================================================================

# sets the site symmetry, the default site, routing directions and track offsets
proc set_tech_info {} {
    # The .lef files set the default symmetry to Y for these sites
    # Although the sites are called core_hd, core_hd_dh, core_hdll and core_hdll_dh
    # And every cell actually specifies symmetry as X Y.
    # We apply this attribute to the sites though, so we should be good with just Y
    set_attribute [get_site_defs {hd hdll dblh1}] symmetry Y

    # Use the HD site as the default.
    set_attribute [get_site_defs hd] is_default true

    # Set the routing direction - more info on this in the synthesis script
    set_attribute [get_layers {MET1 MET3 METTP}] routing_direction horizontal
    set_attribute [get_layers {MET2 MET4 METTPL}] routing_direction vertical

    # Set the track offset - I don't know what this is for. I found the values in the
    # d_cells_hd NDM provided by XFAB. It could be incorrect for d_cells_hdll.
    set_attribute [get_layers {MET1 MET2 MET3 MET4 METTP}] track_offset 0.28
    set_attribute [get_layers {METTPL}] track_offset 2.8
}

# libname       - the output NDM has this name
# suffix        - HD/HDLL/...
# lef           - the .lef file to read
# gds           - the .gds file to read
# db_dir        - the directory containing the .db files to read.
# convert_sites - When you read the lef it can convert sites from one name to another
#                 "{core_hd hd} {core_hd_dh hd}"
#                 This prevents a bunch of warnings about them being auto converted to the default site
#                 Note even the double height sites are converted to the default site, but the
#                 "multiple" property is set to 2x to indicate they are double height.
proc convert_lib { libname suffix lef gds db_dir convert_sites} {
    variable COLOUR_BLUE
    variable pause_between_commands

    # from common/libraries.tcl
    variable NDM_LAYER_MAP
    variable NDM_TECHFILE

    # ---------------------------------------------------------------
    # LEF only workspace
    # ---------------------------------------------------------------

    # First we create the basic frame view using the .lef for reference later.
    # The bounding boxes auto derived from reading the .gds are not correct, so we manually tweak
    # them as part of the later edit flow. We then compare the fixed bounding boxes with those
    # generated from the .lef only, which are correct.
    puts "[colour $COLOUR_BLUE]Creating LEF only workspace[clear_colour]"
    create_workspace -technology $NDM_TECHFILE ${libname}_lef_only_ws

    # Read the LEF
    set cmd "read_lef $lef -library $libname -convert_sites \"$convert_sites\""
    puts $cmd
    colourise_cmd $cmd

    # Output bounding box info for every cell
    foreach_in_collection lib_cell [get_lib_cells ${libname}/*] {
        set name        [get_attribute $lib_cell -name name]
        set bbox        [get_attribute $lib_cell -name bbox]
        set boundary    [get_attribute $lib_cell -name boundary]
        set width       [get_attribute $lib_cell -name width]
        set height      [get_attribute $lib_cell -name height]

        puts "$name, $width, $height, $bbox, $boundary"
    } > logs/${libname}_lef_boundaries.log

    # OK so we're done with this workspace, clean it up and remove it
    remove_workspace

    # ---------------------------------------------------------------
    # Main workspace
    # ---------------------------------------------------------------

    if {($pause_between_commands == 1) && ([do_continue] == 0)} {
        return 0
    }

    puts "[colour $COLOUR_BLUE]Creating main workspace[clear_colour]"
    create_workspace -technology $NDM_TECHFILE ${libname}_ws

    puts "[colour $COLOUR_BLUE]Reading GDS[clear_colour]"
    set cmd "read_gds -library $libname $gds -centerline_boundary -layer_map $NDM_LAYER_MAP"
    puts $cmd
    colourise_cmd $cmd

    # The gds has pg names as vdd! and gnd!, rename them to vdd and gnd
    set_attribute [get_lib_pins ${libname}/*/vdd!] -name name -value vdd
    set_attribute [get_lib_pins ${libname}/*/gnd!] -name name -value gnd

    puts "[colour $COLOUR_BLUE]Reading LEF[clear_colour]"
    set cmd "read_lef $lef -library $libname -merge_action attribute_only -convert_sites \"$convert_sites\""
    puts $cmd
    colourise_cmd $cmd

    puts "[colour $COLOUR_BLUE]Loading .dbs[clear_colour]"
    foreach db_file [glob -directory $db_dir *.db] {
        colourise_cmd "read_db ${db_file}"
    }

    # These cells have some issues:
    #   CLKVBUFHD   - missing pins in layout - this is a virtual clk buffer
    #                 it also has no timing info available, which library manager
    #                 considers an error
    #   MPROBE*     - These cells exist in separate GDS files, and there are notes that
    #                 they shouldn't be mixed into the same library. Although I could
    #                 be misunderstanding this. Either way we currently don't use them.
    remove_lib_cell [get_lib_cell */CLKVBUF${suffix}]
    remove_lib_cell [get_lib_cell */MPROBE${suffix}]
    remove_lib_cell [get_lib_cell */MPROBEBU${suffix}X8]

    # sets the site symmetry, the default site, routing directions and track offsets
    set_tech_info

    # Set all cells to use the hd site
    # It auto calculates the multiple for the double height cells
    set_cell_site -library ${libname} -site_def hd

    # We need to use -allow_missing because not all logical libraries (the .dbs) contain
    # leakage power info on the ANTENNACELLNP2HD cell.
    puts "[colour $COLOUR_BLUE]Checking the workspace[clear_colour]"
    colourise_cmd "check_workspace -details all -allow_missing"

    puts "[colour $COLOUR_BLUE]Committing the workspace[clear_colour]"
    commit_workspace -output work/${libname}_tmp.ndm

    if {($pause_between_commands == 1) && ([do_continue] == 0)} {
        return 0
    }

    # ---------------------------------------------------------------
    # Edit workspace
    # ---------------------------------------------------------------

    # There are a couple of problems with our library at this point:
    #   1) Incorrect bounding boxes and widths
    #   2) Missing via regions / pins off track
    # I can't find a way to fix these in the above flow, it appears that you have to
    # commit the workspace and then create a new one in the edit flow.

    puts "[colour $COLOUR_BLUE]Creating edit workspace[clear_colour]"
    create_workspace -flow edit work/${libname}_tmp.ndm

    puts "[colour $COLOUR_BLUE]Fixing widths[clear_colour]"
    foreach_in_collection lib_cell [get_lib_cells ${libname}_tmp/*] {
        set name [get_attribute $lib_cell -name name]
        # has the correct horizontal points
        set bbox [get_attribute $lib_cell -name bbox]
        # has the correct vertical points (-centerline_boundary)
        set boundary [get_attribute $lib_cell -name boundary_bbox]
        set old_width [get_attribute $lib_cell -name width]

        # get x limits
        lassign $bbox bbox_bl bbox_tr
        lassign $bbox_bl x1 dummy
        lassign $bbox_tr x2 dummy

        # get y limits
        lassign $boundary boundary_bl boundary_tr
        lassign $boundary_bl dummy y1
        lassign $boundary_tr dummy y2

        set new_boundary "{$x1 $y1} {$x1 $y2} {$x2 $y2} {$x2 $y1}"
        set_attribute $lib_cell boundary $new_boundary
    }

    # FEED1HD doesn't have any vias (it's just the rails), so -centerline_boundary doesn't work
    # also the width and bbox stuff is all off. Manually fix based on width defined in the .lef
    # The width is also the site's width, so we could use that too.
    set lib_cell [get_lib_cell ${libname}_tmp/FEED1${suffix}]
    set x1 0.00
    set y1 0.00
    set x2 0.56
    set y2 [get_attribute [get_site_def hd] -name height]
    set new_boundary "{$x1 $y1} {$x1 $y2} {$x2 $y2} {$x2 $y1}"
    set_attribute $lib_cell boundary $new_boundary

    # remove and recreate via regions
    derive_via_regions

    colourise_cmd "check_workspace -details all"
    commit_workspace -output work/${libname}.ndm

    # ---------------------------------------------------------------
    # Generate reports
    # ---------------------------------------------------------------

    # For some reason some data only gets updated in the reports after you commit the workspace
    # and then open the resulting lib.
    open_lib work/${libname}.ndm

    report_lib ${libname} -timing_arcs -parasitic_tech -physical -antenna -routability -placement_constraints -wire_tracks -wire_track_colors -nosplit > logs/report_${libname}.log

    # Output bounding box info for every cell
    # This gets compared with the lef only data in the ./run_lm script
    # as a final sanity check.
    foreach_in_collection lib_cell [get_lib_cells ${libname}/*] {
        set name        [get_attribute $lib_cell -name name]
        set bbox        [get_attribute $lib_cell -name bbox]
        set boundary    [get_attribute $lib_cell -name boundary]
        set width       [get_attribute $lib_cell -name width]
        set height      [get_attribute $lib_cell -name height]

        puts "$name, $width, $height, $bbox, $boundary"
    } > logs/${libname}_final_boundaries.log

    close_lib

    return 1
}

# =============================================================================
# Settings
# =============================================================================

# There are a lot of infos/warnings output by check_workspace, limit a couple of them
# for readability:
#   FRAM-069    - warning       - There is no via region created in block '%s.frame'.
#   LM-055      - warning       - Direction for port %s on %s is changed from unknown to %s
#                                   This is because the physical lib (gds) doesn't have port
#                                   directions but the logical libs (db) do.
#   LM-045      - information   - Fixed PG mismatch: %s name %s overrides %s.
#                                   This is because the PG names in the GDS are not the same
#                                   as in the DBs. GDS: vdd!/gnd!, DB: vdd/gnd
#                                   The tools use the GDS ones.
#   LM-037      - information   - Combined  physical  block  %s/%s  (with  %s port reordering)
#                                   This is just a verbose info message
#   LEFR-025    - information   - '%s' already exists in %s (will %s)
#                                   This comes up when reading data from the LEF file that was
#                                   already read from the gds (such as pin names)
#   GDS-050     - information   - Translating structure '%s' as cell '%s/%s'
#                                   This is just a verbose info message
set_message_info -id FRAM-069 -limit 5
set_message_info -id LM-055 -limit 5
set_message_info -id LM-045 -limit 5
set_message_info -id LM-037 -limit 5
set_message_info -id LEFR-025 -limit 5
set_message_info -id GDS-050 -limit 5

# Keep the design, layout views and physical cells
set_app_options -name lib.workspace.save_design_views -value true
set_app_options -name lib.workspace.save_layout_views -value true
#set_app_options -name lib.workspace.keep_all_physical_cells -value true

# docs say library end uses should set this as false
# it will be auto set true in a future version, so setting it explicitly here
set_app_options -name lib.workspace.library_developer_mode -value false

# Automatically remove cells that don't exist in the physical library
set_app_options -name lib.logic_model.auto_remove_timing_only_designs -value true

# GDS import settings (required to be set before running read_gds).
#   Not sure what the trace_terminal_type option does, but have to set it to PG or signal
#       and PG seems to work.
#   port_type_map specifies that the GDS power net is called vdd! and the ground net is called gnd!
set_app_options -name file.gds.trace_terminal_type -value PG
set_app_options -name file.gds.port_type_map -value {"power vdd!" "ground gnd!"}

# These voltages and temperatures should encompass all the .dbs in the HD and HDLL liberty_LPMOS folders
set voltages        {1.62 1.8 1.98}
set temperatures    {-40 0 25 85 125 150 175}
set_pvt_configuration -clear_filter all -add -name all -process_labels {""} -process_numbers {1} -voltages $voltages -temperatures $temperatures

# =============================================================================
# Tech only
# =============================================================================

# Create our technology only NDM lib, see:
# https://solvnet.synopsys.com/dow_retrieve/latest/kb/dg/icc2/videos/Library_Preparation_NDM_Demystified.mp4
# At timestamp 11:30

puts "[colour $COLOUR_BLUE]Creating Technology only library[clear_colour]"
create_workspace -technology $NDM_TECHFILE tech_only_ws

# Read the TLUP files
read_parasitic_tech -tlup $TLUP_MAX -layermap $TLUP_MAP -name maxTLU
read_parasitic_tech -tlup $TLUP_MIN -layermap $TLUP_MAP -name minTLU

# sets the site symmetry, the default site, routing directions and track offsets
set_tech_info

# Write it out
colourise_cmd "commit_workspace -output work/tech_only.ndm"

if {($pause_between_commands == 1) && ([do_continue] == 0)} {
    return
}

# =============================================================================
# D_CELLS_HD
# =============================================================================

# Create the D_CELLS_HD lib
puts "[colour $COLOUR_BLUE]Creating D_CELLS_HD CLIB[clear_colour]"
set res [convert_lib    "d_cells_hd"                    \
                        "HD"                            \
                        $PDK_D_CELLS_HD_LEF             \
                        $PDK_D_CELLS_HD_GDS             \
                        $PDK_D_CELLS_HD_LIBERTY_DIR     \
                        "{core_hd hd} {core_hd_dh hd}"]
if {$res == 0} {
    return
}

if {($pause_between_commands == 1) && ([do_continue] == 0)} {
    return
}

# =============================================================================
# D_CELLS_HDLL
# =============================================================================

# Create the D_CELLS_HDLL lib
puts "[colour $COLOUR_BLUE]Creating D_CELLS_HDLL CLIB[clear_colour]"
set res [convert_lib    "d_cells_hdll"                  \
                        "HDLL"                          \
                        $PDK_D_CELLS_HDLL_LEF           \
                        $PDK_D_CELLS_HDLL_GDS           \
                        $PDK_D_CELLS_HDLL_LIBERTY_DIR   \
                        "{core_hdll hd} {core_hdll_dh hd}"]
if {$res == 0} {
    return
}

# Output a summary of message types
redirect -variable message_info { print_message_info }
puts "[colour $COLOUR_BLUE]$message_info[clear_colour]"
