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

# for debugging purposes
if {![info exists pause_between_commands]} {
    set pause_between_commands 0
}

# =============================================================================
# Colourisation
# =============================================================================

set COLOUR_RED     1
set COLOUR_GREEN   2
set COLOUR_YELLOW  3
set COLOUR_BLUE    6

# Set text colour to $colour
proc colour {colour} {
    return [exec tput setaf $colour]
}

# Set text colour to default
proc clear_colour {} {
    return [exec tput sgr0]
}

# Highlight warnings and errors in $buffer
proc colourise {buffer} {
    variable COLOUR_RED
    variable COLOUR_YELLOW
    variable COLOUR_GREEN
    variable COLOUR_BLUE

    # Highlight lines that start with Error: in red
    regsub -line -all {^Error:.*$}          $buffer "[colour $COLOUR_RED]\\0[clear_colour]"     buffer

    # Highlight lines that start with Warning: in yellow
    regsub -line -all {^Warning:.*$}        $buffer "[colour $COLOUR_YELLOW]\\0[clear_colour]"  buffer

    # Highlight lines that start with Information: in blue
    regsub -line -all {^Information:.*$}    $buffer "[colour $COLOUR_BLUE]\\0[clear_colour]"    buffer

    # Highlight lines that start with "Presto compilation completed successfully" in green
    regsub -line -all {^Presto compilation completed successfully.*$} \
                                            $buffer "[colour $COLOUR_GREEN]\\0[clear_colour]"   buffer

    return $buffer
}

proc colourise_cmd {cmd} {
    # redirect the output of the command to a variable (buffer) so we can later apply our colourisation to it
    redirect -variable buffer {
        # save the result
        set res [eval $cmd]
    }

    # Colourise the output
    puts [colourise $buffer]

    # return the result
    return $res
}

# =============================================================================
# Helper functions
# =============================================================================

# sauce: https://stackoverflow.com/a/19003443
proc do_continue {} {
    set stty_settings [exec stty -g]
    exec stty raw -echo

    while {1} {
        puts "Press Y to continue or N to abort"
        set c [string tolower [read stdin 1]]
        puts $c

        if {$c == "y"} {
            set res 1
            break
        } elseif {$c == "n"} {
            set res 0
            break
        }
    }

    exec stty $stty_settings
    return $res
}

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
puts "[colour $COLOUR_YELLOW]WARNING: Confirm all these are correct. I don't know what I'm doing!!![clear_colour]"

# TODO: Tidy all this up, move common definitions and paths to a settings script
set PDK_DIR             "/usr/pdks/xfab180/PDK/XFAB_snps_CustomDesigner_kit_v2_2_2/xh018"

# Just add to this as we start having errors about missing files
#set_app_var search_path ""

# On the 30th October Mariano stated (in an e-mail) that he should confirm later but he thinks that the
# metals are: # 4 thin metals + Top & Thick metal.
# Using /usr/pdks/xfab180/xfab180, and based on Marianos statement, I determined that our tech is xh018,
# and our process code is 1143.
# There seems to be two options for the tech file with xx43 (process code):
#   xh018_xx43_MET4_METMID_METTHK.tf
#   xh018_xx43_HD_MET4_METMID_METTHK.tf
# AFAICT the HD one is needed for 1.8V, so I'm using that.
set TECH_FILE_DIR       "$PDK_DIR/synopsys/v8_0/techMW/v8_0_1/xh018-synopsys-techMW-v8_0_1"
set mw_techfile         "$TECH_FILE_DIR/xh018_xx43_HD_MET4_METMID_METTHK.tf"

set PDK_DIGLIBS_DIR     "$PDK_DIR/diglibs"
set PDK_D_CELLS_DIR     "$PDK_DIGLIBS_DIR/D_CELLS_HD/v3_0"
set PDK_IO_CELLS_DIR    "$PDK_DIGLIBS_DIR/IO_CELLS_C1V8/v1_1"

# Max and Min libs are the "logical libraries" (I think)
set PDK_D_CELLS_LIBERTY_DIR     "$PDK_D_CELLS_DIR/liberty_LPMOS/v3_0_1/PVT_1_80V_range"
set PDK_IO_CELLS_LIBERTY_DIR    "$PDK_IO_CELLS_DIR/liberty_LPMOS/v1_1_0/PVT_1_80V_1_80V_range"

