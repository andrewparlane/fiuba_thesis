# Project Makefile should define the following vars:
#	TARGET 			- project name
# 	TOP_LEVEL_DIR	- relative path to the msp430g2/ folder
#	SOURCEDIR		- where the project specific source is
# 	BUILDDIR		- where to build the project

# It should provide the default / all rules as desired
# and it should include $(TOP_LEVEL_DIR)/helper.mk where the magic happens

# It should be possible to customise this Makefile to do anything project specific

TARGET 				= card_emulator
TOP_LEVEL_DIR		= ..

SOURCEDIR			= src
BUILDDIR			= build

default: $(TARGET).hex
all: default

include ../helper.mk

.PHONY: default all
