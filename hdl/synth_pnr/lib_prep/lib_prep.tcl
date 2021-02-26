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

proc convert_lib { libname techfile lefs db_dir} {
    variable COLOUR_BLUE
    variable pause_between_commands

    puts "[colour $COLOUR_BLUE]Creating workspace[clear_colour]"
    create_workspace -technology $techfile ${libname}_ws

    if {($pause_between_commands == 1) && ([do_continue] == 0)} {
        return 0
    }

    puts "[colour $COLOUR_BLUE]Loading .lefs[clear_colour]"
    foreach lef $lefs {
        puts "read_lef $lef -library $libname"
        colourise_cmd "read_lef $lef -library $libname"
    }

    if {($pause_between_commands == 1) && ([do_continue] == 0)} {
        return 0
    }

    puts "[colour $COLOUR_BLUE]Loading .dbs[clear_colour]"
    foreach db_file [glob -directory $db_dir *.db] {
        colourise_cmd "read_db ${db_file}"
    }

    if {($pause_between_commands == 1) && ([do_continue] == 0)} {
        return 0
    }

    puts "[colour $COLOUR_BLUE]Setting process[clear_colour]"

    colourise_cmd "set_process -label \"\" -number 1 -libraries *"

    puts "[colour $COLOUR_BLUE]Checking the workspace[clear_colour]"
    colourise_cmd "check_workspace -details all -allow_missing"

    puts "[colour $COLOUR_BLUE]Committing the workspace[clear_colour]"
    commit_workspace -force -output work/${libname}.ndm
    return 1
}

# =============================================================================
# Settings
# =============================================================================

set_app_options -name lib.workspace.save_design_views -value true
set_app_options -name lib.workspace.save_layout_views -value true
set_app_options -name lib.workspace.keep_all_physical_cells -value true
set_app_options -name lib.workspace.library_developer_mode -value false
set_app_options -name lib.logic_model.auto_remove_timing_only_designs -value true

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

# The .lef files set the default symmetry to Y for these sites
# Although the sites are called core_hd, core_hd_dh, core_hdll and core_hdll_dh
# And every cell actually specifies symmetry as X Y.
# We apply this attribute to the sites though, so we should be good with just Y
set_attribute [get_site_defs {hd hdll dblh1}] symmetry Y

# Use the HD site as the default, all the sites present in the .tf are the same
# except the dblh1 site, which is double the height of the others. Almost all cells
# in the .lefs use the hd / hdll ones
set_attribute [get_site_defs hd] is_default true

# Set the routing direction - more info on this in the synthesis script
set_attribute [get_layers {MET1 MET3 METTP}] routing_direction horizontal
set_attribute [get_layers {MET2 MET4 METTPL}] routing_direction vertical

# Set the track offset ???
puts "[colour $COLOUR_YELLOW]WARNING: TODO Track offset?[clear_colour]"
#set_attribute [get_layers {??}] track_offset ???

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
set res         [convert_lib "d_cells_hd" $NDM_TECHFILE $PDK_D_CELLS_HD_LEFS $PDK_D_CELLS_HD_LIBERTY_DIR]
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
set res         [convert_lib "d_cells_hdll" $NDM_TECHFILE $PDK_D_CELLS_HDLL_LEFS $PDK_D_CELLS_HDLL_LIBERTY_DIR]
if {$res == 0} {
    return
}

# Output a summary of message types
redirect -variable message_info { print_message_info }
puts "[colour $COLOUR_BLUE]$message_info[clear_colour]"
