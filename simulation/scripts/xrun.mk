tool_sim:
	mkdir -p $(BUILD)
	cd $(BUILD) && \
	xrun $(XRUN_FLAGS) \
	$(addprefix -f ,$(FILELIST))