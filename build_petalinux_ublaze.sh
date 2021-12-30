
petalinux-create --type project --template microblaze --name plnx_proj
cd ./plnx_proj/
#At this step manually: Image Packaging Configuration -> Root File System Type -> INITRAMFS
petalinux-config --get-hw-description ../project/ethernet_test_wrapper.xsa
petalinux-build
