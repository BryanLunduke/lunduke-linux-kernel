# 7.2.6-lcos20 build (2026-10-11)

Config: lcos19 + `CONFIG_EXFAT_FS=m`, `CONFIG_EXFAT_DEFAULT_IOCHARSET="utf8"` (LCOS#131).
olddefconfig on a clean linux-7.2.6 tree changed nothing else (see config-lcos19-to-lcos20.diff).
Modules: 949 .ko (lcos19: 948); only addition is fs/exfat/exfat.ko. RUST off, LOCALVERSION -lunduke.
Userspace tools: exfatprogs (LCOS package list).

```
8495d17977644081db0ce74ce943ee0f24b82145e54e05747a8b023229d3e2fe  linux-headers-7.2.6-lunduke_7.2.6-lcos20_amd64.deb
fa5dc26812f21e4b48481bbadb6886c1397ef2c1417e2d34fd55dc82ae266b1d  linux-image-7.2.6-lunduke_7.2.6-lcos20_amd64.deb
fb8c7f1368f4f95c6e5fb498baa78b494434bae1e7550e2d726cd71f5fd46c12  linux-libc-dev_7.2.6-lcos20_amd64.deb
d2dedd3725420cf5b7b6ddec8dc1aa9798e7501b7e6dfeeec5599ece6e9cecb3  lunduke-linux-kernel_7.2.6-lcos20_all.deb
```
Not seeded, not published.
