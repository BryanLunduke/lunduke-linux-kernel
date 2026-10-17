# Next LLK build

| Item | Value |
|------|--------|
| Version | `7.2.6-lcos27` |
| Config | `configs/lunduke-7.2.6-lcos27.config` |
| Why | ExpressCard/eSATA (SiI3132, Marvell, ACPI PCI hotplug, Renesas xHCI firmware loader); metapackage files owned by root |
| Delta | `docs/config-lcos25-to-lcos27.diff` |
| Build notes | `docs/lcos27-build.md` |
| Base | lcos25 (`configs/lunduke-7.2.6-lcos25.config`, merge e7a72c16, PR #21) |

**lcos27 on lcos25.** `CONFIG_SATA_SIL24=m`, `CONFIG_SATA_MV=m`, `CONFIG_HOTPLUG_PCI_ACPI=y` (bool), `CONFIG_USB_XHCI_PCI_RENESAS=m`. olddefconfig additionally turned on `CONFIG_GENERIC_PHY=y` (selected by SATA_MV); `ATA_SFF`/`ATA_BMDMA` were already on, `HOTPLUG_PCI_ACPI_IBM` stays off. `scripts/build-metapackage.sh` now builds with `dpkg-deb --root-owner-group` (lcos25 and earlier metapackages had files owned by the build user). No Forced Rust. `CONFIG_LOCALVERSION="-lunduke"`.

lcos26 (PR #22) was an experiment with a per-build kernel release (`7.2.6-lunduke-lcos26`). It was backed out; lcos27 returns to the single `7.2.6-lunduke` name used by lcos4 through lcos25. The lcos26 tag and its history are kept as they are, and lcos26 is not a base for later builds.
