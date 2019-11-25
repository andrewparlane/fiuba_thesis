# This is a helper Makefile for MSP430G2 projects
# It has a bunch of common defines / rules
# It should be included from the project specific makefile
# With the following variables defined:
#	TARGET 					- project name
# 	TOP_LEVEL_DIR			- relative path to the msp430g2/ folder
#	SOURCEDIR				- where the project specific source is
# 	BUILDDIR				- where to build the project
# 	NO_COMMON (optional)	- define when you don't want to use the source in common/

# All projects use the MSP430G2553 device for now.
DEVICE				= MSP430G2553

# The common code
COMMONDIR 			= $(TOP_LEVEL_DIR)/common
COMMONBUILDDIR		= $(BUILDDIR)/common
COMMONSRC   		= $(wildcard $(COMMONDIR)/*.c)
COMMONOBJECTS 		= $(patsubst $(COMMONDIR)/%.c,$(COMMONBUILDDIR)/%.o,$(COMMONSRC))

# The project specific code
SRC					= $(wildcard $(SOURCEDIR)/*.c)
OBJECTS 			= $(patsubst $(SOURCEDIR)/%.c,$(BUILDDIR)/%.o,$(SRC))

# All objects for the target
ifdef NO_COMMON
	TARGET_OBJECTS	= $(OBJECTS)
else
	TARGET_OBJECTS	= $(COMMONOBJECTS) $(OBJECTS)
endif

# Look in ../flasher_config for the correct COM port to use to program this device
DEV := $(strip $(shell cat ../flasher_config | grep -ve '^\#' | grep -i $(TARGET) | awk ' { print $$2; } '))
ifeq ($(DEV),)
$(warning "No entry found in flasher config for target: $(TARGET), programming any available board")
else
MSPFLASHER_FLAGS	:= -i $(DEV)
endif

# Flags for programming the target.
#	-w fw.hex		- write fw.hex to the target
#	-z [VCC]		- Run the device after programming is finished
MSPFLASHER_FLAGS	+= -w $(TARGET).hex -z [VCC]

# Toolchain dirs
GCC_DIR     	?= C:/ti/msp430-gcc
GCC_BIN_DIR     ?= $(GCC_DIR)/bin
GCC_INC_DIR     ?= $(GCC_DIR)/msp430-elf/include
GCC_MSP_INC_DIR ?= $(GCC_DIR)/include
LDDIR       	:= $(GCC_MSP_INC_DIR)/$(DEVICE)

# Tools
CC              := $(GCC_BIN_DIR)/msp430-elf-gcc
GDB			    := $(GCC_BIN_DIR)/msp430-elf-gdb
OBJCOPY			:= $(GCC_BIN_DIR)/msp430-elf-objcopy
MSPFLASHER		:= C:/ti/MSPFlasher_1.3.20/MSP430Flasher
RM          	:= rm

# Flags
INCLUDES        := -I $(GCC_MSP_INC_DIR) -I $(GCC_INC_DIR) -I $(COMMONDIR)
CFLAGS          := -Os -D__$(DEVICE)__ -mmcu=$(DEVICE) -g -ffunction-sections -fdata-sections -Wall -MMD -fdiagnostics-color=always $(INCLUDES)
LDFLAGS         := -T $(LDDIR).ld -L $(GCC_MSP_INC_DIR) -mmcu=$(DEVICE) -g -Wl,--gc-sections

# Include dependencies build by the -MMD in CFLAGS
-include $(COMMONOBJECTS:.o=.d)
-include $(OBJECTS:.o=.d)

# Build common sources
$(COMMONOBJECTS): $(COMMONBUILDDIR)/%.o : $(COMMONDIR)/%.c
	@echo ============================================
	@echo Compiling $<
	mkdir -p $(COMMONBUILDDIR)
	$(CC) $(CFLAGS) -c $< -o $@

# Build project specific sources
$(OBJECTS): $(BUILDDIR)/%.o : $(SOURCEDIR)/%.c
	@echo ============================================
	@echo Compiling $<
	mkdir -p $(BUILDDIR)
	$(CC) $(CFLAGS) -c $< -o $@

# Link
$(TARGET).out: $(TARGET_OBJECTS)
	@echo ============================================
	@echo Linking objects and generating output binary
	$(CC) $(LDFLAGS) $^ -o $(TARGET).out

# Create a .hex file
$(TARGET).hex: $(TARGET).out
	$(OBJCOPY) -O ihex $(TARGET).out $(TARGET).hex

# Program the target board
program: $(TARGET).hex
	$(MSPFLASHER) $(MSPFLASHER_FLAGS)

# cleanup
common_clean:
	-$(RM) -f $(COMMONBUILDDIR)/*.o
	-$(RM) -f $(COMMONBUILDDIR)/*.d

clean: common_clean
	-$(RM) -f $(BUILDDIR)/*.o
	-$(RM) -f $(BUILDDIR)/*.d
	-$(RM) -f $(TARGET).out
	-$(RM) -f $(TARGET).hex

.PHONY: program common_clean clean