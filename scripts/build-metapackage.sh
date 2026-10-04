#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SRC="$ROOT/packaging/lunduke-linux-kernel"
OUT="$ROOT/out"
mkdir -p "$OUT"
dpkg-deb --build "$SRC" "$OUT/lunduke-linux-kernel_7.2.6-lcos14_all.deb"
echo "Wrote $OUT/lunduke-linux-kernel_7.2.6-lcos14_all.deb"
