# Next LLK build

| Item | Value |
|------|--------|
| Version | `7.2.6-lcos26` |
| Kernel release (uname -r) | `7.2.6-lunduke-lcos26` |
| Config | `configs/lunduke-7.2.6-lcos26.config` |
| Why | ExpressCard/eSATA (SiI3132, Marvell, ACPI PCI hotplug, Renesas xHCI firmware loader); per-build kernel release so DKMS (NVIDIA) rebuilds on every kernel update |
| Delta | `docs/config-lcos25-to-lcos26.diff` |
| Build notes | `docs/lcos26-build.md` |
| Base | lcos25 (`configs/lunduke-7.2.6-lcos25.config`, merge e7a72c16, PR #21) |

**lcos26 on lcos25.** `CONFIG_SATA_SIL24=m`, `CONFIG_SATA_MV=m`, `CONFIG_HOTPLUG_PCI_ACPI=y` (bool), `CONFIG_USB_XHCI_PCI_RENESAS=m`. olddefconfig additionally turned on `CONFIG_GENERIC_PHY=y` (selected by SATA_MV); `ATA_SFF`/`ATA_BMDMA` were already on, `HOTPLUG_PCI_ACPI_IBM` stays off. `CONFIG_LOCALVERSION="-lunduke-lcos26"`. `CONFIG_MODVERSIONS` stays off (see docs/lcos26-build.md). No Forced Rust.
