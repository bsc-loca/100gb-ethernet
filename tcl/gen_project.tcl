namespace eval _tcl {
proc get_script_folder {} {
    set script_path [file normalize [info script]]
    set script_folder [file dirname $script_path]
    return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

puts "The environment tcl will be sourced from ${script_folder}"
source $script_folder/environment.tcl

# Redefine the FPGA part in case the script is called with arguments
# It defaults to u280
if { $::argc >= 1 } {

        set g_board_part [lindex $argv 0]
        set g_fpga_part "xc${g_board_part}-fsvh2892-2L-e"
        if { $g_board_part == "u250" } {
          set g_fpga_part xcu250-figd2104-2L-e
        }
} 

set root_dir $g_root_dir
set g_project_name $g_project_name
set projec_dir $root_dir/project

################################################################
# START
################################################################

# Clean previous project
file delete -force $projec_dir

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
    create_project $g_project_name $projec_dir -force -part $g_fpga_part
}
# Set project properties
# CHANGE DESIGN NAME HERE
variable design_name
set design_name $g_project_name
set ip_dir_list [list \
     $root_dir/ip]
	 
	
set_property  ip_repo_paths  $ip_dir_list [current_project]


####################################################
# MAIN FLOW
####################################################

set_property target_language VHDL [current_project]

set top_module "$root_dir/src/${g_top_module_name}.vhd"
set src_files [glob ${root_dir}/src/apb_uart/src/vhdl_orig/*]
add_files ${src_files}
add_files $top_module

source ${g_root_dir}/ip/apb_bridge.tcl

# Redefine the variable for the next tcl, which will be load the environment.tcl, ignoring the changes made in this script.

set g_alveo_board $g_board_part
source $root_dir/tcl/gen_ip.tcl

puts "Project generation ended successfully"
