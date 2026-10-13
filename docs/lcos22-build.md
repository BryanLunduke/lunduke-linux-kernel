# 7.2.6-lcos22 build (2026-10-13)

Config: lcos21 + `CONFIG_RTW89_8852CU=m`, `CONFIG_RTW89_8852BU=m`, `CONFIG_RTW89_8851BU=m`, `CONFIG_RTW89_8922AU=m`, `CONFIG_RTW88_8814AE=m` (LCOS#138). RTW88 SDIO variants stay off.
olddefconfig changed nothing else (see config-lcos21-to-lcos22.diff). Built `.config` is byte-identical to `configs/lunduke-7.2.6-lcos22.config`.
Built with `scripts/build-lunduke-kernel.sh` (JOBS=4, under `cpulimit -l 400 -m`) and `scripts/build-metapackage.sh`. Debian gcc 14.2.0-19, binutils 2.44.
`uname -v`: `#lcos22 SMP PREEMPT_DYNAMIC Tue Oct 13 14:22:47 CDT 2026`. Modules: 955 .ko (lcos21: 950); +5: rtw89_8852cu, rtw89_8852bu, rtw89_8851bu, rtw89_8922au, rtw88_8814ae.

USB/PCI IDs (modinfo): 8852cu 12 USB IDs incl. TP-Link 35bc:0101, 35bc:0102 and Realtek 0bda:c832/c85a/c85d; 8852bu 15 (incl. TP-Link 35bc:0100/0108); 8851bu 6; 8922au 15; 8814ae PCI 10ec:8813.

Firmware (modinfo lists the newest format; rtw89 falls back to older formats, fw.c):

| Module | Requests (newest) | firmware-realtek 20250410-2 (ISO) | 20260810-1~bpo13+1 (backports) |
|---|---|---|---|
| rtw89_8852c | rtw8852c_fw-2.bin | has -1, base (fallback) | has -2 |
| rtw89_8852b | rtw8852b_fw-2.bin | has -1, base (fallback) | has -2 |
| rtw89_8851b | rtw8851b_fw-1.bin | base only (fallback) | has -1 |
| rtw89_8922a | rtw8922a_fw-4.bin | up to -3 (fallback) | has -4 |
| rtw88_8814a | rtw8814a_fw.bin | yes | yes |

Tests: QEMU (TCG, q35, NVMe root, LCOS 0.9.3 userspace + lcos22 kernel/initramfs): boots to runlevel 2 with lightdm; modprobe of all five modules OK (lsmod shows rtw89_usb/core and chip cores). No oops/panic/call trace. No real adapter attached (needs hardware for association test).

```
e8d6b1a10cc9526f2189f298b6ec68db391d3e44965e286e801775ebedfa161a  linux-headers-7.2.6-lunduke_7.2.6-lcos22_amd64.deb
c0ef9fb0ff94d20e518b03d6740bb2acb738389d6bdbbaa40e6c5b087e33ac48  linux-image-7.2.6-lunduke_7.2.6-lcos22_amd64.deb
8e9098e60a4765f7be6158b5c4be312041a4ae81d87db73e9d84a4358e76de46  linux-libc-dev_7.2.6-lcos22_amd64.deb
1bc2eea4134ace59935c85bf75b5e4b65666a381d49ebb4cab5439587082a6b7  lunduke-linux-kernel_7.2.6-lcos22_all.deb
```

Not seeded, not published.
