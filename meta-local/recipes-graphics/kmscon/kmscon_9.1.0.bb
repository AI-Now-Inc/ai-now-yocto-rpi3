SUMMARY = "KMS/DRM Unicode terminal emulator"
DESCRIPTION = "Userspace Linux terminal emulator using DRM/KMS and Unicode text rendering."
HOMEPAGE = "https://github.com/Aetf/kmscon"
SECTION = "console/utils"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://COPYING;md5=5743c1aeeb41a19e3497196a358cdce1"

SRC_URI = "git://github.com/Aetf/kmscon.git;protocol=https;branch=main"
SRCREV = "cd17ca4b8e82fc64f70181f382bba7883ff105f9"

S = "${WORKDIR}/git"

inherit meson pkgconfig systemd

DEPENDS = " \
    libtsm \
    libxkbcommon \
    systemd \
    libdrm \
    pixman \
    pango \
    python3-native \
"

EXTRA_OEMESON = " \
    -Dtests=false \
    -Ddocs=disabled \
    -Dmulti_seat=enabled \
    -Delogind=disabled \
    -Dvideo_fbdev=disabled \
    -Dvideo_drm2d=enabled \
    -Dvideo_drm3d=disabled \
    -Drenderer_bbulk=enabled \
    -Drenderer_gltex=disabled \
    -Drenderer_pixman=enabled \
    -Dfont_unifont=disabled \
    -Dfont_pango=enabled \
    -Dsession_dummy=disabled \
    -Dsession_terminal=enabled \
"

# Keep upstream systemd unit integration for a later,
# separately tested image-integration stage.

# Package upstream systemd service units.
SYSTEMD_SERVICE:${PN} = "kmscon.service kmsconvt@.service"

# Do not start kmscon automatically yet.
SYSTEMD_AUTO_ENABLE = "disable"

FILES:${PN} += " \
    ${systemd_system_unitdir}/kmscon.service \
    ${systemd_system_unitdir}/kmsconvt@.service \
"
