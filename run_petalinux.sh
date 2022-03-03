#!/bin/bash
# Copyright 2022 Barcelona Supercomputing Center-Centro Nacional de Supercomputación

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
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

#In booted Petalinux to check Eth driver:
# dmesg | grep eth
# find /proc/device-tree/ -type f -exec head {} + | grep eth
# ifconfig
# ip link
# gunzip </proc/config.gz | grep XILINX
