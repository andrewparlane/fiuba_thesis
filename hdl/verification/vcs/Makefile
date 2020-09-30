# ----------------------------------------------------------------------------------
#        File: Makefile
# Description: Makefile to build and run testbenches with VCS
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
# 	set the REMOTE_SERVER and REMOTE_PATH vars below
#		If you want to edit the files on your local machine and run vcs on a server
#		then you can use the push_to_remote and connect_to_remote rules to make life easier.
#		REMOTE_SERVER is username@server.address
#		REMOTE_PATH is where you want to push the files either /absolute/path/to/dest
#		or ~/relative/path/from/home/dir.
#		If you wish to use the GUI (DVE) on the remote server then you must have the ability
#		to launch X apps remotely via ssh -X, I'm not sure how this works with linux, but with
#		cygwin follow: https://codeyarns.com/2018/04/01/how-to-use-cygwin-x-server-for-local-and-remote/
# 	set all the directory vars correctly
#		ROOT_DIR should be a relative or absolute path to the top level repository dir
#		SRC_DIR is the relative path from ROOT_DIR to the source files.
#		PKG_DIR is the relative path from ROOT_DIR to a dir with packages in
#		TB_SRC_DIR is the relative path from ROOT_DIR to the testbenches
# 		VCS_DIR is the relative path from ROOT_DIR to the directory that contains this Makefile
#		SRCS should be a list of all sources files (including testbenches). Packages should come first
#		TBS should be a list of module names of testbenches. This is used to build the Makefile rules
#	edit the _ARGS vars as required
#		VLOGAN_ARGS
#		VCS_ARGS
#		SIMV_ARGS

# Rules (where X is one of the values in $(TBS)):
#	list_tbs:			prints a list of known testbenches
#	analyse: 			analyse all source files using vlogan
#	elaborate: 			elaborate all testbenches into _simv binaries
# 	X_simv:				elaborate the X into the X_simv binary
#	X:					run the X simulation (executes ./X_simv)
#	clean:				deletes all generated files
#	push_to_remote:		syncs local files to the remote server
# 	connect_to_remote:	ssh to the remote server and cd to the vcs dir

# Macros (not describing all of them, just the main ones):
#	COLOURISE:			Applies a long sed script to the output of the passed command,
#						which adds colours to the output of the various synopsys tools
#	ANALYSE:			Runs vlogan to analyse the source files
#	ELABORATE:			Runs vcs to elaborate the source files into _simv binaries
#	RUN_SIM:			Executes the simulation (See command line args below)

# Command line arguments:
#	INTERACTIVE:		running "make INTERACTIVE=1 X" will cause VCS to start up and wait for
#						user input in the UCLI. You can add breakpoints / step through, etc..
#	GUI:				running "make GUI=1 X" will start VCS with the -gui flag, opening DVE
#	RANDOM_SEED=X:		set the random number generator's seed to X

# Note: This is copied (with modifications) from the ISO/IEC 14443A IP core
#		See: https://github.com/andrewparlane/iso_iec_14443a
#		Ideally I wouldn't duplicate this, but I setting up a generic build system
#		would take too much time.

# ----------------------------------------------------------------------------------
# VARIABLES
# ----------------------------------------------------------------------------------

REMOTE_SERVER 	= user@server
REMOTE_PATH		= ~/desired/destination

# Directories
ROOT_DIR		= ../../..

# relative to ROOT_DIR
ISO_IEC_14443A_ROOT_DIR	= hdl/components/iso_iec_14443a
ISO_IEC_14443A_RTL_DIR	= $(ISO_IEC_14443A_ROOT_DIR)/rtl
ISO_IEC_14443A_BFM_DIR	= $(ISO_IEC_14443A_ROOT_DIR)/verification/bfms

SRC_DIR					= hdl/rtl
VERIFICATION_DIR		= hdl/verification
BFM_SRC_DIR				= $(VERIFICATION_DIR)/bfms
TB_SRC_DIR				= $(VERIFICATION_DIR)/tb
VCS_DIR					= $(VERIFICATION_DIR)/vcs

