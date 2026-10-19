# 7.2.6-lcos28 build (2026-10-19)

Config: lcos27 + Apple SPI keyboard and trackpad (editor 2026-10-19 CT):
`CONFIG_KEYBOARD_APPLESPI=m` (module `applespi`, `alias acpi*:APP000D:*`). Needed for the
internal keyboard and trackpad on the 12-inch Retina MacBook (2015, MacBook8,1), which are
on SPI instead of USB; reported dead on LCOS 0.9.4. See `docs/config-lcos27-to-lcos28.diff`.
olddefconfig changed nothing else: the dependencies (`ACPI`, `EFI`, `SPI`, `X86`, `LEDS_CLASS`,
selects `CRC16`) were already on. No Forced Rust.
`CONFIG_LOCALVERSION="-lunduke"`: the kernel release stays `7.2.6-lunduke`, as in lcos4 through lcos27.
The built `/boot/config-7.2.6-lunduke` is byte-identical to `configs/lunduke-7.2.6-lcos28.config`.

SPI host side for MacBook8,1, already in lcos27: `X86_INTEL_LPSS=y` (ACPI LPSS enumeration),
`SPI_PXA2XX=m` (spi-pxa2xx-core + spi-pxa2xx-platform, ACPI INT33C0/INT33C1/INT3430/INT3431),
`SPI_PXA2XX_PCI=m` (LPSS PCI 0x9c65/0x9c66/0x9ce5/0x9ce6), `MFD_INTEL_LPSS{,_ACPI,_PCI}=m`,
`DW_DMAC_PCI=y`, `PINCTRL_LYNXPOINT=m`. initramfs-tools `MODULES=most` copies
`drivers/input/keyboard`, `drivers/spi` and `drivers/mfd`, so the keyboard is also available at
an encrypted-disk passphrase prompt.

Packaging is unchanged from lcos27 (same package names, metapackage `--root-owner-group`).
The image deb differs from lcos27 only by `kernel/drivers/input/keyboard/applespi.ko`.

Built from a fresh kernel.org linux-7.2.6.tar.xz (sha256 039aef84…f606) unpacked
into a new tree, with `scripts/build-lunduke-kernel.sh` (JOBS=6, nice 10,
KBUILD_BUILD_VERSION=lcos28) and `scripts/build-metapackage.sh`.
`uname -r`: `7.2.6-lunduke`. `uname -v`: `#lcos28 SMP PREEMPT_DYNAMIC Mon Oct 19 11:44:16 CDT 2026`.
Modules: **1021** .ko (lcos27: 1020), +1 (applespi).

```
e732e1b1c5bf2c28d040229f990f04c852c5159e651520b6d2dfa631a312359d  linux-headers-7.2.6-lunduke_7.2.6-lcos28_amd64.deb
4a1bcdf2a2bc25b2dcfefed4138ed9565e94e5e0b79f7b50e1f202166b30d0b8  linux-image-7.2.6-lunduke_7.2.6-lcos28_amd64.deb
da4b65232d7e91433a048ead5359495c996b2032ca9726b6bd4ae69c5b03f2c2  linux-libc-dev_7.2.6-lcos28_amd64.deb
a60ffd028ff745dbd9898dcbad7ecf0006ce5c688bb6299d1c06f1c6d836e816  lunduke-linux-kernel_7.2.6-lcos28_all.deb
```

Not tested on MacBook8,1 hardware.
