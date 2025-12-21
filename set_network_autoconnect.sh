#!/bin/bash

NETWORK_MANAGER_CONN_INTERFACE_NAME="wlan0"
NETWORK_MANAGER_CONN_ID="preconfigured-$NETWORK_MANAGER_CONN_INTERFACE_NAME"
NETWORK_MANAGER_CONN_FILE_NAME="$NETWORK_MANAGER_CONN_ID.nmconnection"
NETWORK_MANAGER_CONN_FILE_DIR="ext/board/customboard/rootfs_overlay/etc/NetworkManager/system-connections"
NETWORK_MANAGER_CONN_FILE_PATH="$NETWORK_MANAGER_CONN_FILE_DIR/$NETWORK_MANAGER_CONN_FILE_NAME"
BUILD_NETWORK_MANAGER_CONN_FILE_PATH="buildroot/output/target/etc/NetworkManager/system-connections/$NETWORK_MANAGER_CONN_FILE_NAME"

read -p "Do you want to autoconnect to a Wi-Fi network? [y/n] " AUTOCONNECT

if [[ "$AUTOCONNECT" == "n" || "$AUTOCONNECT" == "N" ]]; then
	rm -rf $NETWORK_MANAGER_CONN_FILE_PATH
	rm -rf $BUILD_NETWORK_MANAGER_CONN_FILE_PATH
	echo "Deleted '$NETWORK_MANAGER_CONN_FILE_PATH' file"
	echo "Deleted '$BUILD_NETWORK_MANAGER_CONN_FILE_PATH' file"
	exit 0
fi

read -p "Enter Wi-Fi network SSID: " SSID
read -p "Enter Wi-Fi network password: " PASSWORD

mkdir -p $NETWORK_MANAGER_CONN_FILE_DIR

CONN_UUID=$(uuidgen)

cat <<EOF > "$NETWORK_MANAGER_CONN_FILE_PATH"
[connection]
id=$NETWORK_MANAGER_CONN_ID
uuid=$CONN_UUID
type=wifi
interface-name=$NETWORK_MANAGER_CONN_INTERFACE_NAME

[wifi]
mode=infrastructure
ssid=$SSID

[wifi-security]
key-mgmt=wpa-psk
psk=$PASSWORD

[ipv4]
method=auto

[ipv6]
addr-gen-mode=default
method=auto

[proxy]
EOF

echo "Created '$NETWORK_MANAGER_CONN_FILE_PATH' file"
