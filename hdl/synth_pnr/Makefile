# ----------------------------------------------------------------------------------
#        File: Makefile
# Description: Makefile to sync sources with remote server
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

# This is copied from verification/vcs/Makefile
# But I'm only using it ATM for the remote commands:
# 	Make push_to_remote
# 	Make connect_to_remote

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

#	sync_with_remote:	syncs files with the remote server
# 	connect_to_remote:	ssh to the remote server and cd to the vcs dir

# ----------------------------------------------------------------------------------
# VARIABLES
# ----------------------------------------------------------------------------------

REMOTE_SERVER 	= user@server
REMOTE_PATH		= ~/desired/destination

# Directories
ROOT_DIR		= ../..

# relative to ROOT_DIR
ISO_IEC_14443A_ROOT_DIR	= hdl/components/iso_iec_14443A
ISO_IEC_14443A_RTL_DIR	= $(ISO_IEC_14443A_ROOT_DIR)/rtl

SRC_DIR					= hdl/rtl

SYNTH_PNR_DIR			= hdl/synth_pnr

# ----------------------------------------------------------------------------------
# Rules for working remotely
# ----------------------------------------------------------------------------------

# We push (overwriting all files) the src files and this synth_pnr dir
# We delete any file on the server that doesn't exist locally
# except for: **/work, **/logs, and custom_compiler_project/
# We also pull the logs so we always have the latest logs saved locally
sync_with_remote:
	-rm -rf synth/logs
	-rm -rf lib_prep/logs
	-scp -r $(REMOTE_SERVER):$(REMOTE_PATH)/$(SYNTH_PNR_DIR)/synth/logs/ synth/
	-scp -r $(REMOTE_SERVER):$(REMOTE_PATH)/$(SYNTH_PNR_DIR)/lib_prep/logs/ lib_prep/
	cd $(ROOT_DIR) && rsync -rRv --delete 						\
		--exclude $(SYNTH_PNR_DIR)/synth/work/					\
		--exclude $(SYNTH_PNR_DIR)/synth/logs/					\
		--exclude $(SYNTH_PNR_DIR)/lib_prep/work/				\
		--exclude $(SYNTH_PNR_DIR)/lib_prep/logs/				\
		--exclude $(SYNTH_PNR_DIR)/custom_compiler_project/		\
		$(SRC_DIR) $(ISO_IEC_14443A_RTL_DIR) $(SYNTH_PNR_DIR)	\
		$(REMOTE_SERVER):$(REMOTE_PATH)

# ssh to the remote server and cd to the VCS dir
# we use -Y so we can launch graphical apps
connect_to_remote:
	ssh -Yt $(REMOTE_SERVER) "cd $(REMOTE_PATH)/$(SYNTH_PNR_DIR); bash"

.PHONY: sync_with_remote connect_to_remote
