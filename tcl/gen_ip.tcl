source $root_dir/tcl/environment.tcl
source $root_dir/tcl/ip_properties.tcl

set ip_properties [ list \
    vendor "meep-project.eu" \
    library "MEEP" \
    name "$g_ip_name" \
    version "$g_ip_version" \
    taxonomy "/MEEP_IP" \
    display_name "$g_display_name" \
    description "$g_ip_description" \
    core_revision 1 \
    vendor_display_name "bsc.es" \
    company_url "https://meep-project.eu/" \
    ]


set family_lifecycle { \
  virtexuplusHBM Production \
}

file mkdir ${root_dir}/uart

# Package project and set properties
ipx::package_project -root_dir ${root_dir}/uart -import_files
set ip_core [ipx::current_core]
set_property -dict ${ip_properties} ${ip_core}
set_property SUPPORTED_FAMILIES ${family_lifecycle} ${ip_core}

## Custom IP section

ipx::infer_bus_interfaces xilinx.com:interface:apb_rtl:1.0 $ip_core
ipx::infer_bus_interfaces xilinx.com:interface:uart_rtl:1.0 $ip_core

set_property driver_value 0 [ipx::get_ports CTSN -of_objects $ip_core ]
set_property driver_value 0 [ipx::get_ports DSRN -of_objects $ip_core ]
set_property driver_value 0 [ipx::get_ports DCDN -of_objects $ip_core ]
set_property driver_value 0 [ipx::get_ports RIN -of_objects  $ip_core ]

set_property name S_AXI [ipx::get_bus_interfaces s_axi -of_objects $ip_core]


## Custom ends here


## Relative path to IP root directory
ipx::create_xgui_files ${ip_core} -logo_file "${root_dir}/misc/BSC-Logo.png"
set_property type LOGO [ipx::get_files "${root_dir}/misc/BSC-Logo.png" -of_objects [ipx::get_file_groups xilinx_utilityxitfiles -of_objects $ip_core]]


# Save IP and close project
ipx::check_integrity ${ip_core}
ipx::save_core ${ip_core}

ipx::merge_project_changes files [ipx::current_core]
update_ip_catalog -rebuild -scan_changes

puts "IP succesfully packaged " 
