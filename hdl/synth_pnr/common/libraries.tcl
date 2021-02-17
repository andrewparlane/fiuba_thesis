# ----------------------------------------------------------------------------------
#        File: libraries.tcl
# Description: TCL script containing the libraries we use
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
# Process Information
# =============================================================================

# On the 30th October Mariano stated (in an e-mail) that he should confirm later but he thinks that the
# metals are: # 4 thin metals + Top & Thick metal. Using /usr/pdks/xfab180/xfab180, and based on Marianos
# statement, I determined that our tech is xh018, and our process code is 1143.
# We wish to use 1.8V logic, according to: xh018-DataSheet-Digital_Libraries_Overview-v3_7_0.pdf

set PDK_TECH                        "xh018"
set PDK_PROCESS_CODE                "1143"

# =============================================================================
# General Directories
# =============================================================================

set SYNOPSYS_LIBS_DIR               "$::env(SYNOPSYS_SYN_ROOT)/libraries/syn"

set PDK_DIR                         "/usr/pdks/xfab180/PDK/XFAB_snps_CustomDesigner_kit_v2_2_2/xh018"
set PDK_TLUP_DIR                    "$PDK_DIR/synopsys/v8_0/TLUplus/v8_0_1"
set PDK_DIGLIBS_DIR                 "$PDK_DIR/diglibs"

# =============================================================================
# Standard Cells
# =============================================================================

# We use the following Standard Cells:
#   D_CELLS_HD      - "1.8V, 1.2V Standard Speed & Low Power, High Density routing pitch"
#   D_CELLS_HDLL    - "1.8V, 1.2V Low Leakage & Low Power, High Density routing pitch"
set PDK_D_CELLS_HD_DIR              "$PDK_DIGLIBS_DIR/D_CELLS_HD/v3_0"
set PDK_D_CELLS_HDLL_DIR            "$PDK_DIGLIBS_DIR/D_CELLS_HDLL/v2_1"

# =============================================================================
# Technology file
# =============================================================================

# The tech file contains technology specific information required to route a design
set PDK_MW_TECH_FILE_DIR            "$PDK_DIR/synopsys/v8_0/techMW/v8_0_1/xh018-synopsys-techMW-v8_0_1"
set PDK_NDM_TECH_FILE_DIR           "$PDK_DIR/synopsys/v8_0/techNDM/v8_0_1/xh018-synopsys-techNDM-v8_0_1"

set TECHFILE_NAME                   "xh018_xx43_HD_MET4_METMID_METTHK.tf"
set MW_TECHFILE                     "$PDK_MW_TECH_FILE_DIR/$TECHFILE_NAME"
set NDM_TECHFILE                    "$PDK_NDM_TECH_FILE_DIR/$TECHFILE_NAME"

# =============================================================================
# Logic Libraries
# =============================================================================

# Logic Libraries contain info about the characteristics and function of each cell.
# There are a variety of files representing different corners of the PVT.
set PDK_D_CELLS_HD_LIBERTY_DIR      "$PDK_D_CELLS_HD_DIR/liberty_LPMOS/v3_0_1/PVT_1_80V_range"
set PDK_D_CELLS_HDLL_LIBERTY_DIR    "$PDK_D_CELLS_HDLL_DIR/liberty_LPMOS/v2_1_1/PVT_1_80V_range"

# Max lib is for max delays analysis, which means the slow, hot, low voltage corner
# The only choice we have here is for max temperature:
#   (D_CELLS_HD)    -        85C, 125C, 150C, 175C
#   (D_CELLS_HDLL)  - -40C,  85C, 125C, 150C, 175C
# Using 125C for all of them
set PDK_D_CELLS_HD_MAX_LIB          "$PDK_D_CELLS_HD_LIBERTY_DIR/D_CELLS_HD_LPMOS_slow_1_62V_125C.db"
set PDK_D_CELLS_HDLL_MAX_LIB        "$PDK_D_CELLS_HDLL_LIBERTY_DIR/D_CELLS_HDLL_LPMOS_slow_1_62V_125C.db"

# Min lib is for min delay analysis, which means the fast, cold, high voltage corner
#   (D_CELLS_HD)    - -40C, 0C
#   (D_CELLS_HDLL)  - -40C, 0C
# Using -40C for all of them
set PDK_D_CELLS_HD_MIN_LIB          "$PDK_D_CELLS_HD_LIBERTY_DIR/D_CELLS_HD_LPMOS_fast_1_98V_m40C.db"
set PDK_D_CELLS_HDLL_MIN_LIB        "$PDK_D_CELLS_HDLL_LIBERTY_DIR/D_CELLS_HDLL_LPMOS_fast_1_98V_m40C.db"

