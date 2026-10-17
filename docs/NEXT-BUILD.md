# Next LLK build

| Item | Value |
|------|--------|
| Version | `7.2.6-lcos25` |
| Config | `configs/lunduke-7.2.6-lcos25.config` |
| Why | LCOS#149 UDF discs; kernel#14 TUXEDO keyboard LEDs (tuxedo-drivers) |
| Delta | `docs/config-lcos24-to-lcos25.diff` |
| Build notes | `docs/lcos25-build.md` |
| Base | lcos24 (`configs/lunduke-7.2.6-lcos24.config`, merge 295e3550, PR #20) |

**lcos25 on lcos24.** `CONFIG_UDF_FS=m` (#149), `CONFIG_LEDS_CLASS_FLASH=m` and `CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y` (kernel#14; `CONFIG_LEDS_CLASS_MULTICOLOR=m` was already on). The reporter asked for all three `=y`; tuxedo-drivers are out-of-tree DKMS modules, so the two class modules (multicolor, flash) can stay `=m` and are pulled in by module dependencies. `LEDS_BRIGHTNESS_HW_CHANGED` is a bool in Kconfig, so it can only be `=y`. olddefconfig added nothing else (new flash-LED chip drivers and `V4L2_FLASH_LED_CLASS` stay off). No Forced Rust. `CONFIG_LOCALVERSION="-lunduke"`.
