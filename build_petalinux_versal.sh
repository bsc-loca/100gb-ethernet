
#if a lack of disk space is met, /tmp/plnx_proj* temporary folders should be removed
petalinux-create --type project --template versal --name plnx_proj
cd ./plnx_proj/
petalinux-config --get-hw-description ../project/ethernet_test_wrapper.xsa
petalinux-build
petalinux-package --boot --u-boot
#the following is needed for case of EXT4 root filesystem type set in petalinux-config step (Image Packaging Configuration)  
petalinux-package --wic
