# 7.2.15-lcos33 build (2026-11-06), for LCOS 1.0.1

Editor approval (2026-11-06 CT): full 1.0.1 kernel queue (message t1793u), including optional extras VLAN/macvlan/ipvlan, ATH5K, Galaxy Book, MSI WMI Platform, and Uniwill ("Go with your suggestions").

**Upstream:** Linux 7.2.15, same as lcos32. Tarball sha256
`d0f6b1d7324c937ccaeb5c4ca7084bfcf71db2edb3e2d3a31f0ad83a681809ab` (unchanged from lcos30).
No source patches. Kernel release stays `7.2.15-lunduke`. `CONFIG_LOCALVERSION="-lunduke"`.
No Forced Rust (`CONFIG_RUST` stays unset; the build script still runs `scripts/config --disable RUST`).

**Config:** `configs/lunduke-7.2.15-lcos33.config` = lcos32 + the options below, then `olddefconfig` on a 7.2.15 tree.
Full delta: `docs/config-lcos32-to-lcos33.diff`.

`olddefconfig` was prepared on a 7.2.15 tree. Compiler-probe lines from that run (GCC 13.3 / binutils 2.42, no pahole) were put back to the lcos32 values (Debian GCC 14.2.0-19, binutils 2.44, pahole 1.30, including `CC_OPT_INLINE_MEMSET`). The box build confirmed the file: `/boot/config-7.2.15-lunduke` in the image deb is byte-identical to `configs/lunduke-7.2.15-lcos33.config`.

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

No 7.3 or 7.4 configs exist in this repo. When they are created for LCOS 1.1, carry this lcos33 set (and the selects/defaults above) into them.

**Build:** reused `/workspace/lcos101/build/linux-7.2.15`, `JOBS=4` under `cpulimit -l 400 -m`, America/Chicago. Started 08:59:40, debs finished ~09:07. Prior lcos30/31/32 debs were left in place.

**Checks:** `/boot/config-7.2.15-lunduke` in the image deb is byte-identical to the config. **1133** `.ko` (lcos32: 1090). Meta deb: Version `7.2.15-lcos33`, Depends `linux-image-7.2.15-lunduke (= 7.2.15-lcos33)`.

Module presence verified in the image deb: wireguard, ovpn, rt73usb, rt2800usb, rt2800pci, rt2500usb, rt2500pci, rt2400pci, sch_fq, sch_cake, macvlan, ipvlan, 8021q, ath5k, atl1c, atl1e, hid-corsair, hid-razer, hid-glorious, hid-plantronics, vmw_balloon, samsung-galaxybook, msi-wmi-platform, uniwill-laptop, ah4, esp4, plus garp, mrp, and the rt2x00/rt2800 library modules.

QEMU (q35, TCG) direct-kernel smoke with a busybox initrd, SeaBIOS and OVMF: boots as `7.2.15-lunduke` (`#lcos33`), zram with zstd works. New modules insmod cleanly except three expected `-ENODEV` probes without matching hardware: `vmw_balloon` (needs VMware), `msi-wmi-platform` and `uniwill-laptop` (DMI-gated). Those `.ko` files are in the package. Not tested on real hardware.

```
682f8fc008e9c32d51dab4e303704dbe687a02feffbb994378e637b621b1d0d4  linux-image-7.2.15-lunduke_7.2.15-lcos33_amd64.deb
02645534d8fe8ab3993d448eb4ac7a733c353013aa13cf02787f688030028e8d  linux-headers-7.2.15-lunduke_7.2.15-lcos33_amd64.deb
154811e1330a92c71b3677903dc681811adc30bc977657f91b2e2596fb523075  linux-libc-dev_7.2.15-lcos33_amd64.deb
e4a62d9a96638516d675d7d2a6b21b7d15bc8a8780df757f934987066ee49a7e  lunduke-linux-kernel_7.2.15-lcos33_all.deb
```
Debs not committed. No apt publish. Not tagged, not seeded into lcos-live.
