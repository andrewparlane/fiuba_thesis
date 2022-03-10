# =============================================================================
# scripts
# =============================================================================

# colourisation
source ../../common/colourisation.tcl

# debug
source ../../common/debug.tcl

# libs
source ../../common/libraries.tcl

# =============================================================================
# RTL source files
# =============================================================================
set ROOT_DIR                "../../../.."
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
# Guidance
# =============================================================================

puts "[colour $COLOUR_BLUE]Guidance[clear_colour]"

set synopsys_auto_setup true
set_svf -ordered ../../synth/work/default.svf ../../dp/work/dp.svf ../../pnr/work/pnr.svf

# =============================================================================
# Read reference design
# =============================================================================

puts "[colour $COLOUR_BLUE]Read Reference Design[clear_colour]"

if {($pause_between_commands == 1) && ([do_continue] == 0)} {
    return
}

# Reference design
read_sverilog -r $SRC_FILES
set_top -auto
write_container -r work/ref_container

# =============================================================================
# Read Implementation design
# =============================================================================

puts "[colour $COLOUR_BLUE]Read Implementation Design[clear_colour]"

if {($pause_between_commands == 1) && ([do_continue] == 0)} {
    return
}

# Implementation design
read_verilog -i ../../pnr/work/netlist_fm.v
read_db -i $PDK_D_CELLS_HD_MAX_LIB
read_db -i $PDK_D_CELLS_HDLL_MAX_LIB
set_top -auto
write_container -i work/imp_container

# =============================================================================
# Match
# =============================================================================

puts "[colour $COLOUR_BLUE]Match[clear_colour]"

if {($pause_between_commands == 1) && ([do_continue] == 0)} {
    return
}

# run match via "tee" to output it to a log too
redirect -tee logs/match.txt {match}

# =============================================================================
# Verify
# =============================================================================

puts "[colour $COLOUR_BLUE]Verify[clear_colour]"

if {($pause_between_commands == 1) && ([do_continue] == 0)} {
    return
}

# run verify via "tee" to output it to a log too
redirect -tee logs/verify.txt {verify}
