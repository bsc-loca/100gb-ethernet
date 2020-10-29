# 	=================================================================="
# 	===        Project structure and tcl generation script         ==="
# 	=================================================================="
# 
#  The user will add rtl files in the \\src folder and if a block desing is used, "
#  the user must ensure to use the following commands within an opened vivado block design:"

#  cd [get_property DIRECTORY [current_project]]"
write_bd_tcl -force -hier_blks [get_bd_cells /] ./tcl/gen_bd.tcl"
