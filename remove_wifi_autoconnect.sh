#!/bin/bash

ROOTFS_OVERLAY_ETC_DIR="ext/board/customboard/rootfs_overlay/etc"
ROOTFS_OVERLAY_INITD_DIR="ext/board/customboard/rootfs_overlay/etc/init.d"

TARGET_OVERLAY_ETC_DIR="buildroot/output/target/etc"
TARGET_OVERLAY_INITD_DIR="buildroot/output/target/etc/init.d"

ROOTFS_WPA_SUPPLICANT_CONF_FILE_PATH="$ROOTFS_OVERLAY_ETC_DIR/wpa_supplicant.conf"
ROOTFS_INIT_SCRIPT_FILE_PATH="$ROOTFS_OVERLAY_INITD_DIR/S42wifi-network-autoconnect"

TARGET_WPA_SUPPLICANT_CONF_FILE_PATH="$TARGET_OVERLAY_ETC_DIR/wpa_supplicant.conf"
TARGET_INIT_SCRIPT_FILE_PATH="$TARGET_OVERLAY_INITD_DIR/S42wifi-network-autoconnect"

rm -rf $ROOTFS_WPA_SUPPLICANT_CONF_FILE_PATH
rm -rf $ROOTFS_INIT_SCRIPT_FILE_PATH

echo "WPA supplicant '$ROOTFS_WPA_SUPPLICANT_CONF_FILE_PATH' deleted"
echo "Init script '$ROOTFS_INIT_SCRIPT_FILE_PATH' deleted"

rm -rf $TARGET_WPA_SUPPLICANT_CONF_FILE_PATH
rm -rf $TARGET_INIT_SCRIPT_FILE_PATH

echo "WPA supplicant '$TARGET_WPA_SUPPLICANT_CONF_FILE_PATH' deleted"
echo "Init script '$TARGET_INIT_SCRIPT_FILE_PATH' deleted"
