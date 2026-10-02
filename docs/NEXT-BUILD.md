# Next LLK build

| Item | Value |
|------|--------|
| Version | `7.2.6-lcos11` |
| Config | `configs/lunduke-7.2.6-lcos11.config` |
| Why | 12 "worth adding next" HW gaps (USB4/Type-C, VMXNET3/VMCI, Hyper-V, UAS, laptop WMI, Apple/Lenovo/MS HID, virtio balloon/mmio/fs, TPM, BRCMSMAC, MWIFIEX) |
| Delta | `docs/config-lcos10-to-lcos11.diff` |
| Base | lcos10 (`configs/lunduke-7.2.6-lcos10.config`) |

**lcos11 is the HW-gaps pass on lcos10.** No Forced Rust (`# CONFIG_RUST is not set`). No ISO bake and no apt publish from the builder unless separately greenlit. Stage debs for editor sign.
