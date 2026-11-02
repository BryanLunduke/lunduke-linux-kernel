# Next LLK build

| Item | Value |
|------|--------|
| Version | `7.2.15-lcos30` (LCOS 1.0.1) |
| Upstream | Linux 7.2.15 (final 7.2.y) |
| Config | `configs/lunduke-7.2.15-lcos30.config` |
| Why | LCOS 1.0.1: latest 7.2 stable, ES1371 sound, Intel THC touchscreens (Dell XPS 13 DX13260), haptic touchpads, ZRAM |
| Delta | `docs/config-lcos28-to-lcos30.diff` |
| Build notes | `docs/lcos30-build.md` |
| Base | lcos28 + lcos29 (`SND_ENS1371=m`, PR #25, merge fddd878) |

**lcos30 on lcos28.** New kernel release `7.2.15-lunduke`, so the packages install beside `7.2.6-lunduke` (boot fallback). Options: `SND_ENS1371=m`, `INTEL_THC_HID=m`, `INTEL_QUICKI2C=m`, `INTEL_QUICKSPI=m`, `HID_HAPTIC=y`, `ZRAM=m` (`ZSMALLOC=m`, zstd default). olddefconfig on 7.2.15 also adds the compiler-detected `CC_OPT_INLINE_MEMSET`. No source patches. No Forced Rust. Kernel 7.4 is planned for LCOS 1.1 (not started).

## Previous: 7.2.6-lcos28

| Item | Value |
|------|--------|
| Version | `7.2.6-lcos28` |
| Config | `configs/lunduke-7.2.6-lcos28.config` |
| Why | Internal keyboard and trackpad on the 12-inch Retina MacBook (2015, MacBook8,1), which are on SPI, not USB |
| Delta | `docs/config-lcos27-to-lcos28.diff` |
| Build notes | `docs/lcos28-build.md` |
| Base | lcos27 (`configs/lunduke-7.2.6-lcos27.config`, merge bb839085, PR #23) |

**lcos28 on lcos27.** `CONFIG_KEYBOARD_APPLESPI=m` (module `applespi`, ACPI HID `APP000D`). Its dependencies (`ACPI`, `EFI`, `SPI`, `X86`, `LEDS_CLASS`; selects `CRC16`) were already on, so olddefconfig changed nothing else. The SPI host side for MacBook8,1 was already built: `SPI_PXA2XX=m` (spi-pxa2xx-core and spi-pxa2xx-platform, ACPI INT33C0/INT33C1/INT3430/INT3431), `SPI_PXA2XX_PCI=m` (Lynx/Wildcat Point LPSS 0x9c65/0x9c66/0x9ce5/0x9ce6), `X86_INTEL_LPSS=y`, `MFD_INTEL_LPSS*=m`, `DW_DMAC_PCI=y`. Packaging unchanged from lcos27 (metapackage `--root-owner-group`). No Forced Rust. `CONFIG_LOCALVERSION="-lunduke"`.

lcos26 (PR #22) was an experiment with a per-build kernel release (`7.2.6-lunduke-lcos26`). It was backed out in lcos27; lcos27 and lcos28 use the single `7.2.6-lunduke` name used by lcos4 through lcos25. lcos26 is not a base for later builds.
