#!/bin/bash

ROOTFS_OVERLAY_ETC_DIR="ext/board/customboard/rootfs_overlay/etc"
ROOTFS_OVERLAY_INITD_DIR="ext/board/customboard/rootfs_overlay/etc/init.d"

mkdir -p $ROOTFS_OVERLAY_ETC_DIR
mkdir -p $ROOTFS_OVERLAY_INITD_DIR

WPA_SUPPLICANT_CONF_FILE_PATH="$ROOTFS_OVERLAY_ETC_DIR/wpa_supplicant.conf"
INIT_SCRIPT_FILE_PATH="$ROOTFS_OVERLAY_INITD_DIR/S42wifi-network-autoconnect"

echo "Enter Wi-Fi network SSID:"
read SSID

echo "Enter Wi-Fi network password:"
read PASSWORD

cat <<EOF > "$WPA_SUPPLICANT_CONF_FILE_PATH"
network={
	ssid="$SSID"
	psk="$PASSWORD"
}
EOF

echo "WPA supplicant created at '$WPA_SUPPLICANT_CONF_FILE_PATH'"

cat <<EOF > "$INIT_SCRIPT_FILE_PATH"
#!/bin/sh

case "\$1" in
	start)
	echo "Starting Wi-Fi ..."
	modprobe brcmfmac
        while [ ! -d /sys/class/net/wlan0 ]; do sleep 1; done
	ip link set wlan0 up
	wpa_supplicant -B -i wlan0 -c /etc/wpa_supplicant.conf
	;;

	stop)
	echo "Stopping Wi-Fi ..."
	killall wpa_supplicant
	ip link set wlan0 down
	;;

	*)
	echo "Usage: \$0 {start|stop}"
	;;
esac
EOF

chmod u+x $INIT_SCRIPT_FILE_PATH

echo "Init script created at '$INIT_SCRIPT_FILE_PATH'"
