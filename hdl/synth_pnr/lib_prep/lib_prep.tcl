source ../common/libraries.tcl
source ../common/colourisation.tcl
source ../common/debug.tcl

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

set_app_options -name lib.workspace.save_design_views -value true
set_app_options -name lib.workspace.save_layout_views -value true
set_app_options -name lib.workspace.keep_all_physical_cells -value true
set_app_options -name lib.workspace.library_developer_mode -value false
set_app_options -name lib.logic_model.auto_remove_timing_only_designs -value true

# These voltages and temperatures should encompass all the .dbs in the HD and HDLL liberty_LPMOS folders
set voltages        {1.62 1.8 1.98}
set temperatures    {-40 0 25 85 125 150 175}
set_pvt_configuration -clear_filter all -add -name all -process_labels {""} -process_numbers {1} -voltages $voltages -temperatures $temperatures

# Create the D_CELLS_HD lib
puts "[colour $COLOUR_BLUE]Creating D_CELLS_HD CLIB[clear_colour]"
set res         [convert_lib "d_cells_hd" $NDM_TECHFILE $PDK_D_CELLS_HD_LEFS $PDK_D_CELLS_HD_LIBERTY_DIR]
if {$res == 0} {
    return
}

if {($pause_between_commands == 1) && ([do_continue] == 0)} {
    return
}

# Create the D_CELLS_HDLL lib
puts "[colour $COLOUR_BLUE]Creating D_CELLS_HDLL CLIB[clear_colour]"
set res         [convert_lib "d_cells_hdll" $NDM_TECHFILE $PDK_D_CELLS_HDLL_LEFS $PDK_D_CELLS_HDLL_LIBERTY_DIR]
if {$res == 0} {
    return
}
