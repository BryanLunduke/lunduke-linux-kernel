# 7.2.15-lcos32 build (2026-11-04), for LCOS 1.0.1

Editor approval (2026-11-04 CT): go for the queued 1.0.1 changes, including ACPI_SBS=m for LCOS#191.

**Upstream:** Linux 7.2.15, same as lcos31. No source patches. Kernel release stays `7.2.15-lunduke`.
**Config:** `configs/lunduke-7.2.15-lcos32.config` = lcos31 + `CONFIG_ACPI_SBS=m`, then `olddefconfig`.
Full delta: `docs/config-lcos31-to-lcos32.diff` (one line: ACPI_SBS n -> m).

- #191 MacBook Air 2014 battery: ACPI Smart Battery System, modules `sbs` and `sbshc`.
  Kconfig: `depends on X86 && ACPI_EC`, `select POWER_SUPPLY`. ACPI_EC=y and POWER_SUPPLY=y were already set,
  so no other option changed. ACPI_BATTERY=y and ACPI_AC=y stay as they were.
- No 7.3/7.4 (LCOS 1.1) configs exist in this repo yet, so nothing else was changed. Add ACPI_SBS=m when they are created.

**Checks:** `/boot/config-7.2.15-lunduke` in the image deb is byte-identical to the config. 1090 .ko (lcos31: 1088,
+sbs.ko, +sbshc.ko in kernel/drivers/acpi/). Meta deb: Version 7.2.15-lcos32, Depends linux-image-7.2.15-lunduke (= 7.2.15-lcos32).
QEMU (q35, TCG) direct-kernel smoke boot with a busybox initrd, SeaBIOS and OVMF: boots, zram with zstd works,
`sbshc` then `sbs` insmod cleanly (both Live in /proc/modules, sbs uses sbshc). QEMU has no SBS device, so the
battery driver binding was not exercised. Not tested on real hardware (needs a 2014 MacBook Air).

```
ba3bca9ec3b83d180a75fede25d19dd52188518187d599a4147781a024cc585b  linux-image-7.2.15-lunduke_7.2.15-lcos32_amd64.deb
ab01ea081f36d9f5e31a4a8074db844f564bdf0fcbef18f3d8ec58a97de2fdf1  linux-headers-7.2.15-lunduke_7.2.15-lcos32_amd64.deb
eed97b32b45640412773615ab47c7901beca8b9372d10b4ed963c9fd8ed9ed0c  lunduke-linux-kernel_7.2.15-lcos32_all.deb
```
Debs not committed. No apt publish. Not tagged, not seeded into lcos-live.
