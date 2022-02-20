
namespace eval _tcl {
proc get_script_folder {} {
    set script_path [file normalize [info script]]
    set script_folder [file dirname $script_path]
    return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2021.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
    puts ""
    catch {common::send_gid_msg -ssname BD::TCL -id 2041 -severity "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

    return 1
}


puts "The environment tcl will be sourced from ${script_folder}"
source $script_folder/environment.tcl

# Redefine the FPGA part in case the script is called with arguments
# It defaults to u280
if { $::argc > 0 } {

        set g_board_part [lindex $argv 0]
        set g_fpga_part "xc${g_board_part}-fsvh2892-2L-e"
        if { ${g_board_part} eq "versal" } {
        set g_fpga_part "xcvc1802-viva1596-2LP-e-S"
        }
}

set root_dir $g_root_dir

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source sdvs_script.tcl

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set g_project_name $g_project_name
set projec_dir $root_dir/project

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
    create_project $g_project_name $projec_dir -force -part $g_fpga_part

    # two options to name Alveo chip
    # create_project $g_project_name $projec_dir -force -part xcu280-fsvh2892-2L-e
    # create_project $g_project_name $projec_dir -force -part xcvu37p-fsvh2892-2L-e

    # create_project $g_project_name $projec_dir -force -part xcu55c-fsvh2892-2L-e
    # create_project $g_project_name $projec_dir -force -part xcvu47p-fsvh2892-2L-e

    #Versal chip:
    # create_project $g_project_name $projec_dir -force -part xcvc1802-viva1596-2LP-e-S
}
# Set project properties
set obj [current_project]
# set_property -name "board_part" -value "xilinx.com:au280:part0:1.1" -objects $obj
# set_property -name "board_part" -value "xilinx.com:au55c:part0:1.0" -objects $obj

# CHANGE DESIGN NAME HERE
variable design_name
set design_name $g_project_name

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design -dir {${root_dir}/bd} ${design_name}BD

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
    # USE CASES:
    #    1) Design_name not set

    set errMsg "Please set the variable <design_name> to a non-empty value."
    set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
    # USE CASES:
    #    2): Current design opened AND is empty AND names same.
    #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
    #    4): Current design opened AND is empty AND names diff; design_name exists in project.

    if { $cur_design ne $design_name } {
       common::send_gid_msg -ssname BD::TCL -id 2001 -severity "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
       set design_name [get_property NAME $cur_design]
    }
    common::send_gid_msg -ssname BD::TCL -id 2002 -severity "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
    # USE CASES:
    #    5) Current design opened AND has components AND same names.

    set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
    set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
    # USE CASES: 
    #    6) Current opened design, has components, but diff names, design_name exists in project.
    #    7) No opened design, design_name exists in project.

    set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
    set nRet 2

} else {
    # USE CASES:
    #    8) No opened design, design_name not in project.
    #    9) Current opened design, has components, but diff names, design_name not in project.

    common::send_gid_msg -ssname BD::TCL -id 2003 -severity "INFO" "Currently there is no design <$design_name> in project, so creating one..."

    create_bd_design -dir $root_dir/bd $design_name

    common::send_gid_msg -ssname BD::TCL -id 2004 -severity "INFO" "Making design <$design_name> as current_bd_design."
    current_bd_design $design_name

}

common::send_gid_msg -ssname BD::TCL -id 2005 -severity "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
    catch {common::send_gid_msg -ssname BD::TCL -id 2006 -severity "ERROR" $errMsg}
    return $nRet
}


set ip_dir_list [list \
     $root_dir/ip]
	
set_property  ip_repo_paths  $ip_dir_list [current_project]


update_ip_catalog -rebuild

if { ${g_board_part} ne "versal" } {
# creating isolated Ethernet subsystem BD for integration with OpenPiton
source $root_dir/tcl/eth_cmac_syst.tcl
cr_bd_Eth_CMAC_syst ""
# creating the IP of isolated Ethernet subsystem
source $root_dir/tcl/eth_syst_ip.tcl
# adding bare microBlaze to above BD and exporting BSP with xparameters.h from it
file copy -force $root_dir/tcl/eth_cmac_syst.tcl $root_dir/bd/Eth_CMAC_syst/
source $root_dir/tcl/eth_syst_bsp.tcl
# also just extracting hw parameters from TCL and creating C-header
source $root_dir/tcl/eth_syst_xparams.tcl
}


# creating full Ethernet system BD
if { ${g_board_part} eq "versal" } {
source $root_dir/tcl/gen_bd_versal.tcl
} else {
source $root_dir/tcl/gen_bd_alveo.tcl
}
create_root_design ""

validate_bd_design
save_bd_design
make_wrapper -files [get_files $root_dir/bd/${g_project_name}/${g_project_name}.bd] -top
add_files -norecurse           $root_dir/bd/${g_project_name}/hdl/${g_project_name}_wrapper.v


##################################################################
# MAIN FLOW
##################################################################

# Add Constraint files to project
# add_files -fileset [get_filesets constrs_1] "$root_dir/xdc/${g_project_name}_pinout.xdc"
# add_files -fileset [get_filesets constrs_1] "$root_dir/xdc/${g_project_name}_timing.xdc"
# add_files -fileset [get_filesets constrs_1] "$root_dir/xdc/${g_project_name}_ila.xdc"

add_files -fileset [get_filesets constrs_1]   "$root_dir/xdc/${g_project_name}_${g_board_part}.xdc"
# set_property PROCESSING_ORDER LATE [get_files "$root_dir/xdc/${g_project_name}_${g_board_part}.xdc"]

puts "Project generation ended successfully"

source $root_dir/tcl/gen_bitstream.tcl
