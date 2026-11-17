# AION Embedded Linux

A custom Yocto-based ARM64 Linux distribution for Raspberry Pi 3 Model B.

Built with Yocto Project Scarthgap (5.0 LTS).

## Features

- Raspberry Pi 3 Model B (ARM64)
- UTF-8 and CJK console support
- kmscon on tty1
- Standard getty recovery console on tty2
- NetworkManager Wi-Fi management
- OpenSSH remote access
- Avahi / mDNS (aion.local)
- systemd service integration
- Custom Yocto image recipes

## Project Structure

- meta-local/ : AION custom Yocto layer
- flash-aion.sh : SD card deployment script
- fix-cjk-xkb.sh : CJK keyboard configuration helper

## Build Requirements

- Yocto Project Scarthgap
- Poky
- meta-raspberrypi
- meta-openembedded
- Linux build host

## Build Instructions

Initialize the Yocto build environment and configure the target
machine as raspberrypi3-64.

Add the AION custom layer to BBLAYERS.

Build the image with:

    bitbake core-image-aion

The resulting image will be located under the Yocto deploy directory.

## Hardware Status

Initial Raspberry Pi 3 hardware bring-up completed.

The system supports:

- CJK console
- Wi-Fi networking
- SSH access
- mDNS hostname discovery

## Repository Scope

This repository contains the custom Yocto layer and deployment scripts.

Excluded:

- Upstream Yocto source trees
- Local build caches
- Generated SD card images
- Personal music collections

## License

MIT License. See meta-local/COPYING.MIT.
