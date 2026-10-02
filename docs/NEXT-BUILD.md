# Next LLK build

| Item | Value |
|------|--------|
| Version | `7.2.6-lcos10` |
| Config | `configs/lunduke-7.2.6-lcos10.config` |
| Why | QEMU mouse-capture: enable `CONFIG_MOUSE_PS2_VMMOUSE=y` on recovered lcos9 (ISO lcos-live-08-01) |
| Delta | `docs/config-lcos8-to-lcos10.diff` (lcos9 was ISO-only/local; never pushed) |
| Base | recovered lcos9 from live-08-01 (`aa0a1ee7…73bbbd8d`) |

**lcos10 is the VMMOUSE pass on shipped lcos9.** No ISO bake and no apt publish from the builder unless separately greenlit. Stage debs for editor sign.
