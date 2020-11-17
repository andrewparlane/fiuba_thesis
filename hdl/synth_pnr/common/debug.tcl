# ----------------------------------------------------------------------------------
#        File: debug.tcl
# Description: TCL script with some debuging procs
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

if {![info exists pause_between_commands]} {
    set pause_between_commands 0
}

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
