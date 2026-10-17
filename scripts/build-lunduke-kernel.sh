#!/usr/bin/env bash
# Build Lunduke's Linux Kernel debs from upstream kernel.org sources.
# Config revision 7.2.6-lcos26 (keep -j modest on the LCOS shared builder; ~16G RAM).
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
VERSION="${VERSION:-7.2.6}"
REV="${REV:-lcos26}"
KDEB_PKGVERSION="${KDEB_PKGVERSION:-${VERSION}-${REV}}"
# Flavor string stored in Kconfig only. Do NOT also export LOCALVERSION to make —
# that would append a second suffix (ABI becomes 7.2.6-lunduke-lcos26-lunduke-lcos26).
# From lcos26 every build has its own ABI: uname 7.2.6-lunduke-<rev>, packages
# linux-image-7.2.6-lunduke-<rev> / linux-headers-7.2.6-lunduke-<rev>. New kernels
# install side by side, so DKMS builds for each one and a stale module from an
# older build can never load. lcos4..lcos25 all used plain 7.2.6-lunduke.
FLAVOR_LOCALVERSION="${FLAVOR_LOCALVERSION:--lunduke-${REV}}"
JOBS="${JOBS:-3}"
SRC_DIR="${SRC_DIR:-linux-${VERSION}}"
CONFIG_IN="${CONFIG_IN:-$SCRIPT_DIR/../configs/lunduke-${VERSION}-${REV}.config}"

if [[ ! -d "$SRC_DIR" ]]; then
  echo "Missing $SRC_DIR — download from https://cdn.kernel.org/pub/linux/kernel/v7.x/linux-${VERSION}.tar.xz and unpack here." >&2
  exit 1
fi
if [[ ! -f "$CONFIG_IN" ]]; then
  echo "Missing config: $CONFIG_IN" >&2
  exit 1
fi

cd "$SRC_DIR"
cp -a "$CONFIG_IN" .config
# Ensure LOCALVERSION matches published ABI flavor (single source of truth)
scripts/config --set-str LOCALVERSION "$FLAVOR_LOCALVERSION"
# Keep Rust out of the build (LCOS ideal: No Forced Rust)
scripts/config --disable RUST 2>/dev/null || true
make LOCALVERSION= olddefconfig

export KDEB_PKGVERSION
# Explicit empty make LOCALVERSION so ambient env cannot double the flavor suffix
make LOCALVERSION= -j"$JOBS" bindeb-pkg

cd ..
# bindeb-pkg's linux-headers package has no maintainer scripts, so when apt
# configures the image before the headers, /etc/kernel/postinst.d/dkms finds
# no headers and skips the build. Give the headers package a postinst that
# runs /etc/kernel/header_postinst.d (DKMS builds there once headers exist).
"$SCRIPT_DIR/fix-headers-postinst.sh" "linux-headers-${VERSION}${FLAVOR_LOCALVERSION}_${KDEB_PKGVERSION}_amd64.deb"
echo "Done. Debs land in parent of $SRC_DIR (linux-image-${VERSION}${FLAVOR_LOCALVERSION}_${KDEB_PKGVERSION}_amd64.deb, headers, etc.)."
