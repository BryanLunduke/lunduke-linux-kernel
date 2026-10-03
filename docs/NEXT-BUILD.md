# Next LLK build

| Item | Value |
|------|--------|
| Version | `7.2.6-lcos13` |
| Config | `configs/lunduke-7.2.6-lcos13.config` |
| Why | Laptop hardware on frozen lcos12: Intel buses, SOF/ACP machines, USB Ethernet, hwmon/idle, in-tree Surface, vendor hotkeys |
| Delta | `docs/config-lcos12-to-lcos13.diff` |
| Base | lcos12 (`configs/lunduke-7.2.6-lcos12.config`, commit 5317e83) |

**lcos13 is the laptop-hardware pass on lcos12.** lcos12 shipped on LCOS 0.8 and stays frozen. No Forced Rust (`# CONFIG_RUST is not set`). No Rust Android binder. `CONFIG_PINCTRL_LUNARLAKE` and `CONFIG_PINCTRL_PANTHERLAKE` are not in Linux 7.2.6. `CONFIG_PINCTRL_INTEL_PLATFORM=m` is that generation's pinctrl driver (Lunar Lake, Nova Lake, Panther Lake). `CONFIG_SND_SOC_AMD_ACP7X` stays off. No ISO bake and no apt publish from the builder unless separately greenlit. Stage debs for editor sign.
