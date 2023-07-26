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
# Here we may set a particular target to be active. If the FPGA is a single one in the JTAG chain thw above command is enough.
# In FPGA cluster node we have 8 FPGA cards with following distribution of order in JTAG chain (target id):
# (extension of the table in /etc/motd)
# +------------+---------+----------+-------+-------------+--------------------+--------+------------+-----------+-------------+
# | FPGA Card  | Chassis | PCIe Bus | USB   | lsusb       | UART USB in /dev/  | QSFP0  | QSFP1      | no uBlazes| with uBlazes|
# |            | Slot    |          | Port  |             |                    |        |            | target id | target id   |
# +------------+---------+----------+-------+-------------+--------------------+--------+------------+-----------+-------------+
# | fpganXXf01 | 3       | 34:00.0  | 1     | usb 1-6.4.4 | USB-UART-FPGACARD1 | Switch | fpganXXf02 | 6         |  21         |
# +------------+---------+----------+-------+-------------+--------------------+--------+------------+-----------+-------------+
# | fpganXXf02 | 4       | 33:00.0  | 2     | usb 1-6.4.3 | USB-UART-FPGACARD2 | Switch | fpganXXf01 | 1         |  1          |
# +------------+---------+----------+-------+-------------+--------------------+--------+------------+-----------+-------------+
# | fpganXXf03 | 5       | 19:00.0  | 3     | usb 1-6.4.2 | USB-UART-FPGACARD3 | Switch | fpganXXf04 | 5         |  17         |
# +------------+---------+----------+-------+-------------+--------------------+--------+------------+-----------+-------------+
# | fpganXXf04 | 6       | 1A:00.0  | 4     | usb 1-6.4.1 | USB-UART-FPGACARD4 | Switch | fpganXXf03 | 2         |  5          |
# +------------+---------+----------+-------+-------------+--------------------+--------+------------+-----------+-------------+
# | fpganXXf05 | 7       | CD:00.0  | 5     | usb 1-6.3.4 | USB-UART-FPGACARD5 | Switch | fpganXXf06 | 7         |  25         |
# +------------+---------+----------+-------+-------------+--------------------+--------+------------+-----------+-------------+
# | fpganXXf06 | 8       | CC:00.0  | 6     | usb 1-6.3.3 | USB-UART-FPGACARD6 | Switch | fpganXXf05 | 3         |  9          |
# +------------+---------+----------+-------+-------------+--------------------+--------+------------+-----------+-------------+
# | fpganXXf07 | 9       | B3:00.0  | 7     | usb 1-6.3.2 | USB-UART-FPGACARD7 | Switch | fpganXXf08 | 4         |  13         |
# +------------+---------+----------+-------+-------------+--------------------+--------+------------+-----------+-------------+
# | fpganXXf08 | 10      | B4:00.0  | 8     | usb 1-6.3.1 | USB-UART-FPGACARD8 | Switch | fpganXXf07 | 8         |  29         |
# +------------+---------+----------+-------+-------------+--------------------+--------+------------+-----------+-------------+
# An automation could be applied by processing TCL list got from command: targets -target-properties
#
# targets 1
# targets
fpga -boot-status
fpga -config-status
fpga -state

# ---- Programming FPGA
fpga -file ./project/ethernet_system.runs/impl_1/ethernet_system_wrapper.bit
# fpga -file ./project/ethernet_system_wrapper.bit # extracted from XSA bitstream
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
