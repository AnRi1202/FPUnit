SIM ?= xrun
TARGET ?= v2_bf16_full
TOP ?= tb_fpadd_bf16x2
# TOP: 
#   - SV: tb_fpadd_bf16x2 | tb_fpadd_fp32 | tb_fpmult_bf16x2 | tb_fpmult_fp32
#   - VHDL: tb_fpadd_flopoco | tb_fpmult_flopoco | tb_fpdiv_flopoco | tb_fpsqrt_flopoco
export ROOT := $(abspath ..)
SIM_DIR :=$(abspath .)
BUILD := $(SIM_DIR)/build/$(SIM)/$(TARGET)
FILELIST_SV := $(SIM_DIR)/filelists/common_sv.f
FILELIST_SV += $(wildcard $(SIM_DIR)/filelists/$(TARGET)_sv.f)
FILELIST_VHDL := $(SIM_DIR)/filelists/common_vhdl.f
FILELIST_VHDL += $(wildcard $(SIM_DIR)/filelists/$(TARGET)_vhdl.f)

# --- DUT selection define ---
DEFINES :=

VALID_TARGET := 0

ifeq ($(TARGET),v0_area_opt)
  DEFINES += +define+V0_AREA_OPT
  VALID_TARGET := 1
endif

ifeq ($(TARGET),v1_area_opt)
  DEFINES += +define+V1_AREA_OPT
  VALID_TARGET := 1
endif

ifeq ($(TARGET),v1_1_fp32_add)
  DEFINES += +define+V1_1_FP32_ADD
  VALID_TARGET := 1
endif

ifeq ($(TARGET),v1_2_fp32_mult)
  DEFINES += +define+V1_2_FP32_MULT
  VALID_TARGET := 1
endif


ifeq ($(TARGET),v2_bf16_full)
  DEFINES += +define+V2_BF16_FULL
  VALID_TARGET := 1
endif


ifeq ($(TARGET),v2_1_bf16_add)
  DEFINES += +define+V2_1_BF16_ADD
  VALID_TARGET := 1
endif

ifeq ($(TARGET),v2_2_bf16_mult)
  DEFINES += +define+V2_2_BF16_MULT
  VALID_TARGET := 1
endif

ifeq ($(TARGET),v3_addmul_only)
  DEFINES += +define+V3_ADDMUL_ONLY
  VALID_TARGET := 1
endif

ifeq ($(VALID_TARGET),0)
  $(error Invalid TARGET: $(TARGET))
endif


# flags
XRUN_FLAGS := -v200x -64bit -sv -access +rwc -input "@run 150112ns; exit"
MSIM_VLOG_FLAGS := -64 -sv -mixedsvvh
MSIM_VCOM_FLAGS := -64 -93
MSIM_VSIM_FLAGS := -64 -c -t 1ps -do "run 150112ns; quit"



include $(SIM_DIR)/scripts/$(SIM).mk

.DEFAULT_GOAL := sim

# Link all input files to the build directory
.PHONY: sim clean prepare_input check_all check

prepare_input:
	mkdir -p $(BUILD)
	ln -sf $(SIM_DIR)/inputs/*.input $(BUILD)/

sim: prepare_input
	$(MAKE) tool_sim

## check sim itself
SIMS := xrun msim
TOPS_SV := tb_fpadd_bf16x2 tb_fpadd_fp32 tb_fpmult_bf16x2 tb_fpmult_fp32
TOPS_VHDL := tb_fpadd_flopoco tb_fpmult_flopoco tb_fpdiv_flopoco tb_fpsqrt_flopoco
TOPS := $(TOPS_SV) $(TOPS_VHDL)

check_all:
	@for sim in $(SIMS); do \
		for top in $(TOPS); do \
			echo "----------------------------------------------------------------"; \
			echo " Running SIM=$$sim TOP=$$top"; \
			echo "----------------------------------------------------------------"; \
			$(MAKE) sim SIM=$$sim TOP=$$top || exit 1; \
		done; \
	done
	@echo "----------------------------------------------------------------"
	@echo " ALL TESTS COMPLETED SUCCESSFULLY"
	@echo "----------------------------------------------------------------"

