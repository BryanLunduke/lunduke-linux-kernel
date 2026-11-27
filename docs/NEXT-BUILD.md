# Next LLK build

| Item | Value |
|------|--------|
| Version | `7.3.6-lcos34` (LCOS 1.1, in development) |
| Upstream | Linux 7.3.6 (latest 7.3.y; 7.3 expected to be the next LTS) |
| Config | `configs/lunduke-7.3.6-lcos34.config` |
| Why | Move LCOS 1.1 to the 7.3 series (editor 2026-11-27). Config-only: lcos33 carried forward with `make olddefconfig`, plus the editor's 7.3 new-hardware picks |
| Delta | `docs/config-lcos33-to-lcos34.diff` |
| Build notes | `docs/lcos34-build.md` |
| Base | lcos33 (`configs/lunduke-7.2.15-lcos33.config`, LCOS 1.0.1) |

**lcos34 on lcos33.** New kernel release `7.3.6-lunduke` (package names change, installs beside 7.2.15-lunduke). No source patches. No Forced Rust. `CONFIG_LOCALVERSION="-lunduke"`. Every lcos30–lcos33 option is kept; new 7.3 options take upstream defaults (`DRM_AMD_DC_DCE=y` keeps legacy Radeon display), plus the editor's twelve 7.3 new-hardware picks (RTL8922DE Wi-Fi 7, AW88399 Legion speakers, SOF AMD ACP7X, AMD SFH tablet mode, Yoga Book 9 dock, AMD PMF util, MSI Claw, HyperX, SteelSeries, LeapRAID, NXP IW61x, Morse Micro HaLow). `PROC_SYSCTL` is folded into `SYSCTL` upstream. Box compile (2026-11-27): 1153 modules, QEMU q35 TCG SeaBIOS and OVMF boot `7.3.6-lunduke` `#lcos34`. 7.3 `bindeb-pkg` needs `libdw-dev` on the builder. SHA256s are in `docs/lcos34-build.md`.

## Previous: 7.2.15-lcos33

| Item | Value |
|------|--------|
| Version | `7.2.15-lcos33` (LCOS 1.0.1) |
| Upstream | Linux 7.2.15 (same as lcos32; final 7.2.y) |
| Config | `configs/lunduke-7.2.15-lcos33.config` |
| Why | LCOS 1.0.1: in-kernel WireGuard, IPv6 policy routing, OpenVPN DCO, IPv4 IPsec ESP/AH, FQ and CAKE, Ralink rt2x00 (LCOS#194), ATH5K, Atheros L1C/L1E, VLAN/macvlan/ipvlan, VMware balloon, Corsair/Razer/Glorious/Plantronics HID, Samsung Galaxy Book, MSI WMI platform, TUXEDO/Uniwill |
| Delta | `docs/config-lcos32-to-lcos33.diff` |
| Build notes | `docs/lcos33-build.md` |
| Base | lcos32 (`configs/lunduke-7.2.15-lcos32.config`, `ACPI_SBS=m`, LCOS#191) |

**lcos33 on lcos32.** Same kernel release `7.2.15-lunduke`. No source patches. No Forced Rust. `CONFIG_LOCALVERSION="-lunduke"`. Box compile (2026-11-06): 1133 modules (lcos32: 1090), QEMU q35 TCG SeaBIOS and OVMF boot `7.2.15-lunduke` `#lcos33`. SHA256s are in `docs/lcos33-build.md`.

Turned on, plus the dependencies, `select`s, and `default y` options `olddefconfig` on 7.2.15 enables:

- `WIREGUARD=m` (selects `NET_UDP_TUNNEL=m`, `CRYPTO_LIB_CURVE25519=m` with the x86_64 arch and generic code, `CRYPTO_LIB_CHACHA20POLY1305=m` and lib ChaCha/Poly1305).
- `IPV6_MULTIPLE_TABLES=y` and `IPV6_SUBTREES=y` (`FIB_RULES` was already y).
- `OVPN=m` (selects `STREAM_PARSER=y` and `CRYPTO_CHACHA20POLY1305=m`, which selects `CRYPTO_CHACHA20=m`).
- `INET_ESP=m` and `INET_AH=m`. IPv6 IPsec is already on, so `XFRM_ESP`/`XFRM_AH` were already y. ESP offload and ESP-in-TCP stay off.
- `NET_SCH_FQ=m`, `NET_SCH_CAKE=m`.
- `VLAN_8021Q=m` with `VLAN_8021Q_GVRP=y` and `VLAN_8021Q_MVRP=y` (the Ubuntu/Fedora companions; they select `GARP=m` and `MRP=m`). `MACVLAN=m`, `IPVLAN=m` (`IPVLAN_L3S=y` selects `NET_L3_MASTER_DEV=y`; `NET_VRF` stays off).
- rt2x00: `RT73USB`, `RT2800USB`, `RT2800PCI`, `RT2500USB`, `RT2500PCI`, `RT2400PCI` =m, plus the rt2x00/rt2800 library modules, `RT2X00_LIB_LEDS=y`, and the RT2800 chipset bools that default y. `RT61PCI` and the RT2800USB chipsets without `default y` stay off.
- `ATH5K=m` (selects `ATH5K_PCI=y`). `ATL1C=m`, `ATL1E=m`.
- `HID_CORSAIR`, `HID_RAZER`, `HID_GLORIOUS`, `HID_PLANTRONICS` =m. No force-feedback or LED sub-options on these drivers.
- `VMWARE_BALLOON=m`. `SAMSUNG_GALAXYBOOK=m`, `MSI_WMI_PLATFORM=m`, `X86_PLATFORM_DRIVERS_UNIWILL=y`, `UNIWILL_LAPTOP=m`.

Left off: `MAC80211_MESH`, `ZSWAP` / `ZSWAP_DEFAULT_ON`, `PPP`, `PPPOE`, `IPW2100`, `IPW2200`. No resolvconf or other userspace packaging.

This lcos33 option set was carried into `configs/lunduke-7.3.6-lcos34.config` for LCOS 1.1.

## Previous: 7.2.15-lcos32

| Item | Value |
|------|--------|
| Version | `7.2.15-lcos32` |
| Config | `configs/lunduke-7.2.15-lcos32.config` |
| Why | ACPI Smart Battery System (`sbs`, `sbshc`) for the 2014 MacBook Air battery, LCOS#191 |
| Delta | `docs/config-lcos31-to-lcos32.diff` |
| Build notes | `docs/lcos32-build.md` |
| Base | lcos31 |

**lcos32 on lcos31.** `CONFIG_ACPI_SBS=m` only. `ACPI_EC` and `POWER_SUPPLY` were already y, so olddefconfig changed nothing else. Same `7.2.15-lunduke` kernel release. Add `ACPI_SBS=m` to the 7.3/7.4 configs for LCOS 1.1 along with the lcos33 set.
