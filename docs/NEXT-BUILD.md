# Next LLK build

| Item | Value |
|------|--------|
| Version | `7.2.6-lcos8` |
| Config | `configs/lunduke-7.2.6-lcos8.config` |
| Why | GitHub LCOS#81 — enable RTL8187/RTL8187B USB Wi-Fi (Distro has it) |
| Delta | `docs/config-lcos7-to-lcos8.diff` |
| Base | lcos7 (high-impact HW modules) |

**lcos8 is this RTL8187 pass.** No ISO bake and no apt publish from the builder unless separately greenlit. Stage debs for editor sign.
