# 7.2.6-lcos25 build (2026-10-15)

Config: lcos24 + LCOS#149 and kernel#14 (editor 2026-10-15 CT):
`CONFIG_UDF_FS=m`, `CONFIG_LEDS_CLASS_FLASH=m`, `CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y`
(bool, cannot be =m). `CONFIG_LEDS_CLASS_MULTICOLOR=m` was already on.
See `docs/config-lcos24-to-lcos25.diff`. No Forced Rust.
The built `/boot/config-7.2.6-lunduke` is byte-identical to
`configs/lunduke-7.2.6-lcos25.config`.

Built from a fresh kernel.org linux-7.2.6.tar.xz (sha256 039aef84…f606) unpacked
into a new tree, with `scripts/build-lunduke-kernel.sh` (JOBS=6, under
`cpulimit -l 600 -m`, KBUILD_BUILD_VERSION=lcos25) and `scripts/build-metapackage.sh`.
`uname -v`: `#lcos25 SMP PREEMPT_DYNAMIC Thu Oct 15 23:32:15 CDT 2026`.
Modules: **1017** .ko (lcos24: 1015), +2 (udf, led-class-flash).

```
e22b8367b427fff5ecb369a523b3713ba8f03d9a0a749c774799ab26935f4abb  linux-headers-7.2.6-lunduke_7.2.6-lcos25_amd64.deb
93186bedb6e05bda6ea5fc46f2726e9abb4337464cdc208d0699f910829648e9  linux-image-7.2.6-lunduke_7.2.6-lcos25_amd64.deb
577d26be9e9663b7e39c8c541e2f68d999f608974ec12eeebe8dc3ca6916ef36  linux-libc-dev_7.2.6-lcos25_amd64.deb
9f22c047510bf6f383939397b37ebf3fb4d4dbdd7608978c9c8d71b34004ca0b  lunduke-linux-kernel_7.2.6-lcos25_all.deb
```

Debs: `/workspace/lcos-kernel/debs-lcos25/`. Not seeded, not published.
PR must be merged on editor order before seeding into lcos-live.
