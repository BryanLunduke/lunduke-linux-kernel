# 7.2.15-lcos33 build, for LCOS 1.0.1

Prepared 2026-11-06. Not compiled here. Image, headers, and metapackage SHA256s, the .ko count, and QEMU results will be filled in after the box compile. Not tagged.

**Upstream:** Linux 7.2.15, same as lcos32. Tarball sha256
`d0f6b1d7324c937ccaeb5c4ca7084bfcf71db2edb3e2d3a31f0ad83a681809ab` (unchanged from lcos30).
No source patches. Kernel release stays `7.2.15-lunduke`. `CONFIG_LOCALVERSION="-lunduke"`.
No Forced Rust (`CONFIG_RUST` stays unset; the build script still runs `scripts/config --disable RUST`).

**Config:** `configs/lunduke-7.2.15-lcos33.config` = lcos32 + the options below, then `olddefconfig` on a 7.2.15 tree.
Full delta: `docs/config-lcos32-to-lcos33.diff`.

`olddefconfig` was run on this tree with GCC 13.3 / binutils 2.42 (no pahole). An unmodified lcos32 config was run the same way first. The only differences between those two runs are the symbols below. Compiler-probe lines that this machine rewrote (`CC_VERSION_TEXT`, `GCC_VERSION`, `AS_VERSION`, `LD_VERSION`, `RUSTC_VERSION`, `RUSTC_LLVM_VERSION`, `PAHOLE_VERSION`, `CC_OPT_INLINE_MEMSET`, `CC_HAS_MIN_FUNCTION_ALIGNMENT`, `CC_HAS_SANE_FUNCTION_ALIGNMENT`, `CC_HAS_KASAN_SW_TAGS`, `OPENSSL_SUPPORTS_ML_DSA`) were put back to the lcos32 values (Debian GCC 14.2.0-19, binutils 2.44, pahole 1.30). The box `olddefconfig` should leave the file unchanged.

### Enabled on purpose

