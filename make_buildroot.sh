#!/bin/bash

AVAILABLE_COMMANDS="build|menuconfig|linux-menuconfig|clean|clean-all|clean-dist|defconfig-save|defconfig-list|defconfig-load"

MAKE_TARGET=""
TARGET_ARG=""

DEFCONFIG_CONFIGS_DIR="$(pwd)/ext/configs"

case $1 in
	build)
		MAKE_TARGET=""
		TARGET_ARG=""
		;;
	menuconfig)
		MAKE_TARGET="menuconfig"
                TARGET_ARG=""
		;;
	linux-menuconfig)
		MAKE_TARGET="linux-menuconfig"
		TARGET_ARG=""
		;;
	clean)
		MAKE_TARGET="clean"
                TARGET_ARG=""
                ;;
	clean-all)
		MAKE_TARGET="clean all"
		TARGET_ARG=""
                ;;
	clean-dist)
                MAKE_TARGET="distclean"
                TARGET_ARG=""
                ;;
	defconfig-save)
		MAKE_TARGET="savedefconfig"
		echo "Enter defconfig name that will be saved in '$DEFCONFIG_CONFIGS_DIR' directory:"
		read DEFCONFIG_NAME
		TARGET_ARG="BR2_DEFCONFIG=\"$DEFCONFIG_CONFIGS_DIR/$DEFCONFIG_NAME\""
		;;
	defconfig-list)
                MAKE_TARGET="list-defconfigs"
                TARGET_ARG=""
                ;;
	defconfig-load)
                echo "Enter defconfig name that will be applied:"
                read DEFCONFIG_NAME
                MAKE_TARGET="$DEFCONFIG_NAME"
		;;
	*)
		echo "Unknown command. Usage: $0 {$AVAILABLE_COMMANDS}"
		exit 1
		;;
esac

make -C buildroot/ BR2_EXTERNAL="$(pwd)/ext" $MAKE_TARGET $TARGET_ARG
