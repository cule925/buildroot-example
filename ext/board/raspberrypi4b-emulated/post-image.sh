#!/bin/bash

# Fail on error
set -e

# Prepare for generating image
BOARD_DIR="$(dirname $0)"
BOARD_NAME="$(basename ${BOARD_DIR})"
GENIMAGE_CFG="${BOARD_DIR}/genimage-${BOARD_NAME}.cfg"
GENIMAGE_TMP="${BUILD_DIR}/genimage.tmp"

DTS_SOURCE_DIR="${BOARD_DIR}/overlays"
DTBO_BUILD_DIR="${BINARIES_DIR}/rpi-firmware/overlays"

# Compile DTS files into DTB files
for dts in "$DTS_SOURCE_DIR"/*-overlay.dts; do
	# If no matches, skip
	[ -e "$dts" ] || continue

	# Strip '-overlay.dts' part from filename 
	base=$(basename "$dts" -overlay.dts)

	dtbo="$DTBO_BUILD_DIR/$base"

	dtc -@ -I dts -O dtb -o "$dtbo.dtbo" "$dts"
done

# Pass empty rootpath because root filesystem already exists, genimage must
# only insert a pre-built image in the disk image, not build it.

# If the script exits on the next commands, delete the rootpath automatically
trap 'rm -rf "${ROOTPATH_TMP}"' EXIT

# Creates a new temporary directory int the /tmp directory
ROOTPATH_TMP="$(mktemp -d)"

# Delete old image temporary directory
rm -rf "${GENIMAGE_TMP}"

# Generate image
genimage \
	--rootpath "${ROOTPATH_TMP}"   \
	--tmppath "${GENIMAGE_TMP}"    \
	--inputpath "${BINARIES_DIR}"  \
	--outputpath "${BINARIES_DIR}" \
	--config "${GENIMAGE_CFG}"

exit $?
