#!/usr/bin/env bash
# Add a postinst to a bindeb-pkg linux-headers deb that runs the
# /etc/kernel/header_postinst.d hooks (Debian convention; dkms ships
# /etc/kernel/header_postinst.d/dkms) with the kernel release.
# Usage: fix-headers-postinst.sh linux-headers-<krel>_<ver>_amd64.deb
set -euo pipefail
deb="$(realpath "$1")"
krel="$(basename "$deb" | sed -E 's/^linux-headers-([^_]+)_.*/\1/')"
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT
fakeroot sh -c "dpkg-deb -R '$deb' '$tmp/p' && cat > '$tmp/p/DEBIAN/postinst' <<EOP
#!/bin/sh
set -e
if [ \"\\\$1\" = configure ] && [ -d /etc/kernel/header_postinst.d ]; then
	run-parts --arg=$krel /etc/kernel/header_postinst.d
fi
exit 0
EOP
chmod 755 '$tmp/p/DEBIAN/postinst' && dpkg-deb --root-owner-group -Zxz -b '$tmp/p' '$deb' >/dev/null"
echo "headers postinst added: $deb ($krel)"
