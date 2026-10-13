# Next LLK build

| Item | Value |
|------|--------|
| Version | `7.2.6-lcos21` |
| Config | `configs/lunduke-7.2.6-lcos21.config` |
| Why | Intel VMD for NVMe behind Intel Volume Management Device (Dell/HP "RAID On"); PCIe native hotplug, as Debian trixie |
| Delta | `docs/config-lcos20-to-lcos21.diff` |
| Build notes | `docs/lcos21-build.md` |
| Base | lcos20 (`configs/lunduke-7.2.6-lcos20.config`, merge e97fb3c5, PR #16) |

**lcos21 on lcos20.** Requested: `CONFIG_VMD=m`, `CONFIG_HOTPLUG_PCI_PCIE=y` (both match Debian trixie 6.12 amd64). olddefconfig on a clean linux-7.2.6 tree pulled in nothing else; the delta is exactly those two lines. `VMD` depends on `PCI_MSI` and `X86_64` (both already y); `IRQ_REMAP`, `INTEL_IOMMU`, `X86_X2APIC` already y. No Forced Rust. `CONFIG_LOCALVERSION="-lunduke"`.

**Not in scope:** Intel RST RAID arrays (IMSM). Those need mdadm plus `MD_RAID0/1/10` (all still off). VMD covers the single-NVMe "RAID On" case only; users with a real RST array should switch firmware to AHCI.

**initramfs:** initramfs-tools with LCOS's `MODULES=most` pulls in `vmd` automatically (`hook-functions`: `block` adds `vmd`; under `MODULES=dep`, `nvme` implies `vmd`). No `/etc/initramfs-tools/modules` change needed.
