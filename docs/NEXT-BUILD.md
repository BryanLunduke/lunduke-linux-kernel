# Next LLK build

| Item | Value |
|------|--------|
| Version | `7.2.6-lcos22` |
| Config | `configs/lunduke-7.2.6-lcos22.config` |
| Why | LCOS#138: Realtek USB Wi-Fi (TP-Link RTL8852CU and friends) and RTL8814AE PCIe |
| Delta | `docs/config-lcos21-to-lcos22.diff` |
| Build notes | `docs/lcos22-build.md` |
| Base | lcos21 (`configs/lunduke-7.2.6-lcos21.config`, merge ee74301e, PR #17) |

**lcos22 on lcos21.** Requested: `CONFIG_RTW89_8852CU=m`, `CONFIG_RTW89_8852BU=m`, `CONFIG_RTW89_8851BU=m`, `CONFIG_RTW89_8922AU=m`, `CONFIG_RTW88_8814AE=m`. olddefconfig pulled in nothing else: `RTW89_USB`, the rtw89 chip cores, `RTW88_PCI` and `RTW88_8814A` were already =m. RTW88 SDIO variants (`8822BS/8822CS/8723DS/8723CS/8821CS`) stay off. No Forced Rust. `CONFIG_LOCALVERSION="-lunduke"`.

**Firmware:** each driver tries its newest firmware format first and falls back to older ones (rtw89 `fw.c`). firmware-realtek 20250410-2 (excalibur, current ISO) has a usable file for every chip; firmware-realtek 20260810-1~bpo13+1 (excalibur-backports) has the newest formats. See `docs/lcos22-build.md`.