# These must be in the same order (D_CELLS_HD, D_CELLS_HDLL)
set TARGET_MAX_LIBS                 "$PDK_D_CELLS_HD_MAX_LIB $PDK_D_CELLS_HDLL_MAX_LIB"
set TARGET_MIN_LIBS                 "$PDK_D_CELLS_HD_MIN_LIB $PDK_D_CELLS_HDLL_MIN_LIB"

set OPERATING_CONDITION_MAX         slow_1_62V_125C
set OPERATING_CONDITION_MIN         fast_1_98V_m40C

# =============================================================================
# Milkyway Reference Library
# =============================================================================

# The milkyway ref lib contains physical representation of the standard cells
set PDK_D_CELLS_HD_MW_REF_DIR       "$PDK_D_CELLS_HD_DIR/synopsys_ICC/v3_0_1/xh018-D_CELLS_HD-synopsys_ICCompiler-v3_0_1/xh018_xx43_MET4_METMID_METTHK_D_CELLS_HD"
set PDK_D_CELLS_HDLL_MW_REF_DIR     "$PDK_D_CELLS_HDLL_DIR/synopsys_ICC/v2_1_0/xh018-D_CELLS_HDLL-synopsys_ICCompiler-v2_1_0/xh018_xx43_MET4_METMID_METTHK_D_CELLS_HDLL"

set MILKYWAY_REF_LIB                "$PDK_D_CELLS_HD_MW_REF_DIR $PDK_D_CELLS_HDLL_MW_REF_DIR"

# =============================================================================
# LEFs (used for libp_prep)
# =============================================================================

set PDK_D_CELLS_HD_LEF_DIR          "$PDK_D_CELLS_HD_DIR/LEF/v3_0_0"
set PDK_D_CELLS_HDLL_LEF_DIR        "$PDK_D_CELLS_HDLL_DIR/LEF/v2_1_0"

set PDK_D_CELLS_HD_LEFS             "$PDK_D_CELLS_HD_LEF_DIR/xh018_D_CELLS_HD.lef $PDK_D_CELLS_HD_LEF_DIR/xh018_xx43_MET4_METMID_METTHK_D_CELLS_HD_mprobe.lef"
set PDK_D_CELLS_HDLL_LEFS           "$PDK_D_CELLS_HDLL_LEF_DIR/xh018_D_CELLS_HDLL.lef $PDK_D_CELLS_HDLL_LEF_DIR/xh018_xx43_MET4_METMID_METTHK_D_CELLS_HDLL_mprobe.lef"

# =============================================================================
# TLUPlus files
# =============================================================================

# TLUPlus files contain RC info to help with delay estimations
set TLUP_MAX                        "$PDK_TLUP_DIR/xh018_xx43_MET4_METMID_METTHK_max.tlu"
set TLUP_MIN                        "$PDK_TLUP_DIR/xh018_xx43_MET4_METMID_METTHK_min.tlu"
set TLUP_MAP                        "$PDK_TLUP_DIR/xh018_xx43_MET4_METMID_METTHK.map"

# =============================================================================
# Synthetic / symbol / link Libraries
# =============================================================================

# The synthetic library is for DesignWave components
# Frome the DC userguide chapter 4:
#   DesignWare components that implement many of the built-in HDL operators are provided
#   by Synopsys. These operators include +, -, *, <, >, <=, >=, and the operations defined by if
#   and case statements.
# The only one I've found is the dw_foundation.sldb below
set SYNTHETIC_LIBRARY               "$SYNOPSYS_LIBS_DIR/dw_foundation.sldb"

# The symbol library is used to display a schematic of the design
# We include one per Standard Cell Library that we use
# And the default synopsys one at the end
set SYMBOL_LIBRARY                  "$PDK_D_CELLS_HD_DIR/dc_shell_symb/v3_0_0/D_CELLS_HD.sdb $PDK_D_CELLS_HDLL_DIR/dc_shell_symb/v2_1_0/D_CELLS_HDLL.sdb $SYNOPSYS_LIBS_DIR/generic.sdb"

# The * means search loaded libraries in memory for references
set LINK_LIBRARY                    "* $TARGET_MAX_LIBS $SYNTHETIC_LIBRARY"

# =============================================================================
# Search Path
# =============================================================================

# Just add to this if we start having errors about missing files
# We could shorten some of the paths below by adding paths to the search_path but I like being explicit about
# which files we are using
#set_app_var search_path ""
