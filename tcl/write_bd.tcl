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


# 	=================================================================="
# 	===        Project structure and tcl generation script         ==="
# 	=================================================================="
# 
#  The user will add rtl files in the \\src folder and if a block desing is used, "
#  the user must ensure to use the following commands within an opened vivado block design:"

#  cd [get_property DIRECTORY [current_project]]"
if { ${g_board_part} eq "versal" } {
write_bd_tcl -force -hier_blks [get_bd_cells /] ./tcl/gen_bd_versal.tcl
} else {
write_bd_tcl -force -hier_blks [get_bd_cells /] ./tcl/gen_bd_alveo.tcl
}
