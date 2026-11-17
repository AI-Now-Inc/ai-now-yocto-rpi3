SUMMARY = "Raspberry Pi 3 ARM64 Unicode Console Image"
DESCRIPTION = "Yocto Scarthgap image with kmscon and CJK font support."

require recipes-core/images/core-image-base.bb

IMAGE_INSTALL:append = " \
    kmscon \
    fontconfig \
    ttf-wqy-zenhei \
    ttf-dejavu-sans \
"

# Keep the existing Linux console and SSH access.
# KMSCON services remain disabled until manual testing.

# Required by kmscon/libxkbcommon for keyboard initialization.
IMAGE_INSTALL:append = " \
    xkeyboard-config \
"
