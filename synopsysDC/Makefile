SCRIPT ?= run_ppa.tcl
LOG ?= $(basename $(SCRIPT)).log
TASK ?= 0
TOP ?= none
VER ?= none
FILELIST ?= none
export ROOT := $(abspath ..)

run:
	@if [ -z "$(TOP)" ]; then echo "Error: TOP is not set. Usage: make run VER=<foldername> TOP=<module_name>"; exit 1; fi
	@if [ -z "$(VER)" ]; then echo "Error: VER is not set. Usage: make run VER=<foldername> TOP=<module_name>"; exit 1; fi
	rm -rf WORK
	mkdir WORK
	dc_shell-xg-t -x "set TASK $(TASK); set VER $(VER); set ROOT $(ROOT); set TOP $(TOP)" -f $(SCRIPT) -o $(LOG)

clean:
	rm -rf output/* *.pvl *.log *.svf *.syn *.sdc alib-52 command.log default.svf *.mr
	mkdir -p output

