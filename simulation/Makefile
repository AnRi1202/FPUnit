TOOL ?= xrun
# TOOL xrun|msim
TARGET ?= shared-all
TOP ?= tb_fpadd_bf16x2
# TOP: tb_fpadd_bf16x2 | tb_fpadd_fp32 | tb_fpmult_bf16x2 | tb_fpmult_fp32

export ROOT := $(abspath ..)
SIM :=$(abspath .)
BUILD := $(SIM)/build/$(TOOL)/$(TARGET)
FILELIST_SV := $(SIM)/filelists/common_sv.f
FILELIST_SV += $(SIM)/filelists/$(TARGET)_sv.f
FILELIST_VHDL := $(SIM)/filelists/common_vhdl.f
FILELIST_VHDL += $(SIM)/filelists/$(TARGET)_vhdl.f

XRUN_FLAGS := -v200x -64bit -sv -access +rwc -input "@run 300500ns; exit"
MSIM_VLOG_FLAGS := -64 -sv
MSIM_VCOM_FLAGS := -64 -93
MSIM_VSIM_FLAGS := -64 -c -do "run -all; quit"

include $(SIM)/scripts/$(TOOL).mk

.PHONY: sim clean

sim: 
	$(MAKE) tool_sim


