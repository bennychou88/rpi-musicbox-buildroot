#!/bin/sh

set -e

usage() {
  cat <<EOH

Usage: $0 [--create-partitions] <device>

  --create-partitions  Will recreate partition layout on <device>
  device               The DEVICE device: /dev/mmcblk0

EOH
}

PARTITION=no
if [ "_$1" == "_--create-partitions" ] ; then
  PARTITION=yes
  shift
fi

DEVICE=$1
if [ ! -b "$DEVICE" ] ; then
  usage
  exit 1
fi


if [ "$PARTITION" == "yes" ] ; then
  # 1: 32M
  # 2: 200M
  # 3: available
  sudo fdisk $DEVICE <<END
o
n
p
1

+32M
n
p
2

+200M
n
p
3


t
1
e
a
1
w
END

  sleep 1
  mkfs.ext4 -F -q -L data $DEVICE?3

fi

mkfs.vfat -F 16 -n boot -I $DEVICE?1
mkfs.ext4 -F -q -L root $DEVICE?2


BASEDIR=$(basedir $0)
MNT=$(mktemp -d --tmpdir $BASEDIR)

sudo mount $DEVICE?1 $MNT
find $BASEDIR/buildroot/output/images/rpi-firmware -type f -exec sudo cp {} $MNT \+
find $BASEDIR/buildroot/output/images -type f -maxdepth 1 -name '*.dtb' -exec sudo cp {} $MNT \+
sudo cp $BASEDIR/buildroot/output/images/zImage $MNT
sudo cp -r $BASEDIR/boot/* $MNT
sudo umount $MNT

sudo mount ${DEVICE}?2 $MNT
sudo tar xpsf $BASEDIR/buildroot/output/images/rootfs.tar -C $MNT
sudo umount $MNT

rmdir $MNT

sync
