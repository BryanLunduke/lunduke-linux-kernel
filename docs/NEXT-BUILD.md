# Next LLK build

| Item | Value |
|------|--------|
| Version | `7.2.6-lcos14` |
| Config | `configs/lunduke-7.2.6-lcos14.config` |
| Why | Intel 82801AA AC97 (LCOS#94) and MediaTek MT7630E (LCOS#95) on frozen lcos13 |
| Delta | `docs/config-lcos13-to-lcos14.diff` |
| Base | lcos13 (`configs/lunduke-7.2.6-lcos13.config`, commit 2993e43) |

**lcos14 enables snd-intel8x0 and mt76x0e on lcos13.** `CONFIG_SND_INTEL8X0=m` covers PCI 8086:2415. `CONFIG_MT76x0E=m` covers PCI 14c3:7610, 14c3:7630, and 14c3:7650. `CONFIG_SND_INTEL8X0M` and `CONFIG_MT76x0U` stay unset. olddefconfig also selected `CONFIG_SND_AC97_CODEC=m`, `CONFIG_AC97_BUS=m`, `CONFIG_MT76x0_COMMON=m`, and `CONFIG_MT76x02_LIB=m`. No firmware blob. lcos12 shipped on LCOS 0.8 and stays frozen. lcos13 stays frozen. No Forced Rust (`# CONFIG_RUST is not set`). `CONFIG_LOCALVERSION="-lunduke"`. No kernel debs were built. No ISO bake.
