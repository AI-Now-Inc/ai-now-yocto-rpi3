SUMMARY = "Terminal emulator state machine library"
DESCRIPTION = "libtsm provides a terminal screen and VT parser implementation."
HOMEPAGE = "https://github.com/Aetf/libtsm"
SECTION = "libs"

LICENSE = "MIT & LGPL-2.1-or-later"
LIC_FILES_CHKSUM = "file://COPYING;md5=69e8256cdc4e949f86fedf94b1b320b4 file://LICENSE_htable;md5=2d5025d4aa3495befef8f17206a5b0a1"

SRC_URI = "git://github.com/Aetf/libtsm.git;protocol=https;branch=main"
SRCREV = "9d2817b727f61c09e19994b2431af716652f330b"

S = "${WORKDIR}/git"

inherit meson pkgconfig

DEPENDS = "libxkbcommon"

EXTRA_OEMESON = "-Dtests=false"
