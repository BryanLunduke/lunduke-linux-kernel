# 7.2.6-lcos23 build (2026-10-14)

Config: lcos22 + `CONFIG_CHROMEOS_LAPTOP=m` and `CONFIG_MOUSE_CYAPA=m` (LCOS#141, Acer C720 "Peppy" and other 2013-era Chromebook touchpads).
No extra dependencies were needed. `CRC_ITU_T` (selected by CYAPA) was already =m. `I2C`, `DMI`, `I2C_DESIGNWARE_PLATFORM/PCI`, `I2C_I801`, `CHROME_PLATFORMS` and `MOUSE_ELAN_I2C` were already set. olddefconfig changed nothing else (see config-lcos22-to-lcos23.diff). The built `/boot/config-7.2.6-lunduke` is byte-identical to `configs/lunduke-7.2.6-lcos23.config`.

Built from a fresh kernel.org linux-7.2.6.tar.xz (sha256 039aef84…f606) with `scripts/build-lunduke-kernel.sh` (JOBS=4, under `cpulimit -l 400 -m`) and `scripts/build-metapackage.sh`. Debian gcc 14.2.0-19.
`uname -v`: `#lcos23 SMP PREEMPT_DYNAMIC Wed Oct 14 21:07:30 CDT 2026`. Modules: 957 .ko (lcos22: 955), +2: chromeos_laptop, cyapatp (the cyapa driver's module name).

modinfo:
- chromeos_laptop: DMI aliases incl. `pn*Peppy*` (Acer C720), Samus, Celes, etc. No module dependencies.
- cyapatp: "Cypress APA I2C Trackpad Driver", aliases `i2c:cyapa` and `acpi*:CYAP000[0-2]`. Depends on crc-itu-t.

Tests (QEMU TCG, q35, busybox initramfs plus the lcos23 kernel):
- Plain QEMU: cyapatp, crc_itu_t and elan_i2c load. chromeos_laptop correctly refuses to load (ENODEV, not a Chromebook).
- Spoofed SMBIOS (`manufacturer=GOOGLE,product=Peppy`): chromeos_laptop matches the C720 entry, then stops at "failed to find DMI device 'touchscreen'". That is expected because QEMU has no C720 on-board devices or designware I2C buses.
- No oops, panic or call trace. Real C720 hardware is still needed for an actual touchpad test.
Logs: lcos23-qemu-boot.log, lcos23-qemu-peppy.log (builder logs dir).

```
440bd0ae9da3e1b94031319197f113d71c322a1e8f872a5a9a85bce0f840781b  linux-headers-7.2.6-lunduke_7.2.6-lcos23_amd64.deb
52e1e8d1f76d28cad3a222882d807c1704f0bef037fcda26d287b31ee93e9f1f  linux-image-7.2.6-lunduke_7.2.6-lcos23_amd64.deb
a439c6e336e9e5ec1a3b7f643aa2e6a5db719b9bc1c90dc553983f7a5a5f4452  linux-libc-dev_7.2.6-lcos23_amd64.deb
3a17600d88082b69ece21c2aa1316b93162b5357189c93ecf1f7425288508bd2  lunduke-linux-kernel_7.2.6-lcos23_all.deb
```

Not seeded, not published.
