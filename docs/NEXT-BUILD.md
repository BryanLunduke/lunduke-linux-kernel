# Next LLK build

| Item | Value |
|------|--------|
| Version | `7.2.6-lcos16` |
| Config | `configs/lunduke-7.2.6-lcos16.config` |
| Why | LCOS 0.9 hardware gap pick-list (items 1–53) on frozen lcos15 |
| Delta | `docs/config-lcos15-to-lcos16.diff` |
| Verify | `docs/lcos16-module-verify.txt` |
| Base | lcos15 (`configs/lunduke-7.2.6-lcos15.config`, merge 2192009) |

**lcos16 enables the hardware gap pick-list on lcos15.** USB Ethernet and tethering (CDC-MBIM, CDC-EEM, LAN78xx, SMSC95xx/75xx, QMI, Huawei CDC-NCM), AMD pinctrl/GPIO and SOF/ACP audio (Renoir through ACP70, HDA CS35L41/CS35L56/TAS2781 scodecs), Type-C TCPCI/TPS6598x/FUSB302/ANX7411/RT1719/CCGx and the named muxes, Wacom/Elan/Goodix/maXTouch/RMI4, Intel ISH and HID sensors, WWAN (MHI PCI generic, IOSM, t7xx) plus USB serial and ACM, the MT76/rtw88/rtw89 USB and older Wi-Fi/BT tail, Apple backlight/gmux/Cinema Display/MFi/IR, Intel NPU (`DRM_ACCEL_IVPU`) and AMD ACP/ISP, VirtualBox guest (`VBOXGUEST`, `VBOXSF_FS`), `VFIO=m` and `VHOST_NET=m`, and the named laptop WMI, MEI, NVMe hwmon, and NFC options. lcos15's ASIX, CDC-NCM, TUN, and KVM modules stay on. `SND_AMD_ASOC_ACP7X` and `VBOXSF` do not exist on Linux 7.2.6. Proprietary NVIDIA is not added. No Forced Rust (`# CONFIG_RUST is not set`). `CONFIG_LOCALVERSION="-lunduke"`. lcos12, lcos13, lcos14, and lcos15 stay frozen. No kernel debs were built. No ISO bake.
