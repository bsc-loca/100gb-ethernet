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



#If a lack of disk space is met, /tmp/plnx_proj* temporary folders should be removed
petalinux-create --type project --template versal --name plnx_proj
cd ./plnx_proj/
#At this step choosing the only option so far for Ethernet core in PL:
#Subsytem AUTO Hardware Settings -> Ethernet Settings -> Primary Ethernet(manual) -> ethmac_lite
petalinux-config --get-hw-description ../project/ethernet_system_wrapper.xsa
petalinux-build
petalinux-package --boot --u-boot
#The following is needed if choosing EXT4 root filesystem type at petalinux-config GUI step (Image Packaging Configuration)  
petalinux-package --wic
