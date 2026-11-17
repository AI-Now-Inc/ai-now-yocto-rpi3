#!/usr/bin/env bash
set -Eeuo pipefail

IMAGE="$HOME/Projects/Yocto-RPi3-Scarthgap/image-inspection/cjk/core-image-base-cjk.wic"
DEVICE="/dev/mmcblk0"

echo "=== Yocto CJK SD Card Deployment ==="

if [[ ! -f "$IMAGE" ]]; then
    echo "ERROR: Image not found: $IMAGE"
    exit 1
fi

if [[ ! -b "$DEVICE" ]]; then
    echo "ERROR: Device not found: $DEVICE"
    exit 1
fi

if [[ "$(lsblk -dn -o TYPE "$DEVICE" | xargs)" != "disk" ]]; then
    echo "ERROR: Target is not a disk"
    exit 1
fi

if [[ "$(lsblk -dn -o TRAN "$DEVICE" | xargs)" == "nvme" ]]; then
    echo "ERROR: NVMe device is not allowed"
    exit 1
fi

IMAGE_SIZE=$(stat -c '%s' "$IMAGE")
DEVICE_SIZE=$(sudo blockdev --getsize64 "$DEVICE")

if (( IMAGE_SIZE < 100000000 || IMAGE_SIZE > DEVICE_SIZE )); then
    echo "ERROR: Invalid image/device size"
    exit 1
fi

echo
echo "SOURCE: $IMAGE"
echo "IMAGE SIZE: $IMAGE_SIZE bytes"
echo "TARGET: $DEVICE"
echo "DEVICE SIZE: $DEVICE_SIZE bytes"

echo
lsblk -o NAME,SIZE,FSTYPE,MOUNTPOINTS "$DEVICE"

echo
echo "WARNING: Existing partitions will be overwritten."
read -r -p "Type /dev/mmcblk0 to confirm: " CONFIRM

if [[ "$CONFIRM" != "$DEVICE" ]]; then
    echo "Cancelled."
    exit 1
fi

echo
echo "=== UNMOUNT SD PARTITIONS ==="

sudo umount /dev/mmcblk0p1
sudo umount /dev/mmcblk0p2

if lsblk -nr -o MOUNTPOINTS "$DEVICE" |
    grep -q '[^[:space:]]'; then
    echo "ERROR: Device is still mounted"
    exit 1
fi

echo
echo "=== FLASH IMAGE ==="

sudo dd \
    if="$IMAGE" \
    of="$DEVICE" \
    bs=4M \
    status=progress \
    conv=fsync

sync

echo
echo "=== VERIFY IMAGE ==="

sudo cmp -n "$IMAGE_SIZE" "$IMAGE" "$DEVICE"

echo
echo "=== RELOAD PARTITION TABLE ==="

sudo partprobe "$DEVICE" || true
sudo udevadm settle

echo
echo "=== FINAL PARTITIONS ==="

lsblk -o NAME,SIZE,FSTYPE,LABEL,MOUNTPOINTS "$DEVICE"

echo
echo "SUCCESS: Image written and verified."
