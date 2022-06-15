# Copyright 2022 Barcelona Supercomputing Center-Centro Nacional de Supercomputación

# Licensed under the Solderpad Hardware License v 2.1 (the "License");
# you may not use this file except in compliance with the License, or, at your option, the Apache License version 2.0.
# You may obtain a copy of the License at
# 
#     http://www.solderpad.org/licenses/SHL-2.1
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Author: Alexander Kropotov, BSC-CNS
# Date: 22.02.2022
# Description: 



# script to run bare-metal application via JTAG
# XSCT reference: https://www.xilinx.com/html_docs/xilinx2020_1/vitis_doc/upu1569395223804.html
# XSCT uses Xvfb and thus "ssh -X" should be used for remote run

# ----- Connecting to the board via JTAG, initializing target
# Remote connection case (on remote host with board connected "hw_server -s tcp::3121" should be run with port 3121 enabled in firewall)
# connect -url tcp:192.168.0.14:3121
# Local connection case
connect -url tcp:localhost:3121
# connect
connect -list

# ---- Reading FPGA state
targets
# targets 1
# targets
fpga -boot-status
fpga -config-status
fpga -state

# ---- Programming FPGA
fpga -file ./project/ethernet_system_wrapper.bit
fpga -boot-status
fpga -config-status
fpga -state

# ---- Setting CPU as debug target
targets
# targets 3
targets -set -nocase -filter {name =~ "*MicroBlaze*0*"}
targets
# loadhw -hw ./project/ethernet_system_wrapper.xsa
state
rst -system
after 3000
state

# ---- Loading app
if {[info exists ::env(ELF_TO_RUN)]} {
  dow    $::env(ELF_TO_RUN)
  verify $::env(ELF_TO_RUN)
} else {
  dow    ./xsct_ws/eth_test/Release/eth_test.elf
  verify ./xsct_ws/eth_test/Release/eth_test.elf
}
state
rst
state

# ---- Opening Stdin/Stdout
put ""
put "-----------------------"
put "Please run manually: jtagterminal, and wait for the launched terminal window..."
# jtagterminal -start
# readjtaguart -start

# ---- Running app
put "After that run manually the app: con"
put "Other further actions: state, stop, rst"
put "-----------------------"
put ""
# state
# rst
# state
# con
# state

# ---- Closing Stdin/Stdout
# jtagterminal -stop
# readjtaguart -stop

# ---- Disconnecting
# disconnect
# exit
