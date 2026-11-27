# 7.3.6-lcos34 build (2026-11-27), for LCOS 1.1 (development)

Editor direction (2026-11-27 CT): start moving LCOS 1.1 to Linux 7.3.6, the latest 7.3.y (a kernel maintainer expects 7.3 to be the next LTS). Dev/test only: no ISO seeding, apt publish, tag or release from this build.

**Upstream:** Linux 7.3.6 (kernel.org `latest_stable`, released 2026-11-23; no newer 7.3.y on 2026-11-27). Tarball sha256
`8183d475a76a0faffa92d6cd500af421f589dfd0300a0f1060bb875e11d45723` (matches kernel.org `sha256sums.asc`).
No source patches. Kernel release `7.3.6-lunduke`. `CONFIG_LOCALVERSION="-lunduke"`.
No Forced Rust (`CONFIG_RUST` stays unset; the build script still runs `scripts/config --disable RUST`).

**Versioning:** `7.3.6-lcos34`. The lcos number is the repo's running config revision; it kept counting across the 7.2.6 → 7.2.15 move (lcos29 → lcos30), so it continues from lcos33 here rather than restarting at lcos1.

**Config:** `configs/lunduke-7.3.6-lcos34.config` = `configs/lunduke-7.2.15-lcos33.config` copied onto a 7.3.6 tree, then `make olddefconfig`. No hand edits. Full delta: `docs/config-lcos33-to-lcos34.diff`.
Built with Debian GCC 14.2.0-19, binutils 2.44, pahole 1.30 (same compiler-probe values as lcos33). `/boot/config-7.3.6-lunduke` in the image deb is byte-identical to the committed config.

## What olddefconfig changed

Symbol-state comparison lcos33 → lcos34: 82 differences (68 new symbols, 13 gone, 1 changed). 52 were new prompts (`listnewconfig`).

### Every lcos30–lcos33 / 1.0.1 carry survives unchanged

