RPI music hotspot
=================

Quickstart
----------

Go into `buildroot` directory.

    rpimusic$ cd buildroot
    rpimusic/buildroot$ make raspberrypi_defconfig   # set up a default configuration for raspberry
    rpimusic/buildroot$ make menuconfig              # customize configuration
    rpimusic/buildroot$ make
    rpimusic/buildroot$ cd ..
    rpimusic$ ./create-sdcard.sh --create-partitions /dev/mmcblk0  # recreate partition layout
    rpimusic$ ./create-sdcard.sh /dev/mmcblk0                      # assume partitions already exist

More details
------------

In `config_rpimusic`, I added:

- mpd, mpc, ncmpc and ympd
- audio libraries
- hostapd, dnsmasq, dhcpd, dhclient
- openssh

`overlay/` contains files added to the target filesystem.

`pre-image.sh` is run before the target image is built.

`create-sdcard.sh` turns the given device into a bootable sdcard for the raspberrypi.
