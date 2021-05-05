# ----------------------------------------------------------------------------------
#        File: Makefile
# Description: Makefile to run DRC / LVS checks with ICValidator
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

# This is copied from verification/vcs/Makefile and modified

# ----------------------------------------------------------------------------------
# Tested with Synopsys VCS on micro0.fi.uba.ar:
# 	vcs script version : O-2018.09
#	Compiler version = VCS-MX O-2018.09-SP2_Full64
#	VCS Build Date = Feb 28 2019 22:34:30
# ----------------------------------------------------------------------------------

# Prerequisites:
#   Set up your environment on the machine you have vcs installed on
#		This can be done using the /usr/synopsys2/synopsys_rc script (at least on micro0.fi.uba.ar)
#		You may need to copy it to your user directory and chmod 755 it in order to gain execute perms.
#		If you have errors with vcs along the lines of "/usr/bin/ld unrecognised option -plugin"
#		then comment out the HSPICE source line in that script.
#		You can add ". ~/synopsys_rc" to your .bashrc script if desired.
#	Run the pnr script and have the output .gds and netlist_lvs.v

# Rules
#

PNR_WORK_DIR		= ../pnr/work
TOP					= radiation_sensor_digital_top_FDT_TIMING_ADJUST0_SENSOR_VERSION1_ADC_VERSION1
NETLIST_V			= $(PNR_WORK_DIR)/netlist_lvs.v
GDS					= $(PNR_WORK_DIR)/design_xfab_layers.gds

PDK_DIR				= /usr/pdks/xfab180/PDK/XFAB_snps_CustomDesigner_kit_v2_2_2/xh018
DIGLIBS_DIR			= $(PDK_DIR)/diglibs
ICV_RUNSCRIPT_DIR	= $(PDK_DIR)/synopsys/v8_0/ICValidator/v8_0_2

D_CELLS_HD_CDL		= $(DIGLIBS_DIR)/D_CELLS_HD/v3_0/gds_cdl/v3_0_0/cdl/xh018_D_CELLS_HD.cdl
D_CELLS_HDLL_CDL	= $(DIGLIBS_DIR)/D_CELLS_HDLL/v2_1/gds_cdl/v2_1_0/cdl/xh018_D_CELLS_HDLL.cdl
ICV_DRC_RUNSCRIPT	= $(ICV_RUNSCRIPT_DIR)/xh018_1143_DRC_MET4_METMID_METTHK.rs
ICV_LVS_RUNSCRIPT	= $(ICV_RUNSCRIPT_DIR)/xh018_1143_LVS_MET4_METMID_METTHK.rs

# Enable additional checks here, see "0.18um-UserGuide-Synopsys_ICValidator_StarRC-v1_0_0.pdf"
# Must specify each with a -D before, and no quotes e.g:
#EXTRA_x_CHECKS		= -D CHECK_A -D CHECK_B
EXTRA_LVS_CHECKS	= -D FloatingGate -D FloatingWell
EXTRA_DRC_CHECKS	= -D DENSITY_LAY

all: drc lvs

# The netlist_lvs.sp is created using icv_nettran based on the netlist_lvs.v
# which is an output of the PnR script.
lvs_work/netlist_lvs.sp: $(NETLIST_V)
	@mkdir -p lvs_work
	@cd lvs_work && icv_nettran	-verilog ../$(NETLIST_V)					\
								-outType spice -outName netlist_lvs.sp 		\
								-sp $(D_CELLS_HD_CDL) 						\
								-sp $(D_CELLS_HDLL_CDL) > nettran.log

# phony to do nettran
nettran: lvs_work/netlist_lvs.sp

# $(TOP).RESULTS is one of the outputs of running ICValidator in LVS mode
lvs_work/$(TOP).RESULTS: lvs_work/netlist_lvs.sp $(GDS)
	@cd lvs_work && icv	-c $(TOP) -f GDSII -i ../$(GDS)			\
						-stc $(TOP) -s netlist_lvs.sp -sf spice	\
						-I $(ICV_RUNSCRIPT_DIR) 				\
						$(EXTRA_LVS_CHECKS)						\
						$(ICV_LVS_RUNSCRIPT) > lvs.log

# phony to do LVS
lvs: lvs_work/$(TOP).RESULTS
	@echo "LVS Results:"
	@cat lvs_work/$(TOP).RESULTS | head -n 20

lvs_view: lvs
	icv_vue -load lvs_work/$(TOP).vue

# drc_work/$(TOP).RESULTS is one of the outputs of running ICValidator in DRC mode
drc_work/$(TOP).RESULTS: $(GDS)
	@mkdir -p drc_work
	@cd drc_work && icv	-c $(TOP) -f GDSII -i ../$(GDS)		\
						-I $(ICV_RUNSCRIPT_DIR) 			\
						$(EXTRA_DRC_CHECKS)					\
						$(ICV_DRC_RUNSCRIPT) > drc.log

# phony to do DRC
drc: drc_work/$(TOP).RESULTS
	@echo "DRC Results:"
	@cat drc_work/$(TOP).RESULTS | head

drc_view: drc
	icv_vue -load drc_work/$(TOP).vue

clean:
	-rm -rf lvs_work
	-rm -rf drc_work

.PHONY: nettran lvs lvs_view drc drc_view clean
