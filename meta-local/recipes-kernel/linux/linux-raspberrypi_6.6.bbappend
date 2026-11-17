# Use verified local Raspberry Pi Linux 6.6 Git mirror.
SRC_URI:remove = "git://github.com/raspberrypi/linux.git;name=machine;branch=${LINUX_RPI_BRANCH};protocol=https"

SRC_URI:prepend = "git:///home/john/Projects/Yocto-RPi3-Scarthgap/mirrors/rpi-linux-6.6.git;protocol=file;name=machine;branch=rpi-6.6.y "

SRCREV_machine = "e442e5c1ab6bff5b5460b4fc949beb72aaf77970"
