# 7.2.15-lcos31 build (2026-11-03), for LCOS 1.0.1

Editor approvals (2026-11-03 CT): 21:31, driver modules for LCOS#182, #183, #184, #187; 21:40, INTEL_SKL_INT3472
plus the easy-modules batch from the 7.2 hardware survey (items 5-22, plus CONFIGFS_FS/USB4_CONFIGFS/USB4_STREAM).

**Upstream:** Linux 7.2.15, same as lcos30. No source patches. Kernel release stays `7.2.15-lunduke`.
**Config:** `configs/lunduke-7.2.15-lcos31.config` = lcos30 + the options below, then `olddefconfig`. Full delta:
`docs/config-lcos30-to-lcos31.diff`.

- #182 Synaptics RMI4 HID touchpads: HID_RMI=m, RMI4_I2C=m (RMI4_CORE, F11, F12, F30 were already on).
- #183 Intel 10GbE: IXGBE=m, IXGBEVF=m (+IXGBE_HWMON=y, PLDMFW=y built-in bool, LIBIE_ADMINQ/LIBIE_FWLOG=m). IXGBE_DCB stays off (DCB is off).
- #184 libvirt traffic control: NET_SCH_HTB/TBF/INGRESS/FQ_CODEL/SFQ, NET_CLS_U32/FLOWER/FW, NET_ACT_CSUM/GACT/MIRRED/POLICE=m.
  NET_SCHED, NET_CLS_ACT, BRIDGE, NF_TABLES, NAT/MASQUERADE, XT CHECKSUM were already on.
- #187 b44 + Intel 3945/4965: B44=m (+FIXED_PHY m, B44_PCI y; SSB already m), IWLEGACY/IWL3945/IWL4965=m.
  Firmware iwlwifi-3945-2.ucode / iwlwifi-4965-2.ucode is in firmware-iwlwifi (already in the ISO package list).
- Survey batch: INTEL_SKL_INT3472, SENSORS_DRIVETEMP, SENSORS_SPD5118, INTEL_UNCORE_FREQ_CONTROL, INTEL_TPMI,
  HID_ASUS, HID_ALPS, HID_PLAYSTATION, HID_NINTENDO, HID_VIVALDI, AQTION, I40E, USB_IPHETH, MISC_ALCOR_PCI (+MMC_ALCOR),
  MMC_CB710, TOUCHSCREEN_GOODIX_BERLIN_I2C, TOUCHSCREEN_ILITEK, HID_LENOVO_GO, HID_LENOVO_GO_S, HID_OXP, SENSORS_YOGAFAN,
  LENOVO_WMI_GAMEZONE, ASUS_ARMOURY, RTASE, USB4_CONFIGFS, USB4_STREAM =m; INTEL_HFI_THERMAL, DRM_PANIC, CONFIGFS_FS =y.
  Not added: IPU7/CVS, ICE, SILEAD, TPS68470 PMIC pieces (left n).

**Checks:** `/boot/config-7.2.15-lunduke` in the image deb is byte-identical to the config. 1088 .ko (lcos30: 1027).
QEMU (q35, TCG) smoke boot, SeaBIOS and OVMF: boots, zram works, 27 new/dependency modules insmod cleanly
(tc, b44, iwlegacy/3945/4965, hid-rmi, ixgbe, i40e, hid-asus and deps). Not tested on real hardware.

```
f5f358435632ee05b41a83875fd624e1d6cf00f29dcba4dba46e6c0c5bd5f628  linux-image-7.2.15-lunduke_7.2.15-lcos31_amd64.deb
9519b4cfd53fcafcbcd91b9384369f354d4d4579fd7398def7d6c351262bb0f5  linux-headers-7.2.15-lunduke_7.2.15-lcos31_amd64.deb
4da46780282b9bf3ddf8fa73bf6dec4e53fd54dd4c72cfeecbb9fa33c136f4f1  lunduke-linux-kernel_7.2.15-lcos31_all.deb
```
Debs not committed. No apt publish.
