# The script to cross-compile Linux test Ethernet application for 100GbE IP being integrated in different SOC types.

# The script should be run in this folder preferably with 100GbE repo being inside higher level SOC (as submodule or bender repo).
# Thus the script tries to define automatically the address map in particular SOC searching for OpenPiton SOC `devices.xml` file
# and generating `xparams_soc.h` header. If devices.xml file is not found, the script will use the default `xparams_soc.h` file.
# Please check if the default address map is suitable for your SOC.
# The script also tries to define automatically the type of memory connection to Eth DMA engine (internal SRAM, external non-cached DRAM or cached DRAM).
# The result should be checked in printed messaging, and if needed corrected manually by uncommenting corresponding line in the script below.

# The script should be run with activated Xilinx environment (last updated for Vitis/Vivado-2025.1) and RISCV toolchain with enabled cross-compilation for Linux.
# The script generates `eth_test` executable file in the current folder.

rm ./eth_test

echo ""
# extraction of Eth subsystem hw definitions from Vivado BD TCL scripts
# vivado -mode batch -nolog -nojournal -notrace -source ./xparams_eth.tcl
tclsh ./xparams_eth.tcl
# extraction of SOC definitions from devices_xxx.xml for OpenPiton based designs (ACME, Cincoranch)
tclsh ./xparams_soc.tcl

# Taking some DMA driver sources to edit and for reference
cp $XILINX_VITIS/data/embeddedsw/XilinxProcessorIPLib/drivers/axidma_v9_19/src/xaxidma_g.c ./
cp $XILINX_VITIS/data/embeddedsw/XilinxProcessorIPLib/drivers/axidma_v9_19/src/xaxidma_bdring.c ../cpp/syst_hw/
sed -i 's|#define XPAR_AXIDMA_0_INCLUDE_SG|//#define XPAR_AXIDMA_0_INCLUDE_SG|g' ./xaxidma_g.c

echo ""
echo "----- Defining automatically a type of Eth/Aurora DMA memory in MEEP_SHELL/OpenPiton environment:"
if grep -s "AURORA,yes" ../../../../accelerator/meep_shell/accelerator_def.csv
then
  if grep -s "AURORA,yes.*sram" ../../../../accelerator/meep_shell/accelerator_def.csv
  then
    echo "----- Aurora DMA memory is SRAM-based."
    DEF_DMA_MEM_HBM="-DAURORA"
  else
    echo "----- Aurora DMA memory is DRAM-based."
    DEF_DMA_MEM_HBM="-DAURORA -DDMA_MEM_HBM"
  fi
elif grep -s "ETHERNET,yes" ../../../../accelerator/meep_shell/accelerator_def.csv ||
     grep -s "set g_dma_mem" ../../../../../../../../../tools/src/proto/vivado/gen_project.tcl
then
  if grep -s "ETHERNET,yes.*sram" ../../../../accelerator/meep_shell/accelerator_def.csv ||
     grep -s "set g_dma_mem.*sram" ../../../../../../../../../tools/src/proto/vivado/gen_project.tcl
  then
    echo "----- Eth DMA memory is SRAM-based."
    DEF_DMA_MEM_HBM=""
  elif grep -s "ETHERNET,yes.*AXI4" ../../../../accelerator/meep_shell/accelerator_def.csv ||
       grep -s "set g_dma_mem.*AXI4" ../../../../../../../../../tools/src/proto/vivado/gen_project.tcl
  then
    echo "----- Eth DMA memory is DRAM-based with cache-coherent connection."
    DEF_DMA_MEM_HBM="-DDMA_MEM_HBM -DSG_MEM_CACHED -DTXRX_MEM_CACHED -DDMA_MEM_COHER"
  else
    echo "----- Eth DMA memory is DRAM-based."
    DEF_DMA_MEM_HBM="-DDMA_MEM_HBM"
  fi
elif grep -s "set g_dma_mem.*sram" ../../tcl/environment.tcl
then
  echo "----- Eth DMA memory is SRAM-based by default in Eth IP."
  DEF_DMA_MEM_HBM=""
