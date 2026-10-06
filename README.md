# Lunduke's Linux Kernel

Linux kernel packaging for [LCOS](https://lunduke.com) (Lunduke Computer Operating System).

**LCOS 0.7** ISOs ship **Lunduke's Linux Kernel** as the default (and only) kernel. Older LCOS releases used the Devuan-supplied kernel by default, with LLK available from the apt overlay.

## Install (on LCOS)

```bash
sudo apt update
sudo apt install lunduke-linux-kernel
```

On LCOS 0.7 this is already the default. On older releases, reboot and pick **7.2.6-lunduke** in GRUB (the Distro kernel stays installed).

Apt overlay: `https://lcos.lunduke.com/apt` (suite `excalibur`, component `main`).

## Current release

| Field | Value |
|-------|-------|
| Upstream | Linux **7.2.6** ([kernel.org](https://www.kernel.org/)) |
| Flavor / LOCALVERSION | `-lunduke` |
| Package version | **7.2.6-lcos15** |
| Metapackage | `lunduke-linux-kernel` |
| Image | `linux-image-7.2.6-lunduke` |
| Headers | `linux-headers-7.2.6-lunduke` |

## What this repo contains

- `configs/lunduke-7.2.6-lcos15.config` — current Kconfig (lcos14 + ASIX USB Ethernet; No Forced Rust)
- `configs/lunduke-7.2.6-lcos14.config` — frozen lcos14 (snd-intel8x0 and mt76x0e)
- `configs/lunduke-7.2.6-lcos13.config` — frozen lcos13 (laptop buses, SOF/ACP machines, USB Ethernet, hwmon/idle, in-tree Surface, vendor hotkeys)
- `configs/lunduke-7.2.6-lcos12.config` — frozen lcos12 (shipped on LCOS 0.8; container basics)
- `configs/lunduke-7.2.6-lcos11.config` — prior lcos11 (12 HW gaps)
- `configs/lunduke-7.2.6-lcos10.config` — prior lcos10 (VMMOUSE)
- `configs/lunduke-7.2.6-lcos7.config` — prior lcos7 (high-impact HW modules)
- `configs/lunduke-7.2.6-lcos5.config` — shipped 7.2.6-lcos5 (Distro-like netfilter; fixes iptables)
- `configs/lunduke-7.2.6-lcos4.config` — prior lcos4 Kconfig (incomplete netfilter)
- `packaging/lunduke-linux-kernel/` — Debian metapackage sources
- `scripts/build-lunduke-kernel.sh` — rebuild image/headers debs from an upstream tarball
- `scripts/build-metapackage.sh` — rebuild the metapackage deb
- `docs/` — graphics notes and config deltas

**Not** vendored here: the full upstream kernel source. Download from kernel.org (see build script).

## Build

```bash
# From a machine with kernel build deps (flex, bison, libelf-dev, bc, deb-pkg tooling, …)
wget https://cdn.kernel.org/pub/linux/kernel/v7.x/linux-7.2.6.tar.xz
tar -xf linux-7.2.6.tar.xz
./scripts/build-lunduke-kernel.sh
```

On a 16G RAM builder, keep `JOBS=3` (default) to avoid OOM.

## Design notes (lcos5)

- Rust-in-kernel left **off** (LCOS: no forced Rust)
- Netfilter/iptables: `NETFILTER_ADVANCED`, `NF_TABLES`, `IP_NF_FILTER`/`NAT`/`MANGLE`/`RAW`, and legacy xtables (Distro-like; fixes Doug Burks iptables bug)
- Desktop/VM DRM enabled: Intel i915/xe, AMDGPU (+ SI/CIK), Nouveau, vmwgfx, vboxvideo, QXL, bochs, simpledrm
- Proven in VirtualBox with **VMSVGA** (KernelTest4)

## Relation to LCOS releases

- **LCOS 0.7+:** default (and only) ISO kernel
- **LCOS 0.6 and earlier:** Distro/Devuan kernel on the ISO; LLK optional via apt overlay
- Config history: lcos4 (DRM) → lcos5 (netfilter/iptables) → lcos6 (uinput) → lcos7 (audio/Wi-Fi/BT/UVC/HID/2.5GbE) → lcos8 (RTL8187/RTL8187B, LCOS#81) → lcos9 (ISO-only: quieter boot, VMware SCSI, B43 SoftMAC) → lcos10 (VMMOUSE) → lcos11 (12 HW gaps: USB4/Type-C, Hyper-V, UAS, laptop WMI, Apple HID, virtio extras, TPM, BRCMSMAC, MWIFIEX) → lcos12 (user namespaces, veth, bridge, BPF, memcg, CFS bandwidth, blk throttle) → lcos13 (laptop buses, SOF/ACP machines, USB Ethernet, hwmon/idle, in-tree Surface, vendor hotkeys) → lcos14 (snd-intel8x0 for 8086:2415, LCOS#94; mt76x0e for 14c3:7630, LCOS#95) → lcos15 (ASIX AX88179/AX88178A, AX8817X, and CDC NCM for AX88179A/AX88772D, LCOS#100)

## License

Linux kernel: GPL-2.0 (see upstream).  
Packaging/scripts in this repository: GPL-2.0.


## Build status

**7.2.6-lcos15** — lcos14 + `CONFIG_USB_NET_AX88179_178A=m` (ASIX AX88179/AX88178A, USB 0b95:1790 and 0b95:178a, LCOS#100), `CONFIG_USB_NET_AX8817X=m` (AX88172/AX88772), and `CONFIG_USB_NET_CDC_NCM=m` (AX88179A/AX88772D via CDC NCM on Linux 7.2.6). `# CONFIG_RUST is not set`. `CONFIG_LOCALVERSION="-lunduke"`. lcos12, lcos13, and lcos14 stay frozen. No kernel debs were built. See `docs/NEXT-BUILD.md` and `docs/config-lcos14-to-lcos15.diff`. ISO seeding and apt publish are separate editor greenlights.