- In-kernel WireGuard: `WIREGUARD=m` (`wireguard.ko`). `WIREGUARD_DEBUG` stays off.
- IPv6 policy routing: `IPV6_MULTIPLE_TABLES=y`, `IPV6_SUBTREES=y`. `FIB_RULES` was already y.
- OpenVPN Data Channel Offload: `OVPN=m` (`ovpn.ko`).
- IPv4 IPsec ESP/AH: `INET_ESP=m` (`esp4.ko`), `INET_AH=m` (`ah4.ko`). IPv6 IPsec is already built in (`INET6_ESP=y`, `INET6_AH=y`), so `XFRM_ESP` and `XFRM_AH` were already y and this adds no new crypto. `INET_ESP_OFFLOAD` and `INET_ESPINTCP` stay off.
- `NET_SCH_FQ=m` (`sch_fq.ko`), `NET_SCH_CAKE=m` (`sch_cake.ko`). Default qdisc is unchanged.
- Ralink/rt2x00, including RT73USB (LCOS#194): `RT2X00=m`, `RT73USB=m`, `RT2800USB=m`, `RT2800PCI=m`, `RT2500USB=m`, `RT2500PCI=m`, `RT2400PCI=m`.
- `ATH5K=m`. `ATL1C=m`, `ATL1E=m`.
- `VMWARE_BALLOON=m` (`vmw_balloon.ko`). `VMWARE_VMCI` was already m; `BALLOON` was already y.
- HID: `HID_CORSAIR=m` (`hid-corsair.ko`, `hid-corsair-void.ko`), `HID_RAZER=m`, `HID_GLORIOUS=m`, `HID_PLANTRONICS=m`. None of these four has a force-feedback or LED sub-option. `HID_CORSAIR` depends on `USB_HID` and `LEDS_CLASS` (both already y) and selects `POWER_SUPPLY` (already y).
- `VLAN_8021Q=m` (`8021q.ko`). Kconfig then offers `VLAN_8021Q_GVRP` and `VLAN_8021Q_MVRP` (both default n). Both are y, which is how Ubuntu and Fedora generic configs ship them. `MACVLAN=m`, `IPVLAN=m`. `MACVTAP` and `IPVTAP` stay off.
- `SAMSUNG_GALAXYBOOK=m` (`samsung-galaxybook.ko`). Selects `ACPI_PLATFORM_PROFILE` (already y) and `FW_ATTR_CLASS` (already m).
- `MSI_WMI_PLATFORM=m` (`msi-wmi-platform.ko`). Depends on `ACPI_WMI`, `DMI`, and `HWMON`, all already y.
- TUXEDO/Uniwill: `X86_PLATFORM_DRIVERS_UNIWILL=y`, `UNIWILL_LAPTOP=m` (`uniwill-laptop.ko`). Depends on `LEDS_CLASS_MULTICOLOR` (already m). Selects `REGMAP` and `INPUT_SPARSEKMAP` (both already y).

Left off, as requested: `MAC80211_MESH`, `ZSWAP`, `ZSWAP_DEFAULT_ON`, `PPP`, `PPPOE`, `IPW2100`, `IPW2200`. No resolvconf and no other userspace packaging.

### What olddefconfig turned on besides the list above

- WireGuard selects `NET_UDP_TUNNEL=m` (`udp_tunnel.ko`, `ip6_udp_tunnel.ko`; `NET_IP_TUNNEL` was already m), `CRYPTO_LIB_CURVE25519=m` (`libcurve25519.ko`) with `CRYPTO_LIB_CURVE25519_ARCH=y` and `CRYPTO_LIB_CURVE25519_GENERIC=y` (x86_64 defaults), and `CRYPTO_LIB_CHACHA20POLY1305=m` (`libchacha20poly1305.ko`). `CRYPTO_LIB_UTILS` was already y.
- That ChaCha20-Poly1305 library selects `CRYPTO_LIB_CHACHA=m` (`libchacha.ko`, `CRYPTO_LIB_CHACHA_ARCH=y`) and `CRYPTO_LIB_POLY1305=m` (`libpoly1305.ko`, `CRYPTO_LIB_POLY1305_ARCH=y`). The generic Poly1305 fallback stays off because the x86_64 arch code is on.
- OVPN selects `STREAM_PARSER=y` (built-in `strparser`, not a module) and `CRYPTO_CHACHA20POLY1305=m` (`chacha20poly1305.ko`), which selects `CRYPTO_CHACHA20=m` (`chacha.ko`).
- GVRP selects `GARP=m` (`garp.ko`). MVRP selects `MRP=m` (`mrp.ko`). Both are modules, not built-in, because `VLAN_8021Q` is m. `STP` and `LLC` stay m.
- `IPVLAN` meets `IPVLAN_L3S`'s `def_bool y` (`NETFILTER` is y), so `IPVLAN_L3S=y` (linked into `ipvlan.ko`) and it selects `NET_L3_MASTER_DEV=y`. `NET_VRF` becomes visible and stays off. `BRIDGE_VLAN_FILTERING` becomes visible and stays off.
- rt2x00 selects `RT2X00_LIB=m`, `RT2X00_LIB_USB=m`, `RT2X00_LIB_PCI=m`, `RT2X00_LIB_MMIO=m`, `RT2800_LIB=m`, `RT2800_LIB_MMIO=m` (`rt2x00lib`, `rt2x00usb`, `rt2x00pci`, `rt2x00mmio`, `rt2800lib`, `rt2800mmio`), plus `RT2X00_LIB_CRYPTO=y`, `RT2X00_LIB_FIRMWARE=y` (`FW_LOADER` was already y), and `RT2X00_LIB_LEDS=y` (Kconfig default: `LEDS_CLASS=y`). `CRC_ITU_T` was already m (RT73USB selects it). `CRC_CCITT` and `EEPROM_93CX6` were already y.
- RT2800 bools that default y: `RT2800PCI_RT33XX`, `RT2800PCI_RT35XX`, `RT2800PCI_RT53XX`, `RT2800PCI_RT3290`, `RT2800USB_RT33XX`, `RT2800USB_RT35XX`. Left off (no default y): `RT2800USB_RT3573`, `RT2800USB_RT53XX`, `RT2800USB_RT55XX`, `RT2800USB_UNKNOWN`. `RT61PCI` stays off. `RT2X00_DEBUG` stays off. `RT2X00_LIB_DEBUGFS` is not offered (`MAC80211_DEBUGFS` is off).
- `ATH5K` selects `ATH5K_PCI=y` (it was explicitly n). `ATH5K_DEBUG` and `ATH5K_TRACER` stay off. `MAC80211_LEDS` was already y.

From the 7.2.15 Makefiles that is 43 new modules on top of lcos32's 1090 .ko. Confirm the count on the box.

No 7.3 or 7.4 configs exist in this repo. When they are created for LCOS 1.1, carry this lcos33 set (and the selects/defaults above) into them.

**Checks:** not run. SHA256s and QEMU (q35, TCG, SeaBIOS and OVMF) will be filled in after the box compile.

```
<pending box compile>  linux-image-7.2.15-lunduke_7.2.15-lcos33_amd64.deb
<pending box compile>  linux-headers-7.2.15-lunduke_7.2.15-lcos33_amd64.deb
<pending box compile>  lunduke-linux-kernel_7.2.15-lcos33_all.deb
```
Debs not committed. No apt publish. Not tagged, not seeded into lcos-live.
