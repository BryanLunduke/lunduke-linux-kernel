# 7.3.6-lcos34 build (2026-11-27), for LCOS 1.1 (development)

Editor direction (2026-11-27 CT): start moving LCOS 1.1 to Linux 7.3.6, the latest 7.3.y (a kernel maintainer expects 7.3 to be the next LTS). Dev/test only: no ISO seeding, apt publish, tag or release from this build.

**Upstream:** Linux 7.3.6 (kernel.org `latest_stable`, released 2026-11-23; no newer 7.3.y on 2026-11-27). Tarball sha256
`8183d475a76a0faffa92d6cd500af421f589dfd0300a0f1060bb875e11d45723` (matches kernel.org `sha256sums.asc`).
No source patches. Kernel release `7.3.6-lunduke`. `CONFIG_LOCALVERSION="-lunduke"`.
No Forced Rust (`CONFIG_RUST` stays unset; the build script still runs `scripts/config --disable RUST`).

**Versioning:** `7.3.6-lcos34`. The lcos number is the repo's running config revision; it kept counting across the 7.2.6 → 7.2.15 move (lcos29 → lcos30), so it continues from lcos33 here rather than restarting at lcos1.

**Config:** `configs/lunduke-7.3.6-lcos34.config` = `configs/lunduke-7.2.15-lcos33.config` copied onto a 7.3.6 tree, `make olddefconfig`, then the editor's 7.3 new-hardware picks (below) and `olddefconfig` again. Full delta: `docs/config-lcos33-to-lcos34.diff`.
Built with Debian GCC 14.2.0-19, binutils 2.44, pahole 1.30 (same compiler-probe values as lcos33). `/boot/config-7.3.6-lunduke` in the image deb is byte-identical to the committed config.

## What olddefconfig changed

Before the editor's picks, the symbol-state comparison lcos33 → lcos34 (plain olddefconfig) was 82 differences (68 new symbols, 13 gone, 1 changed), with 52 new prompts (`listnewconfig`).

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
- Other new device drivers stay at their default (off); the editor's picks are listed in the next section.
- Debug knobs `QUEUED_SPINLOCKS_TRACE_CONTENDED_RELEASE`, `PROBE_EVENTS_DUMP_FETCHARG`, `REGION_ALLOC_BENCHMARK` off.

## Editor's 7.3 new-hardware picks (2026-11-27)

The editor took all twelve drivers from the 7.3 new-hardware survey. All end up enabled after `olddefconfig`:

- `RTW89_8922DE=m` (Realtek RTL8922DE/-VS Wi-Fi 7 PCIe; selects `RTW89_8922D=m`)
- `SND_HDA_SCODEC_AW88399_I2C=m` (Lenovo Legion Pro speaker amp; selects `SND_HDA_SCODEC_AW88399=m`, `SND_SOC_AW88399_LIB=m`, `SND_SOC_AW88395_LIB=m`)
- `SND_SOC_SOF_AMD_ACP7X=m` (SOF audio on AMD ACP 7.B/7.F)
- `INPUT_AMD_SFH_TABLETMODE=m` (AMD 2-in-1 tablet-mode switch; deferred from lcos24)
- `LENOVO_YB9_KBDOCK=m` (Lenovo Yoga Book 9 keyboard dock)
- `AMD_PMF_UTIL_SUPPORT=y` (bool; AMD PMF util character device inside `amd-pmf.ko`)
- `HID_MSI=m` (MSI Claw controller/RGB)
- `HID_HYPERX=m` (HyperX QuadCast 2 mute button)
- `HID_STEELSERIES=m` (SteelSeries Arctis/Nova headsets, SRW-S1 wheel)
- `SCSI_LEAPRAID=m` (LeapIO PCIe RAID/HBA)
- `NXPWIFI_SDIO=m` (NXP IW61x Wi-Fi; selects `NXPWIFI=m`)
- `MM81X_USB=m` (Morse Micro Wi-Fi HaLow USB; selects `MM81X=m`, which selects `CRC7=m`)

No new prompts were left after the second `olddefconfig`.

## Build notes
- 7.3's `bindeb-pkg` adds a `libdw-dev` build dependency (and wants `lsb-release` for the changelog distribution). Install both on the builder.
- Box compile 2026-11-27 (CT), `JOBS=4`, about 29 minutes, 8-core / 16 GiB builder, no OOM.
- **1153 modules** (lcos33: 1133; 1134 before the editor's picks, which add 19 incl. dependencies). Modules are uncompressed, as before. The picks were an incremental rebuild of the same tree.

| Deb | SHA256 |
|-----|--------|
| `linux-image-7.3.6-lunduke_7.3.6-lcos34_amd64.deb` | `5994ae42de1366c7f05dc7cd534b287651a20cb7b500ab67801a2a1bf95a5cef` |
| `linux-headers-7.3.6-lunduke_7.3.6-lcos34_amd64.deb` | `545b4db63bfdc1af3f8fc02a86d36a98180f842a1e5d86407e98c1b26db2a609` |
| `linux-libc-dev_7.3.6-lcos34_amd64.deb` | `f516f2a0e75872f655cd320fcd68183d75b1ea124f2c68067770f2f5fbc3a672` |
| `lunduke-linux-kernel_7.3.6-lcos34_all.deb` | `18a982721cafc08c97221e91922767c4cf8113e9a1a3bb61d1bbe43fe6b3fab0` |

## Smoke boot
QEMU q35, `-accel tcg` only (never KVM), 2 GiB, 2 vCPUs, serial console, busybox initramfs with the full module tree, both SeaBIOS and OVMF (final config, with the picks). Boots to PID 1 as `7.3.6-lunduke #lcos34`, kernel not tainted, no oops.
`modprobe` succeeds for the new picks rtw89_8922de, snd_hda_scodec_aw88399_i2c, snd_sof_amd_acp7x, amd_sfh_tabletmode, amd_pmf, hid_msi, hid_hyperx, hid_steelseries, leapraid, nxpwifi_sdio, mm81x_usb, and for wireguard, ovpn, esp4, ah4, 8021q, macvlan, ipvlan, sch_fq, sch_cake, sch_htb, cls_flower, act_mirred, zram, cifs, dm_crypt, uhid, rt73usb, rt2800usb, ath5k, atl1c, ixgbe, hid_corsair, hid_rmi, samsung_galaxybook, snd_ens1371, amdgpu, i915, nouveau, xe.
`lenovo_yb9_kbdock`, `uniwill_laptop` and `msi_wmi_platform` return ENODEV in QEMU, which is expected without that laptop's WMI/DMI.

Not done: real-hardware test, LCOS install/upgrade test, ISO.