# Max lib is for max delays analysis, which means the slow, hot, undervoltage corner
# The only choice we have here is for max temperature:
#   (D_CELLS)  - 85C, 125C, 150C, 175C
#   (IO_CELLS) -      125C, 150C, 175C
# Using 125C for now
set PDK_D_CELLS_MAX_LIB         "$PDK_D_CELLS_LIBERTY_DIR/D_CELLS_HD_LPMOS_slow_1_62V_125C.db"
set PDK_IO_CELLS_MAX_LIB        "$PDK_IO_CELLS_LIBERTY_DIR/IO_CELLS_C1V8_LPMOS_slow_1_62V_1_62V_125C.db"

# Min lib is for min delay analysis, which means the fast, cold, overvoltage corner
#   (D_CELLS)  - -40C, 0C
#   (IO_CELLS) - -40C, 125C, 150C, 175C - I'm not sure why we have so many hot options here and only one cold?
# Using -40C for now
set PDK_D_CELLS_MIN_LIB         "$PDK_D_CELLS_LIBERTY_DIR/D_CELLS_HD_LPMOS_fast_1_98V_m40C.db"
set PDK_IO_CELLS_MIN_LIB        "$PDK_IO_CELLS_LIBERTY_DIR/IO_CELLS_C1V8_LPMOS_fast_1_98V_1_98V_m40C.db"

set target_max_libs             "$PDK_D_CELLS_MAX_LIB $PDK_IO_CELLS_MAX_LIB"
set_app_var target_library      "$target_max_libs"
set_min_library $PDK_D_CELLS_MAX_LIB -min_version $PDK_D_CELLS_MIN_LIB
set_min_library $PDK_IO_CELLS_MAX_LIB -min_version $PDK_IO_CELLS_MIN_LIB

set SYNOPSYS_LIBS_DIR           "/usr/synopsys2/syn/P-2019.03/libraries/syn"

# The synthetic library is for DesignWave components
# Frome the DC userguide chapter 4:
#   DesignWare components that implement many of the built-in HDL operators are provided
#   by Synopsys. These operators include +, -, *, <, >, <=, >=, and the operations defined by if
#   and case statements.
# The only one I've found is the dw_foundation.sldb below
set_app_var synthetic_library   "$SYNOPSYS_LIBS_DIR/dw_foundation.sldb"

# The symbol library is used to display a schematic of the design
set_app_var symbol_library      "$PDK_D_CELLS_DIR/dc_shell_symb/v3_0_0/D_CELLS_HD.sdb $PDK_IO_CELLS_DIR/dc_shell_symb/v1_1_0/IO_CELLS_C1V8.sdb $SYNOPSYS_LIBS_DIR/generic.sdb"

# The * means search loaded libraries in memory for references
set_app_var link_library        "* $target_max_libs $synthetic_library"

# The milkyway ref lib is the "physical library" (I think)
# These should correspond to the "logical libraries" from before
# Not sure if I need these during synthesis, I think it's a PnR only thing
set PDK_D_CELLS_MW_REF_DIR     "$PDK_D_CELLS_DIR/synopsys_ICC/v3_0_1/xh018-D_CELLS_HD-synopsys_ICCompiler-v3_0_1/xh018_xx43_MET4_METMID_METTHK_D_CELLS_HD"
set PDK_IO_CELLS_MW_REF_DIR    "$PDK_IO_CELLS_DIR/synopsys_ICC/v1_1_0/xh018-IO_CELLS_C1V8-synopsys_ICCompiler-v1_1_0/xh018_xx43_MET4_METMID_METTHK_IO_CELLS_C1V8"

set milkyway_ref_lib            "$PDK_D_CELLS_MW_REF_DIR $PDK_IO_CELLS_MW_REF_DIR"

# Create (and open) our milkyway lib
set mw_design_lib "work/mw_lib"
if {[file isdirectory $mw_design_lib]} {
    # delete the old one first
    exec rm -rf $mw_design_lib
}
colourise_cmd "create_mw_lib -open -technology $mw_techfile -mw_reference_library \"$milkyway_ref_lib\" $mw_design_lib"

set tlup_dir "$PDK_DIR/synopsys/v8_0/TLUplus/v8_0_1"
set tlup_max "$tlup_dir/xh018_xx43_MET4_METMID_METTHK_max.tlu"
set tlup_min "$tlup_dir/xh018_xx43_MET4_METMID_METTHK_min.tlu"
set tlup_map "$tlup_dir/xh018_xx43_MET4_METMID_METTHK.map"

set_tlu_plus_files -max_tluplus $tlup_max -min_tluplus $tlup_min -tech2itf_map  $tlup_map
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

if {($pause_between_commands == 1) && ([do_continue] == 0)} {
    return
}

puts "[colour $COLOUR_GREEN]Script finished successfully[clear_colour]"
