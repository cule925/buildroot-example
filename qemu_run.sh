#!/bin/bash

TARGET_DEVICE_TREE_BLOB="buildroot/output/images/bcm2711-rpi-4-b.dtb"
TARGET_KERNEL="buildroot/output/images/Image"
TARGET_KERNEL_CMDLINE_PARAMS="root=/dev/mmcblk1p2 rootwait quiet vt.global_cursor_default=0"
TARGET_IMG="buildroot/output/images/sdcard.img"

# Resize image (increase size) to accommodate QEMU image size requirement
qemu-img resize -f raw $TARGET_IMG 256M

# Run Raspberry Pi 4B HW emulation using QEMU
qemu-system-aarch64 \
	-machine raspi4b \
	-cpu cortex-a72 \
	-m 2G \
	-smp 4 \
	-dtb "$TARGET_DEVICE_TREE_BLOB" \
	-drive file="$TARGET_IMG",format=raw \
	-kernel "$TARGET_KERNEL" \
	-append "$TARGET_KERNEL_CMDLINE_PARAMS"
