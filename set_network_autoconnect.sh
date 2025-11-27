#!/bin/bash

WPA_SUPPLICANT_CONF_FILE_PATH="ext/board/customboard/conf_wpa_supplicant/wpa_supplicant.conf"

read -p "Do you want to autoconnect to a network? [y/n] " AUTOCONNECT

if [[ "$AUTOCONNECT" == "n" || "$AUTOCONNECT" == "N" ]]; then
	rm -rf $WPA_SUPPLICANT_CONF_FILE_PATH
	echo "Deleted '$WPA_SUPPLICANT_CONF_FILE_PATH' file"
	exit 0
fi

read -p "Enter Wi-Fi network SSID: " SSID
read -p "Enter Wi-Fi network password: " PASSWORD

cat <<EOF > "$WPA_SUPPLICANT_CONF_FILE_PATH"
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
ap_scan=1

network={
	ssid="$SSID"
	psk="$PASSWORD"
    key_mgmt=WPA-PSK
}
EOF

echo "Created '$WPA_SUPPLICANT_CONF_FILE_PATH' file"