Checked one by one, all identical to lcos33:
`WIREGUARD=m`, `IPV6_MULTIPLE_TABLES=y`, `IPV6_SUBTREES=y`, `OVPN=m`, `INET_ESP=m`, `INET_AH=m`, `VLAN_8021Q=m`, `MACVLAN=m`, `IPVLAN=m`;
`RT2X00=m`, `RT73USB=m`, `RT2800USB=m`, `RT2800PCI=m`, `RT2500USB=m`, `RT2500PCI=m`, `RT2400PCI=m`, `ATH5K=m`;
`NET_SCH_FQ=m`, `NET_SCH_CAKE=m`, and the LCOS#184 set `NET_SCH_HTB`, `NET_SCH_TBF`, `NET_SCH_INGRESS`, `NET_SCH_FQ_CODEL`, `NET_SCH_SFQ`, `NET_CLS_U32`, `NET_CLS_FLOWER`, `NET_CLS_FW`, `NET_ACT_CSUM`, `NET_ACT_GACT`, `NET_ACT_MIRRED`, `NET_ACT_POLICE` (all m);
`HID_CORSAIR`, `HID_RAZER`, `HID_GLORIOUS`, `HID_PLANTRONICS`, `HID_RMI` (m, LCOS#182); `ATL1C=m`, `ATL1E=m`, `IXGBE=m`;
`VMWARE_BALLOON=m`, `ACPI_SBS=m`, `INTEL_SKL_INT3472=m`, `SAMSUNG_GALAXYBOOK=m`, `MSI_WMI_PLATFORM=m`, `X86_PLATFORM_DRIVERS_UNIWILL=y`, `UNIWILL_LAPTOP=m`;
`ZRAM=m`, `CIFS=m`, `DM_CRYPT=m`, `UHID=m`, `USER_NS=y`, `BPF=y`, `BPF_SYSCALL=y`, `MEMCG=y`.
Still off on purpose: `MAC80211_MESH`, `ZSWAP`, `PPP` (so `PPPOE` is not offered), `IPW2100`, `IPW2200`.

### Renamed / merged
- `PROC_SYSCTL` is gone: 7.3 folded it into `SYSCTL` (still y; `/proc/sys` unchanged).
- `HAVE_KVM_ARCH_GMEM_PREPARE` (arch-selected) was replaced by `HAVE_KVM_ARCH_GMEM_CONVERT` and `HAVE_KVM_ARCH_GMEM_RECLAIM` (both y, automatic).
- `HAVE_GENERIC_VDSO` is gone; `VDSO_DATASTORE=y` is new (automatic).
- `SENSORS_SBTSI` now depends on the new `AMD_SBTSI` (BMC-side SB-TSI); it was off and stays off.

### Removed upstream (all were already off)
`EFS_FS`, `VXFS_FS`, `IBM_ASM`, `IPWIRELESS`, `PCMCIA_XIRCOM` (xircom_cb), `SATA_INIC162X`, `RANDOM32_SELFTEST`, `DEBUG_FORCE_WEAK_PER_CPU`, `DMA_FENCE_TRACE`.

### Changed value
- `SND_SOC_TAS2783_SDW` n → m: the AMD SoundWire legacy machine driver (already m) now selects it.

### Notable new 7.3 options and the default taken
- `DRM_AMD_DC_DCE=y` (default y): legacy DCE 8/10/11/12 display engines are now a separate option. Must stay y or GCN-1-to-Vega Radeons lose DC display.
- `SYSCALL_USER_DISPATCH=y` (default y; used by Wine/Proton).
- `RTW89_LEDS=y`, `RTW89_LEDS_MC=y` (defaults; LED support for the rtw89 Wi-Fi we already ship).
- `SERIAL_8250_MOXA_PCIE=y` (default; Moxa MUEx50 PCIe serial boards).
- `SWIOTLB_DEFAULT_SIZE_MB=64` (same as the previous fixed default).
- `WLAN_VENDOR_MORSEMICRO=y`, `WLAN_VENDOR_NXP=y`, `NET_VENDOR_ZTE=y` (menu-only; drivers under them off).
- New AES library modes `CRYPTO_LIB_AES_{CBC,CCM,CTR,ECB,GCM,XTS}=y` (selected).
- All new device drivers default off, including `RTW89_8922DE`, `SND_HDA_SCODEC_AW88399_I2C`, `SND_SOC_SOF_AMD_ACP7X`, `INPUT_AMD_SFH_TABLETMODE`, `HID_MSI`, `HID_HYPERX`, `LENOVO_YB9_KBDOCK`, `AMD_PMF_UTIL_SUPPORT`. These were deliberately not turned on in lcos34; a separate pick-list is with the editor.
- Debug knobs `QUEUED_SPINLOCKS_TRACE_CONTENDED_RELEASE`, `PROBE_EVENTS_DUMP_FETCHARG`, `REGION_ALLOC_BENCHMARK` off.

## Build notes
- 7.3's `bindeb-pkg` adds a `libdw-dev` build dependency (and wants `lsb-release` for the changelog distribution). Install both on the builder.
- Box compile 2026-11-27 (CT), `JOBS=4`, about 29 minutes, 8-core / 16 GiB builder, no OOM.
- **1134 modules** (lcos33: 1133). Modules are uncompressed, as before.

| Deb | SHA256 |
|-----|--------|
| `linux-image-7.3.6-lunduke_7.3.6-lcos34_amd64.deb` | `3091dd17856a334e665d8d67792d890ee0897f0bf5073eee8c22484ea238811a` |
| `linux-headers-7.3.6-lunduke_7.3.6-lcos34_amd64.deb` | `fe1b5a7a4be44bceff5df7b1ee1d624f12ed8488236c3c1b8c8413fafdf69ba2` |
| `linux-libc-dev_7.3.6-lcos34_amd64.deb` | `54834ee4764b45426c0d85becde79cd7e7037c57edca596c6aeb001afb26c484` |
| `lunduke-linux-kernel_7.3.6-lcos34_all.deb` | `bb5e135e4de2d2f814d299add762e5eef262786a62dd2758fc484ae1ab127533` |

## Smoke boot
QEMU q35, `-accel tcg` only (never KVM), 2 GiB, 2 vCPUs, serial console, busybox initramfs with the full module tree, both SeaBIOS and OVMF. Boots to PID 1 as `7.3.6-lunduke #lcos34`, kernel not tainted. `modprobe` succeeds for wireguard, ovpn, esp4, ah4, 8021q, macvlan, ipvlan, sch_fq, sch_cake, sch_htb, cls_flower, act_mirred, zram, cifs, dm_crypt, uhid, rt73usb, rt2800usb, ath5k, atl1c, ixgbe, hid_corsair, hid_rmi, samsung_galaxybook, snd_ens1371, amdgpu, i915, nouveau, xe. `uniwill_laptop` and `msi_wmi_platform` return ENODEV in QEMU, which is expected without that laptop's WMI/DMI.

Not done: real-hardware test, LCOS install/upgrade test, ISO.
