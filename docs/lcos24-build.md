# 7.2.6-lcos24 build (2026-10-15)

Config: lcos23 + Ubuntu 26.10 hardware gap items 1–3, 6, 13 (editor 2026-10-15 CT):
Intel IPU3/IPU6+VSC+sensors, Logitech HID++/Unifying, joydev/xpad/Steam HID,
Intel PMC/PCH thermal, AMD_HSMP + TAC5XX2, ACPI_ALS. See
`docs/config-lcos23-to-lcos24.diff`. `INPUT_AMD_SFH_TABLETMODE` and
`VIDEO_IMX471` are absent in 7.2.6 and were skipped. No Forced Rust.
The built `/boot/config-7.2.6-lunduke` is byte-identical to
`configs/lunduke-7.2.6-lcos24.config`.

Built from a fresh kernel.org linux-7.2.6.tar.xz (sha256 039aef84…f606) with
`scripts/build-lunduke-kernel.sh` (JOBS=3, under `cpulimit -l 400 -m`) and
`scripts/build-metapackage.sh`. Debian gcc 14.2.0-19.
`uname -v`: `#lcos24 SMP PREEMPT_DYNAMIC Thu Oct 15 15:13:34 CDT 2026`.
Modules: **1015** .ko (lcos23: 957), +58.

```
24fcfcc61307aeb2459c8f831660e290761234508634cbf9af64e5b20f6bba8f  linux-headers-7.2.6-lunduke_7.2.6-lcos24_amd64.deb
7772dc6a3a4b0c149ba4055926adc9ce623b30c687d5f86aca1dabf37342a6e1  linux-image-7.2.6-lunduke_7.2.6-lcos24_amd64.deb
cc1bfa746a0a7ed6f619e8040cae0cb7854b72ab3ba44796d91a3e0d5736e37e  linux-libc-dev_7.2.6-lcos24_amd64.deb
46263988518cd685ba479c0bbd72c3d4d6ce6b831aa76ae40eb7ffdcf2f97e44  lunduke-linux-kernel_7.2.6-lcos24_all.deb
```

Debs: `/workspace/lcos-kernel/debs-lcos24/`. Not seeded, not published.
PR must be merged on editor order before seeding into lcos-live.
