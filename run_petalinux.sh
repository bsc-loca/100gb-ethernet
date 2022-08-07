#!/bin/bash
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



hw_server -d
# cd ./plnx_proj/
# petalinux-boot --jtag --fpga --kernel

export ELF_TO_RUN="./plnx_proj/images/linux/image.elf"
xsct -interactive ./tcl/run_elf.tcl

#In separate terminal:
# picocom -b 115200 /dev/ttyUSB2

#In booted Petalinux to login: (https://docs.xilinx.com/r/en-US/ug1144-petalinux-tools-reference-guide/Login-Changes)
# default user: petalinux, password should be set
#In booted Petalinux to check Eth driver:
# dmesg | grep eth
# find /proc/device-tree/ -type f -exec head {} + | grep eth
# ifconfig
# ip link
# gunzip </proc/config.gz | grep XILINX
