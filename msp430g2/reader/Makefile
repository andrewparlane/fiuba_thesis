TARGET 				:= reader
DEVICE				:= MSP430G2553

GCC_DIR     		?= C:/ti/msp430-gcc/
GCC_MSP_INC_DIR 	?= $(GCC_DIR)/include
LDDIR       		:= $(GCC_MSP_INC_DIR)/$(DEVICE)
RM          		:= rm -rf

######################################
GCC_BIN_DIR     ?= $(GCC_DIR)/bin
GCC_INC_DIR     ?= $(GCC_DIR)/msp430-elf/include
######################################
CC              := $(GCC_BIN_DIR)/msp430-elf-gcc
GDB			    := $(GCC_BIN_DIR)/msp430-elf-gdb
OBJCOPY			:= $(GCC_BIN_DIR)/msp430-elf-objcopy
MSPFLASHER		:= C:/ti/MSPFlasher_1.3.20/MSP430Flasher
######################################
CFLAGS          := -Os -D__$(DEVICE)__ -mmcu=$(DEVICE) -g -ffunction-sections -fdata-sections -Wall -MMD -fdiagnostics-color=always
LDFLAGS         := -T $(LDDIR).ld -L $(GCC_MSP_INC_DIR) -mmcu=$(DEVICE) -g -Wl,--gc-sections
INCLUDES        := -I $(GCC_MSP_INC_DIR) -I $(GCC_INC_DIR)
######################################

######################################

default: $(TARGET).hex
all: default

SOURCEDIR	= src
BUILDDIR	= build
SRC			= $(wildcard $(SOURCEDIR)/*.c)
OBJECTS 	= $(patsubst $(SOURCEDIR)/%.c,$(BUILDDIR)/%.o,$(SRC))

# Include dependencies build by the -MMD in CFLAGS
-include $(OBJECTS:.o=.d)

$(OBJECTS): $(BUILDDIR)/%.o : $(SOURCEDIR)/%.c
	@echo ============================================
	@echo Compiling $@
	mkdir -p $(BUILDDIR)
	$(CC) $(INCLUDES) $(CFLAGS) -c $< -o $@

$(TARGET).out: $(OBJECTS)
	@echo ============================================
	@echo Linking objects and generating output binary
	$(CC) $(LDFLAGS) $^ -o $(TARGET).out

$(TARGET).hex: $(TARGET).out
	$(OBJCOPY) -O ihex $(TARGET).out $(TARGET).hex

program: $(TARGET).hex
	$(MSPFLASHER) -w $(TARGET).hex -z [VCC]

clean:
	-$(RM) -rf $(BUILDDIR)
	-$(RM) -f $(TARGET).out
	-$(RM) -f $(TARGET).hex

.PHONY: default all clean program