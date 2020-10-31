
# script to build bare-metal application
# XSCT reference: https://www.xilinx.com/html_docs/xilinx2020_1/vitis_doc/upu1569395223804.html

#Set Vitis workspace
setws ./xsct_ws
#Create application project
app create -name eth_test -hw ./project/ethernet_test_wrapper.xsa -proc microblaze_0 -arch 32 -os standalone -lang c++ -template {Empty Application (C++)}

#Report created project
platform list
platform report
sysproj list
sysproj report eth_test_system
app list
app report eth_test

#Config the app
importsources -name eth_test -path ./src/eth_test.cpp
app config -name eth_test -set build-config release
app config -name eth_test -get build-config

#Build the app
app clean all
app build all

exit
