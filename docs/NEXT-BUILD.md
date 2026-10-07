# Next LLK build

| Item | Value |
|------|--------|
| Version | `7.2.6-lcos16` |
| Config | `configs/lunduke-7.2.6-lcos16.config` |
| Why | LCOS 0.9 hardware gap pick-list (items 1–53) on frozen lcos15 |
| Delta | `docs/config-lcos15-to-lcos16.diff` |
| Verify | `docs/lcos16-module-verify.txt` |
| Base | lcos15 (`configs/lunduke-7.2.6-lcos15.config`, merge 2192009) |
| Built | 2026-10-07 2:14 PM CT from master `76140928` (PR #7 merge) |

**lcos16 enables the hardware gap pick-list on lcos15.** USB Ethernet and tethering (CDC-MBIM, CDC-EEM, LAN78xx, SMSC95xx/75xx, QMI, Huawei CDC-NCM), AMD pinctrl/GPIO and SOF/ACP audio (Renoir through ACP70, HDA CS35L41/CS35L56/TAS2781 scodecs), Type-C TCPCI/TPS6598x/FUSB302/ANX7411/RT1719/CCGx and the named muxes, Wacom/Elan/Goodix/maXTouch/RMI4, Intel ISH and HID sensors, WWAN (MHI PCI generic, IOSM, t7xx) plus USB serial and ACM, the MT76/rtw88/rtw89 USB and older Wi-Fi/BT tail, Apple backlight/gmux/Cinema Display/MFi/IR, Intel NPU (`DRM_ACCEL_IVPU`) and AMD ACP/ISP, VirtualBox guest (`VBOXGUEST`, `VBOXSF_FS`), `VFIO=m` and `VHOST_NET=m`, and the named laptop WMI, MEI, NVMe hwmon, and NFC options. lcos15's ASIX, CDC-NCM, TUN, and KVM modules stay on. `SND_AMD_ASOC_ACP7X` and `VBOXSF` do not exist on Linux 7.2.6. Proprietary NVIDIA is not added. No Forced Rust (`# CONFIG_RUST is not set`). `CONFIG_LOCALVERSION="-lunduke"`. lcos12, lcos13, lcos14, and lcos15 stay frozen. No ISO bake and no apt publish from the builder.

## Build (2026-10-07)

lcos16 was built on the LCOS builder from this repo's `master` at
`76140928c5ff521057cc70ea12e6e0a681932273` (PR #7 merge) with
`scripts/build-lunduke-kernel.sh` and `scripts/build-metapackage.sh`.
`configs/lunduke-7.2.6-lcos16.config` was used unchanged.

- Upstream: `linux-7.2.6.tar.xz`, sha256 `039aef84f2b0994aeda3f4fcfc3d02ec9d7a9bbb9020ea264c43f446c860f606` (matches kernel.org), clean tree, `JOBS=6`
- Build window: 2026-10-07 1:59 PM to 2:14 PM CT (exit 0)
- `uname -r`: `7.2.6-lunduke`, build string `#lcos16 SMP PREEMPT_DYNAMIC Wed Oct 7 14:13:12 CDT 2026`
- Modules: **933** `.ko` in the image deb (lcos12 shipped 551)
- Packaged `/boot/config-7.2.6-lunduke` matches `configs/lunduke-7.2.6-lcos16.config` apart from toolchain probe lines. `CONFIG_RUST` is not enabled.

| Deb | Version | SHA256 |
|-----|---------|--------|
| `linux-image-7.2.6-lunduke_7.2.6-lcos16_amd64.deb` | 7.2.6-lcos16 | `bdcbdb1b5db82859ba29f7186b72dc1ae37d082a9328f462686278f7b47d2992` |
| `linux-headers-7.2.6-lunduke_7.2.6-lcos16_amd64.deb` | 7.2.6-lcos16 | `de31fcca42fa03213c2c2ff2d6c3a62ea7b6ae8b834e60278e725949973f4511` |
| `lunduke-linux-kernel_7.2.6-lcos16_all.deb` | 7.2.6-lcos16 | `b9c91bfdfe3c23ed6d3c56239b544bdc3231a2bb58ea95d43fa72b5aef95cd18` |
| `linux-libc-dev_7.2.6-lcos16_amd64.deb` (not seeded) | 7.2.6-lcos16 | `4d09553764250554e5ce8cdebc10f13d62971905e5abff211b9a505e3032b79a` |

The image, headers, and metapackage debs are seeded in the LCOS 0.9 live-build
recipe (`BryanLunduke/lcos-live`, `config/packages.chroot/`), replacing lcos12.
Debs are not committed to this repo.
