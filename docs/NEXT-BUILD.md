# Next LLK build

| Item | Value |
|------|--------|
| Version | `7.2.6-lcos7` |
| Config | `configs/lunduke-7.2.6-lcos7.config` |
| Why | Editor greenlit high-impact hardware modules (audio/Wi-Fi/BT/UVC/HID/touchpad/IGC+IGB) |
| Delta | `docs/config-lcos6-to-lcos7.diff` |
| Base | lcos6 (uinput + lcos5 netfilter) |

**lcos7 is this HW pass.** No ISO bake and no apt publish from the builder unless separately greenlit. Package debs for Chloe to seed.
