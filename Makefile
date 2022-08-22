ROOT_DIR  = $(PWD)
VIVADO_VER  := 2021.2
VIVADO_PATH := /opt/Xilinx/Vivado/$(VIVADO_VER)/bin/
VIVADO_XLNX := $(VIVADO_PATH)/vivado
VIVADO_OPT  := -mode batch -nolog -nojournal -notrace -source
FPGA_BOARD  ?= u55c


DEVICE = uart

all: uart

#Generate the Ethernet IP

$(DEVICE): 
	@(echo "Generate CVA6 UART IP for the Alveo $(FPGA_BOARD)")
	$(VIVADO_XLNX) $(VIVADO_OPT)  ./tcl/gen_project.tcl -tclargs $(FPGA_BOARD)
	@(echo "IP created under folder $@")


clean:
	git clean -f
	@(cd ip; find . -type f ! -name "*.tcl" -exec rm -r {} \;)
	rm -rf xgui project uart



