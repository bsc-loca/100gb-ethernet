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

# Setting board number as zero (for single board at MEEP server) and redefining it if we work at FPGA cluster
set board_num 0
if { $::argc > 0 } {
  set board_num [lindex $argv 0]
  put "Using FPGA Board $board_num"
} else {
  put "Board number is not provided, using by default FPGA Board $board_num, meaning single one at the workstation."
}

# ----- Connecting to the board via JTAG, initializing target
# Remote connection case (on remote host with board connected "hw_server -s tcp::3121" should be run with port 3121 enabled in firewall)
# connect -url tcp:192.168.0.14:3121
# Local connection case
connect -url tcp:localhost:3121
# connect
connect -list

# ---- Reading FPGA state
targets
# Here we set a particular target as active. If the FPGA is a single one in the JTAG chain then above command is enough.
# In FPGA cluster node we have 8 FPGA cards with, so automation is applied by processing file '/etc/motd' and
# TCL list got from file command: targets -target-properties

if { $board_num != 0} {
  set board_table [open "/etc/motd" "r"]
	while {[gets $board_table line] >= 0} {
    if [string match "*fpgan??f0$board_num*XFL*" $line] {
      set board_serial [lindex $line 5]
      put "Board serial: $board_serial"
      break
    }
  }
  close $board_table
  if {![info exists board_serial]} {
    put "No serial is found for board $board_num (should be in range 0...8), exiting..."
    exit
  }

  set target_list [targets -target-properties]
  foreach target_dict $target_list {
    if {[dict get $target_dict name ] == "xcu280_u55c" &&
        [string match "*$board_serial*" $target_dict]} {
      set target_id [dict get $target_dict target_id]
      targets $target_id
      put "Activating JTAG target $target_id as xcu280_u55c FPGA for its programming..."
    }
  }
}
fpga -boot-status
fpga -config-status
fpga -state

# ---- Programming FPGA
set bitstream "./project/ethernet_system.runs/impl_1/ethernet_system_wrapper.bit"
# set bitstream ./project/ethernet_system_wrapper.bit # extracted from XSA bitstream
put "Programming FPGA with bitstream $bitstream"
fpga -file $bitstream
fpga -boot-status
fpga -config-status
fpga -state

# ---- Setting CPU as debug target
after 3000
targets
if { $board_num == 0} {
  targets -set -nocase -filter {name =~ "*MicroBlaze*0*"}
} else {
  set target_list [targets -target-properties]
  foreach target_dict $target_list {
    if {[dict get $target_dict name ] == "MicroBlaze #0" &&
        [string match "*$board_serial*" $target_dict]} {
      set target_id [dict get $target_dict target_id]
      targets $target_id
      put "Activating JTAG target $target_id as MicroBlaze CPU for its booting..."
    }
  }
}

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
