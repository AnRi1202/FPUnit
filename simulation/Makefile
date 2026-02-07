TOOL ?= xrun
# TOOL xrun|msim
TARGET ?= shared-all

export ROOT := $(abspath ..)
SIM :=$(abspath .)
BUILD := $(SIM)/build/$(TOOL)/$(TARGET)
FILELIST := $(SIM)/filelists/common.f
FILELIST += $(SIM)/filelists/$(TARGET).f

XRUN_FLAGS := -v200x -64bit -sv -access +rwc -input "@run 300500ns; exit"

include $(SIM)/scripts/$(TOOL).mk

.PHONY: sim clean

sim: 
	$(MAKE) tool_sim


