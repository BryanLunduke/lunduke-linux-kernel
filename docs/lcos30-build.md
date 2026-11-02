# 7.2.15-lcos30 build (2026-11-02), for LCOS 1.0.1

Editor order (2026-11-02 CT): move LCOS 1.0.1 to the latest 7.2.y kernel.org stable
with the lcos28 config plus a short list of hardware options. Kernel 7.4 waits for LCOS 1.1.

**Upstream:** Linux **7.2.15** (kernel.org, 2026-11-01). It is the final 7.2.y: releases.json
marks 7.2 end of life, and there is no 7.2.16. Tarball `linux-7.2.15.tar.xz`, sha256
`d0f6b1d7324c937ccaeb5c4ca7084bfcf71db2edb3e2d3a31f0ad83a681809ab`, which matches kernel.org
`sha256sums.asc`. The PGP signature was not checked in this build.

**Kernel release:** `7.2.15-lunduke`. This is a new package name
(`linux-image-7.2.15-lunduke`, `linux-headers-7.2.15-lunduke`), so it installs **beside**
`7.2.6-lunduke`. The old kernel stays in GRUB "Advanced options" as a fallback.

**Config:** `configs/lunduke-7.2.15-lcos30.config` = lcos28 + lcos29 (PR #25) + the 1.0.1
options, then `olddefconfig` on 7.2.15. No source patches. No Forced Rust (`# CONFIG_RUST is not set`).

| Option | lcos28 | lcos30 | Why |
|---|---|---|---|
| `SND_ENS1371` | n | m | Ensoniq AudioPCI 97 / Sound Blaster PCI64/128 and VMware's emulated card (lcos29, PR #25) |
| `INTEL_THC_HID` | n | m | Intel Touch Host Controller (Lunar Lake / Panther Lake / Wildcat Lake touchscreens, e.g. Dell XPS 13 DX13260) |
| `INTEL_QUICKI2C` | (new) | m | THC HID-over-I2C |
| `INTEL_QUICKSPI` | (new) | m | THC HID-over-SPI |
| `HID_HAPTIC` | n | y | Haptic touchpads (built into hid-multitouch, bool) |
| `ZRAM` | n | m | Compressed RAM swap; `ZRAM_BACKEND_ZSTD=y`, default `zstd` |
| `ZSMALLOC` | (new) | m | Selected by ZRAM; `ZSMALLOC_CHAIN_SIZE=8` default |
| `CC_OPT_INLINE_MEMSET` | (new) | `-finline-stringops=memset` | Compiler-detected by 7.2.15 Kconfig on GCC 14.2; not a choice. The only change olddefconfig made to plain lcos28 on 7.2.15 |

ZRAM sub-options left at defaults (off): other compression backends, `ZRAM_MULTI_COMP`,
`ZRAM_WRITEBACK`, `ZRAM_MEMORY_TRACKING`, `ZRAM_TRACK_ENTRY_ACTIME`, `ZSMALLOC_STAT`.
No option was removed. Full delta: `docs/config-lcos28-to-lcos30.diff`.

**Toolchain:** GCC 14.2 (`CONFIG_GCC_VERSION=140200`), binutils 2.44 (`LD_VERSION=24400`),
pahole 1.30. Built with `scripts/build-lunduke-kernel.sh` (JOBS=6, nice 10,
KBUILD_BUILD_VERSION=lcos30) and `scripts/build-metapackage.sh`, 15:12 to 15:24 CST.

**Checks:**
- `/boot/config-7.2.15-lunduke` in the image deb is byte-identical to `configs/lunduke-7.2.15-lcos30.config`.
- Modules: **1027** .ko (lcos28: 1021). The 6 new ones: `snd-ens1371`, `intel-thc`, `intel-quicki2c`, `intel-quickspi`, `zram`, `zsmalloc`.
- `uname -r` `7.2.15-lunduke`, `uname -v` `#lcos30 SMP PREEMPT_DYNAMIC Mon Nov 2 15:23:27 CST 2026`.
- QEMU (q35, TCG) smoke boot through GRUB 2.12 from a `grub-mkrescue` ISO, with a busybox
  initramfs: **BIOS (SeaBIOS) and UEFI (OVMF) both boot**, run init, load `zsmalloc` + `zram`,
  create a 64M zram0 with `zstd`, and power off cleanly. This does not test the full LCOS live
  ISO (that is the lcos-live bake).

**Panel Replay (Dell XPS 13 DX13260 judder):** no kernel change. LCOS 1.0.1 adds
`xe.enable_panel_replay=0` from GRUB only when SMBIOS type-1 SKU is `0E53` (lcos-base
`/etc/grub.d/05_lcos_quirks` and the live ISO GRUB). See lcos-live.

```
a788b1417f8c53afead912923d2f2f40cfb9c61e4e5a23294a7dba19a74445fc  linux-image-7.2.15-lunduke_7.2.15-lcos30_amd64.deb
6c38bc60323ad211c47df1f070a9f320aff31708d18843bf14e5408c8e2c9d50  linux-headers-7.2.15-lunduke_7.2.15-lcos30_amd64.deb
4f37368495c59fe17c681aadcdb8e338bbb88e514ea4d68432df3fe3967575a0  lunduke-linux-kernel_7.2.15-lcos30_all.deb
```

Debs are not committed here (seeded in lcos-live for testing). No apt publish.
