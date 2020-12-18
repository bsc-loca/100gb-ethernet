
# script to build bare-metal application
# XSCT reference: http://www.xilinx.com/html_docs/xilinx2020_2/vitis_doc/obi1585821551850.html

#Set Vitis workspace
setws ./xsct_ws
#Checking available apps as templates
repo -apps
#Create application project (combined creation of platform, domain/bsp, project/app)
app create -name eth_test -hw ./project/ethernet_test_wrapper.xsa -proc microblaze_0 -arch 32 -os standalone -lang c++ -template {Empty Application (C++)}
# -os freertos10_xilinx                # tested option to create app under simple OS
# -lang c -template {lwIP Echo Server} # tested option to create simple lwIP-based app (further importsources command should be commented)

#Create platform and domain/bsp
# platform create -name eth_test_platform -hw ./project/ethernet_test_wrapper.xsa -proc microblaze_0 -arch 32 -os standalone
#Create project/app
# app create -name eth_test -platform eth_test_platform -lang c++ -template {Empty Application (C++)}

#Report created platform
platform list
platform active
platform report

#Report set OS
domain list
domain active
domain report

#config the BSP
bsp setlib -name lwip211
bsp config -append extra_compiler_flags {-DDEBUG}
# bsp regenerate
#Report created BSP
bsp listparams -proc
bsp getos
bsp listparams -os
bsp getdrivers
bsp getlibs
bsp listparams -lib lwip211

#Report created project
sysproj list
sysproj report eth_test_system

#Report created app
app list
app report eth_test
#config the app
importsources -name eth_test -path ./src/eth_test.cpp
app config -name eth_test -set build-config release
app config -name eth_test -add compiler-misc {-std=c++17 -Wall -Og}
# app config -name eth_test -add libraries xil   # (-l for lib of drivers for components from the platform (XSA), linked automatically (-L,-l))
# app config -name eth_test -add libraries lwip4 # (-l for lwIP lib, linked automatically (-L,-l))
#report app configs
app config -name eth_test
app config -name eth_test -get build-config
app config -name eth_test -get compiler-misc
app config -name eth_test -get compiler-optimization
app config -name eth_test -get define-compiler-symbols
app config -name eth_test -get include-path
app config -name eth_test -get libraries
app config -name eth_test -get library-search-path
app config -name eth_test -get linker-misc
app config -name eth_test -get linker-script
app config -name eth_test -get undef-compiler-symbols

#Build the app
app clean all
app build all

exit
