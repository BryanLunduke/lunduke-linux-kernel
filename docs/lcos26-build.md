# 7.2.6-lcos26 build (2026-10-16)

Config: lcos25 + ExpressCard/eSATA (editor 2026-10-16 CT): `CONFIG_SATA_SIL24=m`,
`CONFIG_SATA_MV=m`, `CONFIG_HOTPLUG_PCI_ACPI=y`, `CONFIG_USB_XHCI_PCI_RENESAS=m`.
olddefconfig also enabled `CONFIG_GENERIC_PHY=y` (SATA_MV). See
`docs/config-lcos25-to-lcos26.diff`. No Forced Rust.

**Kernel release is now per build:** `CONFIG_LOCALVERSION="-lunduke-lcos26"`, so
`uname -r` = `7.2.6-lunduke-lcos26`, packages `linux-image-7.2.6-lunduke-lcos26` /
`linux-headers-7.2.6-lunduke-lcos26`. The metapackage Depends on both (exact version).
`scripts/fix-headers-postinst.sh` gives the headers deb a postinst that runs
`/etc/kernel/header_postinst.d` (bindeb-pkg headers have no maintainer scripts).

Built from a fresh linux-7.2.6.tar.xz tree with JOBS=6 under `cpulimit -l 600 -m`,
KBUILD_BUILD_VERSION=lcos26. `uname -v`: `#lcos26 SMP PREEMPT_DYNAMIC Fri Oct 16 21:04:12 CDT 2026`.
Modules: **1020** .ko (lcos25: 1017): sata_sil24, sata_mv, xhci-pci-renesas.
The built config is byte-identical to `configs/lunduke-7.2.6-lcos26.config`.

```
218e5c6acf24e4c8ae9f2288c597c925968ecb89601c4d13b8e2de7dec05d49a  linux-headers-7.2.6-lunduke-lcos26_7.2.6-lcos26_amd64.deb
7c37143102737172a5a2e87a022a051955027dd6ac00d6f231b2fc053f04be93  linux-image-7.2.6-lunduke-lcos26_7.2.6-lcos26_amd64.deb
9d970a35b4e06267791c9738eb247898371fec85f841027100feac870092c824  linux-libc-dev_7.2.6-lcos26_amd64.deb
05521db5f186e3128e84699fdb9bb3a9bd015056cd2fc0f77015aa7cb1129023  lunduke-linux-kernel_7.2.6-lcos26_all.deb
```

DKMS test (bwrap sandbox on the 094-05 rootfs with lcos25 installed, Debian trixie
gcc 14.2 + dkms 3.2.2, NVIDIA open-gpu-kernel-modules 580.178.04 registered with DKMS):
installing the lcos26 image+headers ran DKMS autoinstall from both
`/etc/kernel/postinst.d/dkms` and the new headers postinst; nvidia, nvidia-modeset,
nvidia-drm, nvidia-uvm installed to `/lib/modules/7.2.6-lunduke-lcos26/updates/dkms`
(vermagic `7.2.6-lunduke-lcos26 SMP preempt mod_unload`). Reinstalling the image after
`dkms remove -k` rebuilt them automatically. lcos25 (7.2.6-lunduke) stayed installed beside it.

Debs: `/workspace/lcos-kernel/debs-lcos26/`. Not seeded, not published.
PR must be merged on editor order before seeding into lcos-live.
