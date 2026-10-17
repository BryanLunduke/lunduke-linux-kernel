# 7.2.6-lcos27 build (2026-10-17)

Config: lcos25 + ExpressCard/eSATA (editor 2026-10-16 CT):
`CONFIG_SATA_SIL24=m`, `CONFIG_SATA_MV=m`, `CONFIG_HOTPLUG_PCI_ACPI=y` (bool),
`CONFIG_USB_XHCI_PCI_RENESAS=m`; olddefconfig also turned on `CONFIG_GENERIC_PHY=y`
(selected by SATA_MV). See `docs/config-lcos25-to-lcos27.diff`. No Forced Rust.
`CONFIG_LOCALVERSION="-lunduke"`: the kernel release stays `7.2.6-lunduke`, as in lcos4 through lcos25.
The built `/boot/config-7.2.6-lunduke` is byte-identical to
`configs/lunduke-7.2.6-lcos27.config`.

lcos26 (PR #22) gave each build its own kernel release (`7.2.6-lunduke-lcos26`). That naming
experiment was backed out, and lcos27 is built on lcos25, not on lcos26.

Metapackage: `scripts/build-metapackage.sh` now passes `--root-owner-group` to `dpkg-deb`, so
every file in `lunduke-linux-kernel_7.2.6-lcos27_all.deb` is root:root (lcos25 and earlier
were owned by the build user).

Built from a fresh kernel.org linux-7.2.6.tar.xz (sha256 039aef84…f606) unpacked
into a new tree, with `scripts/build-lunduke-kernel.sh` (JOBS=6, nice 10,
KBUILD_BUILD_VERSION=lcos27) and `scripts/build-metapackage.sh`.
`uname -r`: `7.2.6-lunduke`. `uname -v`: `#lcos27 SMP PREEMPT_DYNAMIC Sat Oct 17 00:03:12 CDT 2026`.
Modules: **1020** .ko (lcos25: 1017), +3 (sata_sil24, sata_mv, xhci-pci-renesas).

```
cd347bcf01f7b57f47bf8847ae0cbc1115086e2b125364abcf6b358249fe7a35  linux-headers-7.2.6-lunduke_7.2.6-lcos27_amd64.deb
bbc8c4b0248a6013e80323d15135e7210cd71a8a9fe3bb21f3e6e93839971c88  linux-image-7.2.6-lunduke_7.2.6-lcos27_amd64.deb
d124dd4d90c948349106abcf10634ffd53c346254c5ead5116c9e985e2dc5ab8  linux-libc-dev_7.2.6-lcos27_amd64.deb
4766e6ff491bbbcba27fa3bc296ce2317ec88a816e6c35842c486df90518ed7d  lunduke-linux-kernel_7.2.6-lcos27_all.deb
```

Debs: `/workspace/lcos-kernel/debs-lcos27/`. Not seeded, not published.
PR must be merged on editor order before seeding into lcos-live.
