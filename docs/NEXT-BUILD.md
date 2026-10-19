# Next LLK build

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