else
  echo "----- Eth DMA memory is DRAM-based by default in Eth IP."
  DEF_DMA_MEM_HBM="-DDMA_MEM_HBM"
fi

#Manual setting of Eth DMA connection type: uncomment one of the following lines if automatic detection above is not successful or needs correction.
#  DEF_DMA_MEM_HBM="-DDMA_MEM_HBM"
# Eth DMA utilizes cached region of DRAM through direct connection (requires explicit cache flush/invalidate, suitable for OP Ariane-based design)
#  DEF_DMA_MEM_HBM="-DDMA_MEM_HBM -DSG_MEM_CACHED -DTXRX_MEM_CACHED"
# Eth DMA utilizes cached region of DRAM through cache-coherent connection (supported in Cincoranch architechure)
#  DEF_DMA_MEM_HBM="-DDMA_MEM_HBM -DSG_MEM_CACHED -DTXRX_MEM_CACHED -DDMA_MEM_COHER"

echo "----- Eth DMA mem define line: $DEF_DMA_MEM_HBM"
echo ""

# -DDEBUG for enabling Xilinx debug output
riscv64-unknown-linux-gnu-gcc -Wall -Og -D__aarch64__ $DEF_DMA_MEM_HBM -o ./eth_test \
                              -I./ \
                              -I../cpp/syst_hw \
                              -I$XILINX_VITIS/data/embeddedsw/lib/sw_apps/asufw/misc \
                              -I$XILINX_VITIS/data/embeddedsw/lib/bsp/standalone_v9_3/src/common \
                              -I$XILINX_VITIS/data/embeddedsw/lib/bsp/standalone_v9_3/src/arm/cortexa9 \
                              -I$XILINX_VITIS/data/embeddedsw/lib/bsp/standalone_v9_3/src/arm/common/gcc \
                              -I$XILINX_VITIS/data/embeddedsw/XilinxProcessorIPLib/drivers/tmrctr_v4_13/src \
                              -I$XILINX_VITIS/data/embeddedsw/XilinxProcessorIPLib/drivers/axidma_v9_19/src \
                              -I$XILINX_VITIS/data/embeddedsw/XilinxProcessorIPLib/drivers/gpio_v4_12/src \
                              -I$XILINX_VITIS/data/embeddedsw/XilinxProcessorIPLib/drivers/axis_switch_v1_7/src \
                                $XILINX_VITIS/data/embeddedsw/lib/bsp/standalone_v9_3/src/common/xil_assert.c \
                                $XILINX_VITIS/data/embeddedsw/XilinxProcessorIPLib/drivers/tmrctr_v4_13/src/xtmrctr.c \
                                $XILINX_VITIS/data/embeddedsw/XilinxProcessorIPLib/drivers/tmrctr_v4_13/src/xtmrctr_l.c \
                                $XILINX_VITIS/data/embeddedsw/XilinxProcessorIPLib/drivers/tmrctr_v4_13/src/xtmrctr_sinit.c \
                                $XILINX_VITIS/data/embeddedsw/XilinxProcessorIPLib/drivers/tmrctr_v4_13/src/xtmrctr_selftest.c \
                                $XILINX_VITIS/data/embeddedsw/XilinxProcessorIPLib/drivers/tmrctr_v4_13/src/xtmrctr_g.c \
                                $XILINX_VITIS/data/embeddedsw/XilinxProcessorIPLib/drivers/axidma_v9_19/src/xaxidma.c \
                                $XILINX_VITIS/data/embeddedsw/XilinxProcessorIPLib/drivers/axidma_v9_19/src/xaxidma_bd.c \
                                $XILINX_VITIS/data/embeddedsw/XilinxProcessorIPLib/drivers/axidma_v9_19/src/xaxidma_sinit.c \
                                $XILINX_VITIS/data/embeddedsw/XilinxProcessorIPLib/drivers/axidma_v9_19/src/xaxidma_selftest.c \
                                ./xaxidma_g.c \
                                ../cpp/syst_hw/xaxidma_bdring.cpp \
                                ../cpp/syst_hw/EthSyst.cpp \
                                ../cpp/app/ping_test.cpp \
                                ../cpp/app/eth_test.cpp
