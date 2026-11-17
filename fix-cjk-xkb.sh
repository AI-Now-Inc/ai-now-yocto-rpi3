#!/usr/bin/env bash
set -eo pipefail

PROJECT="$HOME/Projects/Yocto-RPi3-Scarthgap"
RECIPE="$PROJECT/meta-local/recipes-core/images/core-image-base-cjk.bb"

cd "$PROJECT"

echo "=== Initialize Yocto ==="
source poky/oe-init-build-env build

echo
echo "=== Verify XKB recipe ==="

bitbake-layers show-recipes xkeyboard-config

echo
echo "=== Verify image recipe ==="

if [[ ! -f "$RECIPE" ]]; then
    echo "ERROR: Image recipe not found: $RECIPE"
    exit 1
fi

echo
echo "=== Add XKB configuration ==="

if ! grep -Eq '^[[:space:]]*xkeyboard-config[[:space:]]*$' "$RECIPE"; then
    cat >> "$RECIPE" <<'CONFIG'

# Required by kmscon/libxkbcommon for keyboard initialization.
IMAGE_INSTALL:append = " \
    xkeyboard-config \
"
CONFIG
fi

echo
echo "=== Build CJK Music Image ==="

bitbake core-image-base-cjk-music

echo
echo "=== Generated Image ==="

ls -lhL \
    tmp/deploy/images/raspberrypi3-64/\
core-image-base-cjk-music-raspberrypi3-64.rootfs.wic.bz2

echo
echo "=== DONE ==="
