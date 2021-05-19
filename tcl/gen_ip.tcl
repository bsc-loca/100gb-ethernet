
ipx::package_project -root_dir $root_dir/ip -vendor bsc.es -library user -taxonomy /UserIP -module ethernet_test -import_files
set_property name         Eth_100Gb          [ipx::find_open_core bsc.es:user:ethernet_test:1.0]
set_property display_name Eth_100Gb          [ipx::find_open_core bsc.es:user:Eth_100Gb:1.0]
set_property description  Eth_100Gb          [ipx::find_open_core bsc.es:user:Eth_100Gb:1.0]
set_property vendor_display_name bsc.es      [ipx::find_open_core bsc.es:user:Eth_100Gb:1.0]
set_property core_revision 1                 [ipx::find_open_core bsc.es:user:Eth_100Gb:1.0]
ipx::create_xgui_files                       [ipx::find_open_core bsc.es:user:Eth_100Gb:1.0]
ipx::update_checksums                        [ipx::find_open_core bsc.es:user:Eth_100Gb:1.0]
ipx::save_core                               [ipx::find_open_core bsc.es:user:Eth_100Gb:1.0]
ipx::check_integrity -quiet                  [ipx::find_open_core bsc.es:user:Eth_100Gb:1.0]
ipx::archive_core $root_dir/ip/Eth_100Gb.zip [ipx::find_open_core bsc.es:user:Eth_100Gb:1.0]
ipx::unload_core $root_dir/ip/component.xml

set_property ip_repo_paths  "${root_dir}/ip" [current_project]
update_ip_catalog -rebuild
