# Next LLK build

| Item | Value |
|------|--------|
| Version | `7.2.6-lcos24` |
| Config | `configs/lunduke-7.2.6-lcos24.config` |
| Why | Ubuntu 26.10 hardware gap: Intel IPU cameras, Logitech/gamepad, PMC thermal, Zen6/Nova Lake extras |
| Delta | `docs/config-lcos23-to-lcos24.diff` |
| Build notes | `docs/lcos24-build.md` |
| Base | lcos23 (`configs/lunduke-7.2.6-lcos23.config`, merge 049986eb, PR #19) |

**lcos24 on lcos23.** Ubuntu 26.10 gap items 1–3, 6, 13 (editor 2026-10-15): IPU3/IPU6+VSC+sensors, Logitech HID++/Unifying, joydev/xpad/Steam HID, Intel PMC/PCH thermal, AMD_HSMP + TAC5XX2, ACPI_ALS. `INPUT_AMD_SFH_TABLETMODE` absent in 7.2.6 (skipped). No Forced Rust. `CONFIG_LOCALVERSION="-lunduke"`.
