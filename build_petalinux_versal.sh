
petalinux-create --type project --template versal --name plnx_proj
cd ./plnx_proj/
petalinux-config --get-hw-description ../project/ethernet_test_wrapper.xsa
petalinux-build
petalinux-package --boot --u-boot
