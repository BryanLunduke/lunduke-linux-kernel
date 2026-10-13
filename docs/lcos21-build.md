# 7.2.6-lcos21 build (2026-10-13)

Config: lcos20 + `CONFIG_VMD=m` (Intel VMD, NVMe behind Dell/HP "RAID On") + `CONFIG_HOTPLUG_PCI_PCIE=y` (PCIe native hotplug, as Debian trixie).
olddefconfig on a clean linux-7.2.6 tree changed nothing else (see config-lcos20-to-lcos21.diff). The built `.config` is byte-identical to `configs/lunduke-7.2.6-lcos21.config`.
Built with `scripts/build-lunduke-kernel.sh` (JOBS=4, under `cpulimit -l 400 -m`) and `scripts/build-metapackage.sh`. Toolchain: Debian gcc 14.2.0-19, binutils 2.44.
`uname -v`: `#lcos21 SMP PREEMPT_DYNAMIC Tue Oct 13 11:20:05 CDT 2026`; `uname -r` `7.2.6-lunduke`.
Modules: 950 .ko (lcos20: 949); only addition is drivers/pci/controller/vmd.ko (modinfo OK: Intel Volume Management Device driver v0.6, GPL v2, no deps, 11 Intel PCI aliases incl. 8086:9A0B, 467F, A77F, AD0B, 7D0B). pciehp is built in.

Tests:
- initramfs: lcos21 image installed into the lcos-live-093-04 chroot (overlay copy); update-initramfs with LCOS `MODULES=most` includes `kernel/drivers/pci/controller/vmd.ko` plus nvme/nvme-core. No modules-file change needed.
- QEMU (TCG, q35, root on an emulated NVMe behind a pcie-root-port, LCOS 0.9.3 userspace with lcos21 kernel + its initramfs): boots normally to runlevel 2; NVMe root mounted r/w, fsck clean, dbus/elogind/NetworkManager/lightdm start. No oops, panic or call trace. QEMU has no VMD emulation, so vmd binding itself is untested (needs real "RAID On" hardware); SeaBIOS/q35 ACPI does not grant native PCIe hotplug, so pciehp was not exercised.

```
9e2c601edfb3d0f2418f22df75ba4699eb533f83b1e61dbc464d3d55b66293c5  linux-headers-7.2.6-lunduke_7.2.6-lcos21_amd64.deb
cc3f027bbc0b18d317c35726e0ecff2a51f3d95f60f58a989cdd60e3df5b8add  linux-image-7.2.6-lunduke_7.2.6-lcos21_amd64.deb
0d22de4894802bec20c45cf213b1468dc846fb3d870a80bc8134d9812da620ab  linux-libc-dev_7.2.6-lcos21_amd64.deb
eef8e9e9ad97bf9a832b1ef2b2e5ece126b561f08e462164b0be43a628217ca8  lunduke-linux-kernel_7.2.6-lcos21_all.deb
```

Not seeded, not published.
