#!/usr/bin/env bash
# Build Lunduke's Linux Kernel debs from upstream kernel.org sources.
# Tested for 7.2.6-lcos4 on the LCOS shared builder (keep -j modest; ~16G RAM).
set -euo pipefail

VERSION="${VERSION:-7.2.6}"
KDEB_PKGVERSION="${KDEB_PKGVERSION:-${VERSION}-lcos4}"
LOCALVERSION="${LOCALVERSION:--lunduke}"
JOBS="${JOBS:-3}"
SRC_DIR="${SRC_DIR:-linux-${VERSION}}"
CONFIG_IN="${CONFIG_IN:-$(cd "$(dirname "$0")/.." && pwd)/configs/lunduke-${VERSION}-lcos4.config}"

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
# Ensure LOCALVERSION matches published ABI flavor
scripts/config --set-str LOCALVERSION "$LOCALVERSION"
# Keep Rust out of the build (LCOS ideal: No Forced Rust)
scripts/config --disable RUST 2>/dev/null || true
make olddefconfig

export KDEB_PKGVERSION
make -j"$JOBS" bindeb-pkg

echo "Done. Debs land in parent of $SRC_DIR (linux-image-${VERSION}-lunduke_${KDEB_PKGVERSION}_amd64.deb, headers, etc.)."
