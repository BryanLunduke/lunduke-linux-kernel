# Next LLK build

| Item | Value |
|------|--------|
| Version | `7.2.6-lcos15` |
| Config | `configs/lunduke-7.2.6-lcos15.config` |
| Why | ASIX AX88179/AX88178A USB Ethernet (LCOS#100) on frozen lcos14 |
| Delta | `docs/config-lcos14-to-lcos15.diff` |
| Base | lcos14 (`configs/lunduke-7.2.6-lcos14.config`, commit 6487b4dc) |

**lcos15 enables ASIX USB Ethernet on lcos14.** `CONFIG_USB_NET_AX88179_178A=m` covers vendor-class AX88179 (0b95:1790) and AX88178A (0b95:178a). `CONFIG_USB_NET_AX8817X=m` covers the older AX88172/AX88772 family. `CONFIG_USB_NET_CDC_NCM=m` covers AX88179A/AX88772D, which on Linux 7.2.6 enumerate as CDC NCM and are not named in `ax88179_178a.c`. olddefconfig also selected `CONFIG_PHYLINK=m` and `CONFIG_SWPHY=y`, and made `CONFIG_SFP` visible (left off). No firmware blob. lcos12 shipped on LCOS 0.8 and stays frozen. lcos13 and lcos14 stay frozen. No Forced Rust (`# CONFIG_RUST is not set`). `CONFIG_LOCALVERSION="-lunduke"`. No kernel debs were built. No ISO bake.
