tool_sim:
	mkdir -p $(BUILD)
	cd $(BUILD) && \
	xrun $(XRUN_FLAGS) \
	-top $(TOP) \
	$(addprefix -f ,$(FILELIST_SV)) \
	$(addprefix -f ,$(FILELIST_VHDL))