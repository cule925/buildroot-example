# Buildroot project layout example

To execute a Buildroot Make target from the external tree, use:

```
make -C buildroot/ BR2_EXTERNAL="$(pwd)/ext" <Buildroot Make target>
```

For example, to start the Buildroot configuration screen: `make -C buildroot/ BR2_EXTERNAL="$(pwd)/ext" menuconfig`.

To load a configuration, including those defined in the external tree, run:

```
make -C buildroot/ BR2_EXTERNAL="$(pwd)/ext" <defconfig name>
```

To save your configuration in a defconfig file, run:

```
make -C buildroot/ BR2_EXTERNAL="$(pwd)/ext" savedefconfig BR2_DEFCONFIG="$(pwd)/ext/configs/<defconfig name>"
```

To build the project, run:

```
make -C buildroot/ BR2_EXTERNAL="$(pwd)/ext"
```
## Flashing the image on the SD card

First, unmount any auto mounted partition of the SD card:

```
umount <device file of the SD card partition>
```

To flash the image on the SD card, run:

```
sudo dd if='buildroot/output/images/sdcard.img' of='<device file of the SD card>' bs=4M conv=fsync status=progress
```

## Buildroot helper script

As an alternative to executing the commands above, there is a Buildroot helper script that executes most of the necessary Make targets. Invoke it with:

```
./make_buildroot.sh
```

## Flashing the image on the SD card

First, unmount any auto mounted partition of the SD card:

```
umount <device file of the SD card partition>
```

To flash the image on the SD card, run:

```
sudo dd if='buildroot/output/images/sdcard.img' of='<device file of the SD card>' bs=4M conv=fsync status=progress
```

## Wi-Fi autoconnect

To enable Wi-Fi and prepare the credentials for Wi-Fi autoconnect before build, execute:

```
./init_wifi_autoconnect.sh
```

To disable Wi-Fi and remove the credentials for Wi-Fi autoconnect before build, execute:

```
./remove_wifi_autoconnect.sh
```

