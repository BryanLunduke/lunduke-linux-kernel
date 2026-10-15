# Next LLK build

| Item | Value |
|------|--------|
| Version | `7.2.6-lcos23` |
| Config | `configs/lunduke-7.2.6-lcos23.config` |
| Why | LCOS#141: Acer C720 (Peppy) / Haswell Chromebook touchpad |
| Delta | `docs/config-lcos22-to-lcos23.diff` |
| Build notes | `docs/lcos23-build.md` |
| Base | lcos22 (`configs/lunduke-7.2.6-lcos22.config`, merge 1f5d4e6, PR #18) |

**lcos23 on lcos22.** Requested: `CONFIG_CHROMEOS_LAPTOP=m` (creates the I2C touchpad/light-sensor devices that stock Chromebook firmware doesn't describe in ACPI) and `CONFIG_MOUSE_CYAPA=m` (Cypress APA touchpad, module cyapatp). olddefconfig pulled in nothing else, because `CRC_ITU_T` was already =m and Elan I2C was already =m. No Forced Rust. `CONFIG_LOCALVERSION="-lunduke"`.
