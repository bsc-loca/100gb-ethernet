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


#script_version 1
namespace eval _tcl {
proc get_script_folder {} {
    set script_path [file normalize [info script]]
    set script_folder [file dirname $script_path]
    return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

set g_vivado_version [version -short] 
set g_board_part u55c
set g_eth_port qsfp1
set g_dma_mem hbm
set g_saxi_freq 100000000
set g_saxi_prot AXI4LITE-64
set g_max_dma_addr_width 40
set g_ext_dma_addr_width $g_max_dma_addr_width

set g_fpga_part xc${g_board_part}-fsvh2892-2L-e
set g_root_dir    [file normalize "$script_folder/../"]
set g_project_name ethernet_system                       
set g_project_dir ${g_root_dir}/project    
set g_design_name ${g_project_name}          
#set g_rtl_ext sv 	  				  
#set g_top_module  ${g_root_dir}/src/${g_project_name}_top.$g_rtl_ext
set g_useBlockDesign Y	  
