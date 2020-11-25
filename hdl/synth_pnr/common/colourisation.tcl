# ----------------------------------------------------------------------------------
#        File: colourisation.tcl
# Description: TCL script to add colours to output
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

if {![info exists no_colours]} {
    set no_colours 0
}

set COLOUR_RED     1
set COLOUR_GREEN   2
set COLOUR_YELLOW  3
set COLOUR_BLUE    6

# Set text colour to $colour
proc colour {colour} {
    variable no_colours
    if {$no_colours == 1} {
        return ""
    }
    return [exec tput setaf $colour]
}

# Set text colour to default
proc clear_colour {} {
    variable no_colours
    if {$no_colours == 1} {
        return ""
    }
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

    # Highlight lines that contain "(MET)" in green
    regsub -line -all {^.*\(MET\).*$}       $buffer "[colour $COLOUR_GREEN]\\0[clear_colour]"   buffer

    # Highlight lines that end with "(VIOLATED)" in red
    regsub -line -all {^.*\(VIOLATED\).*$}  $buffer "[colour $COLOUR_RED]\\0[clear_colour]"   buffer

    return $buffer
}

proc colourise_cmd {cmd} {
    variable no_colours
    if {$no_colours == 1} {
        return [eval $cmd]
    }

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
