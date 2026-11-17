#!/usr/bin/env bash
set -Eeuo pipefail

IMAGE="$HOME/Projects/Yocto-RPi3-Scarthgap/build/tmp/deploy/images/raspberrypi3-64/core-image-aion-raspberrypi3-64.rootfs.wic.bz2"
DEVICE="/dev/mmcblk0"

echo "=== AION SD Flash ==="

if [[ ! -f "$IMAGE" || ! -b "$DEVICE" ]]; then
    echo "ERROR: Image or SD device missing"
    exit 1
fi

if [[ "$(lsblk -dn -o TYPE "$DEVICE" | xargs)" != "disk" ]]; then
    echo "ERROR: Target is not a disk"
    exit 1
fi

lsblk -o NAME,SIZE,MODEL,TYPE,MOUNTPOINTS "$DEVICE"

echo
read -r -p "Type FLASH-AION to erase $DEVICE: " ANSWER
[[ "$ANSWER" == "FLASH-AION" ]] || exit 1

while read -r PARTITION; do
    if findmnt -rn -S "$PARTITION" >/dev/null; then
        sudo umount "$PARTITION"
    fi
done < <(lsblk -lnpo NAME "$DEVICE" | tail -n +2)

bzcat "$IMAGE" |
    sudo dd of="$DEVICE" bs=4M status=progress conv=fsync

sync
echo "=== FLASH COMPLETE ==="