# src files
ISO_IEC_14443A_SYNTH_SRCS = $(wildcard $(ROOT_DIR)/$(ISO_IEC_14443A_RTL_DIR)/pkg/*.sv) 			\
							$(wildcard $(ROOT_DIR)/$(ISO_IEC_14443A_RTL_DIR)/interfaces/*.sv) 	\
							$(wildcard $(ROOT_DIR)/$(ISO_IEC_14443A_RTL_DIR)/iso14443_2a/*.sv) 	\
							$(wildcard $(ROOT_DIR)/$(ISO_IEC_14443A_RTL_DIR)/iso14443_3a/*.sv) 	\
							$(wildcard $(ROOT_DIR)/$(ISO_IEC_14443A_RTL_DIR)/iso14443_4a/*.sv) 	\
							$(wildcard $(ROOT_DIR)/$(ISO_IEC_14443A_RTL_DIR)/*.sv)

# TODO: write a script to find all files and put them in the correct order
ISO_IEC_14443A_BFM_SRCS =	$(wildcard $(ROOT_DIR)/$(ISO_IEC_14443A_BFM_DIR)/interfaces/*.sv) 								\
							$(ROOT_DIR)/$(ISO_IEC_14443A_BFM_DIR)/helper/wrapper.sv											\
							$(ROOT_DIR)/$(ISO_IEC_14443A_BFM_DIR)/helper/uid.sv												\
							$(ROOT_DIR)/$(ISO_IEC_14443A_BFM_DIR)/helper/std_block_address.sv								\
							$(ROOT_DIR)/$(ISO_IEC_14443A_BFM_DIR)/helper/target.sv											\
							$(ROOT_DIR)/$(ISO_IEC_14443A_BFM_DIR)/transactions/transaction.sv								\
							$(ROOT_DIR)/$(ISO_IEC_14443A_BFM_DIR)/transactions/queue_transaction.sv							\
							$(ROOT_DIR)/$(ISO_IEC_14443A_BFM_DIR)/transactions/rx_bit_transaction.sv						\
							$(ROOT_DIR)/$(ISO_IEC_14443A_BFM_DIR)/transactions/rx_byte_transaction.sv						\
							$(ROOT_DIR)/$(ISO_IEC_14443A_BFM_DIR)/transactions/pcd_pause_n_transaction.sv					\
							$(ROOT_DIR)/$(ISO_IEC_14443A_BFM_DIR)/transactions/tx_bit_transaction.sv						\
							$(ROOT_DIR)/$(ISO_IEC_14443A_BFM_DIR)/transactions/tx_byte_transaction.sv						\
							$(ROOT_DIR)/$(ISO_IEC_14443A_BFM_DIR)/transaction_generators/transaction_generator.sv			\
							$(ROOT_DIR)/$(ISO_IEC_14443A_BFM_DIR)/transaction_converters/transaction_converter.sv			\
							$(ROOT_DIR)/$(ISO_IEC_14443A_BFM_DIR)/transaction_converters/rx_transaction_converter.sv		\
							$(ROOT_DIR)/$(ISO_IEC_14443A_BFM_DIR)/transaction_converters/tx_transaction_converter.sv		\
							$(ROOT_DIR)/$(ISO_IEC_14443A_BFM_DIR)/sequences/sequence.sv										\
							$(ROOT_DIR)/$(ISO_IEC_14443A_BFM_DIR)/sequences/specific_target_sequence.sv						\
							$(ROOT_DIR)/$(ISO_IEC_14443A_BFM_DIR)/sequences/comms_tests_sequence.sv							\
							$(ROOT_DIR)/$(ISO_IEC_14443A_BFM_DIR)/drivers/driver.sv 										\
							$(ROOT_DIR)/$(ISO_IEC_14443A_BFM_DIR)/drivers/rx_iface_driver.sv 								\
							$(ROOT_DIR)/$(ISO_IEC_14443A_BFM_DIR)/drivers/rx_bit_iface_driver.sv							\
							$(ROOT_DIR)/$(ISO_IEC_14443A_BFM_DIR)/drivers/rx_byte_iface_driver.sv							\
							$(ROOT_DIR)/$(ISO_IEC_14443A_BFM_DIR)/drivers/tx_iface_source_driver.sv 						\
							$(ROOT_DIR)/$(ISO_IEC_14443A_BFM_DIR)/drivers/tx_bit_iface_source_driver.sv						\
							$(ROOT_DIR)/$(ISO_IEC_14443A_BFM_DIR)/drivers/tx_byte_iface_source_driver.sv					\
							$(ROOT_DIR)/$(ISO_IEC_14443A_BFM_DIR)/drivers/tx_iface_sink_driver.sv							\
							$(ROOT_DIR)/$(ISO_IEC_14443A_BFM_DIR)/drivers/pcd_pause_n_driver.sv								\
							$(ROOT_DIR)/$(ISO_IEC_14443A_BFM_DIR)/monitors/monitor.sv 										\
							$(ROOT_DIR)/$(ISO_IEC_14443A_BFM_DIR)/monitors/rx_iface_monitor.sv 								\
							$(ROOT_DIR)/$(ISO_IEC_14443A_BFM_DIR)/monitors/rx_bit_iface_monitor.sv							\
							$(ROOT_DIR)/$(ISO_IEC_14443A_BFM_DIR)/monitors/rx_byte_iface_monitor.sv							\
							$(ROOT_DIR)/$(ISO_IEC_14443A_BFM_DIR)/monitors/tx_iface_monitor.sv 								\
							$(ROOT_DIR)/$(ISO_IEC_14443A_BFM_DIR)/monitors/tx_bit_iface_monitor.sv							\
							$(ROOT_DIR)/$(ISO_IEC_14443A_BFM_DIR)/monitors/tx_byte_iface_monitor.sv							\
							$(ROOT_DIR)/$(ISO_IEC_14443A_BFM_DIR)/monitors/load_modulator_monitor.sv						\
							$(wildcard $(ROOT_DIR)/$(ISO_IEC_14443A_BFM_DIR)/analogue/*.sv)

SYNTH_SRCS = 				$(wildcard $(ROOT_DIR)/$(SRC_DIR)/*.sv)

							$(wildcard $(ROOT_DIR)/$(BFM_SRC_DIR)/analogue/*.sv)	\
							$(wildcard $(ROOT_DIR)/$(TB_SRC_DIR)/*.sv)

SRCS = 	$(ISO_IEC_14443A_SYNTH_SRCS) 	\
		$(SYNTH_SRCS)					\
		$(ISO_IEC_14443A_BFM_SRCS)		\
		$(TB_SRCS)

# testbenches

# This is used to generate the rules
TBS		= radiation_sensor_top_tb

# This is for TBs that need to do something custom, it's only used for list_tbs and all_tbs
CUSTOM_TBS	=

# ----------------------------------------------------------------------------------
# colourization
# ----------------------------------------------------------------------------------
# this consists of the following colour definitions
# and three macros used to parse the stderr and stdout of commands
# ----------------------------------------------------------------------------------

# colours
COLOUR_NONE		= \x1b[0m
COLOUR_RED		= \x1b[31;01m
COLOUR_BLUE		= \x1b[34;01m
COLOUR_GREEN 	= \x1b[32;01m
COLOUR_ORANGE	= \x1b[33;01m

# Macro to generate SED command to COLOURISE output:
#	Takes two arguments:
#		1) pattern to match
#		2) colour to highlight (only highlights the matched pattern, not the whole line)
GENERATE_COLOURISE_SED = -e $$'s/$(1)/$(2)\\1$(COLOUR_NONE)/I'

# SED command to do all colour substitutions
# 	This is just a list of sed expressions generated using the GENERATE_COLOURISE_SED macro
# 	It adds the $(MORE_COLOURS) var at the end, which can be used in individual makefiles
# 	to add more colourization. IE. if you want to COLOURISE lines with Importing in them
# 	Additionally you can override COLOURISE_SED_ALL to replace all colourization options
COLOURISE_SED_ALL ?= sed -r $(call GENERATE_COLOURISE_SED,(^Error.*$$),$(COLOUR_RED)) 									\
							$(call GENERATE_COLOURISE_SED,(^.*(failed|Fatal).*$$),$(COLOUR_RED)) 						\
							$(call GENERATE_COLOURISE_SED,(^.* [1-9][0-9]* failures.*$$),$(COLOUR_RED))					\
							$(call GENERATE_COLOURISE_SED,(^.* 0 successes.*$$),$(COLOUR_BLUE))							\
							$(call GENERATE_COLOURISE_SED,(^(Warning|Lint).*$$),$(COLOUR_ORANGE)) 						\
							$(call GENERATE_COLOURISE_SED,(^Note.*$$),$(COLOUR_BLUE)) 									\
							$(call GENERATE_COLOURISE_SED,(^.* [1-9][0-9]* successes, 0 failures.*$$),$(COLOUR_GREEN))

# Actual macro that COLOURISEs
#	Takes one argument:
#		1) The command to run.
#	We run in () so that the set -o pipefail doesn't persist past this call
#	set -o pipefail makes sure our exit code is correct (ie. if vcom returns error 1, we want the entire command to return error 1)
#	We pass stderr into the above COLOURISE_SED_ALL sed command, and then redirect it back to stderr
#	Finally we pipe it in to the COLOURISE_SED_ALL again, which makes it also run on stdout
COLOURISE = (set -o pipefail; $(1) | $(COLOURISE_SED_ALL))

# ----------------------------------------------------------------------------------
# VCS macros
# ----------------------------------------------------------------------------------

# arguments to the various commands
VLOGAN_ARGS	= -full64 +lint=all +warn=all -sverilog
VCS_ARGS	= -full64 +lint=all,noSVA-DIU,noSVA-LDA,noSVA-ADORM,noSVA-NSVU,noSVA-AECASR +warn=all -assert enable_diag -debug_acc+all -ntb_opts check=all
SIMV_ARGS	= -assert global_finish_maxfail=10 -cm assert -ucli

ifdef RANDOM_SEED
	SIMV_ARGS 		+= +ntb_random_seed=$(RANDOM_SEED)
else
	SIMV_ARGS 		+= +ntb_random_seed_automatic
endif

ifdef GUI
# if we want to use the GUI then add the -gui argument to SIMV_ARGS
# and enforce interactive mode (don't run the do.tcl and don't colourise)
	SIMV_ARGS 		+= -gui
	INTERACTIVE 	= 1
endif

# the work/AN.DB dir has it's timestamp compared to the .sv files to see if we need to
# reanalyse. There may be a way to only reanalyse the necesarry files but it doesn't seem
# necesarry since it's really quick as is.
WORK_DIR	= $(VCS_DIR)/work
AN_DB_DIR	= $(ROOT_DIR)/$(WORK_DIR)/AN.DB

# The ANALYSE macro runs vlogan to analyse all the source files
# Takes zero arguments
define ANALYSE
	$(call COLOURISE, vlogan $(VLOGAN_ARGS) $(SRCS))
endef

# The ELABORATE macro runs vcs to build the simv binary for the particular testbench
# Takes one argument:
#		1) The testbench module to run
#		2) Name of the output simv file
#		3) List of additional VCS arguments, e.g. "-pvalue+WIDTH=32 -pvalue+FOO=BAR" without the quotes
define ELABORATE
	$(eval TB_NAME  = $(call strip, $(1)))
	$(eval OUT_NAME = $(call strip, $(2)))
	echo -e "$(COLOUR_BLUE)elaborating $(TB_NAME) with arguments $(3) as $(OUT_NAME)$(COLOUR_NONE)\n"
	$(call COLOURISE, vcs $(VCS_ARGS) work.$(TB_NAME) $(3) -o $(OUT_NAME))
endef

# The RUN_SIM macro runs the simv binary produced by vcs.
# Takes one argument:
#		1) The testbench module name to run
# Has different behaviour depending on if we set INTERACTIVE=1 or not
# In interactive mode we don't colourise the output.
# In batch mode we run the do.tcl script
ifndef INTERACTIVE
# batch mode
define RUN_SIM
	$(eval TB_NAME = $(call strip, $(1)))
	echo -e "$(COLOUR_BLUE)Simulating $(TB_NAME)$(COLOUR_NONE)\n"
	$(call COLOURISE, ./$(TB_NAME)_simv $(SIMV_ARGS) -do do.tcl)
endef
else
# interactive mode
define RUN_SIM
	$(eval TB_NAME = $(call strip, $(1)))
	echo -e "$(COLOUR_BLUE)Simulating $(TB_NAME)$(COLOUR_NONE)\n"
	./$(TB_NAME)_simv $(SIMV_ARGS)
endef
endif

# ----------------------------------------------------------------------------------
# Misc macros
# ----------------------------------------------------------------------------------

# Genaretes a random number between min and max inclusive
# Takes two arguments
#	1) min
#	2) max
define RANDOM
	$(shell echo $$(( ( RANDOM % ( $(2) - $(1) + 1 ) ) + $(1) )))
endef

# ----------------------------------------------------------------------------------
# Rules / targets
# ----------------------------------------------------------------------------------

# default rule is to analyse and elaborate all files / testbenches
# elaborating all testbenches is not necesarry if you only want to run one simulation
all: analyse elaborate
.PHONY: all

# Analyse files only if any of the sources have changed more recently than the AN.DB folder
$(AN_DB_DIR): $(SRCS)
	-@rm -rf $(AN_DB_DIR)
	@echo -e "$(COLOUR_BLUE)Analysing because of changes in: $? $(COLOUR_NONE)\n"
	@$(call ANALYSE)

# Elaborate rules, of the format sequence_decode_tb_simv:
$(patsubst %,%_simv,$(TBS)): $(AN_DB_DIR)
	@$(call ELABORATE, $(subst _simv,,$@), $@)

# Simulation rules
%: %_simv
	@$(call RUN_SIM, $@)

# PHONY rules
analyse: $(AN_DB_DIR)
elaborate: $(patsubst %,%_simv,$(TBS))

# Rule to always force making a target
.FORCE:
.PHONY: .FORCE

# output TBS each on it's own line
list_tbs:
	@echo $(TBS) $(CUSTOM_TBS) | sed -E 's/[ \t]+/\n/g'

# execute all TBs, pipe the result of this into a log file for easier viewing
all_tbs: $(TBS) $(CUSTOM_TBS)

clean:
	-@rm ???*_simv
	-@rm -rf ???*_simv.daidir/
	-@rm -rf $(ROOT_DIR)/$(WORK_DIR)
	-@rm -rf csrc/

.PHONY: analyse elaborate list_tbs all_tbs clean

# ----------------------------------------------------------------------------------
# Rules for working remotely
# ----------------------------------------------------------------------------------

# We push (overwriting all files) the src files, testbenches and the VCS dir.
# We delete any file on the server that doesn't exist locally
# except for: work/ csrc/ and *_simv*
# Which means we don't need to rebuild everything each time
push_to_remote:
	cd $(ROOT_DIR) && rsync -rRv --delete 													\
		--exclude $(VCS_DIR)/work/ --exclude $(VCS_DIR)/csrc/ --exclude $(VCS_DIR)/*_simv* 	\
		$(SRC_DIR) $(TB_SRC_DIR) $(BFM_SRC_DIR) $(VCS_DIR) 												\
		$(ISO_IEC_14443A_RTL_DIR) $(ISO_IEC_14443A_BFM_DIR)									\
		$(REMOTE_SERVER):$(REMOTE_PATH)

# ssh to the remote server and cd to the VCS dir
# we use -Y so we can launch graphical apps
connect_to_remote:
	ssh -Yt $(REMOTE_SERVER) "cd $(REMOTE_PATH)/$(VCS_DIR); bash"
