#!/bin/sh

# Fail on error
set -u
set -e

BOARD_DIR="$(dirname $0)"
DEFAULT_WPA_SUPPLICANT_CONF_FILE_PATH="${BOARD_DIR}/conf_wpa_supplicant/default_wpa_supplicant.conf"
WPA_SUPPLICANT_CONF_FILE_PATH="${BOARD_DIR}/conf_wpa_supplicant/wpa_supplicant.conf"
WPA_SUPPLICANT_CONF_TARGET_FILE_PATH="${TARGET_DIR}/etc/wpa_supplicant.conf"

if [[ -e "$WPA_SUPPLICANT_CONF_FILE_PATH" ]]; then
    cp $WPA_SUPPLICANT_CONF_FILE_PATH $WPA_SUPPLICANT_CONF_TARGET_FILE_PATH
else
    cp $DEFAULT_WPA_SUPPLICANT_CONF_FILE_PATH $WPA_SUPPLICANT_CONF_TARGET_FILE_PATH
fi

# Add a console on tty1
if [ -e ${TARGET_DIR}/etc/inittab ]; then
    grep -qE '^tty1::' ${TARGET_DIR}/etc/inittab || \
	sed -i '/GENERIC_SERIAL/a\
tty1::respawn:/sbin/getty -L  tty1 0 vt100 # HDMI console' ${TARGET_DIR}/etc/inittab
# systemd doesn't use /etc/inittab, enable getty.tty1.service instead
elif [ -d ${TARGET_DIR}/etc/systemd ]; then
    mkdir -p "${TARGET_DIR}/etc/systemd/system/getty.target.wants"
    ln -sf /lib/systemd/system/getty@.service \
       "${TARGET_DIR}/etc/systemd/system/getty.target.wants/getty@tty1.service"
fi
