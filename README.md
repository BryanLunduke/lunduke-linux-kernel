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
| Package version | **7.2.6-lcos19** |
| Metapackage | `lunduke-linux-kernel` |
| Image | `linux-image-7.2.6-lunduke` |
| Headers | `linux-headers-7.2.6-lunduke` |

## What this repo contains

- `configs/lunduke-7.2.6-lcos18.config` — current Kconfig (lcos17 + dm-crypt/LUKS LCOS#123, UHID LCOS#120, RMI4 F11/F3A LCOS#121; No Forced Rust)
- `configs/lunduke-7.2.6-lcos17.config` — frozen lcos17 (lcos16 + SMB2/SMB3 client `CONFIG_CIFS=m`, LCOS#111; No Forced Rust)
- `configs/lunduke-7.2.6-lcos16.config` — frozen lcos16 (LCOS 0.9 hardware gap pick-list; shipped on lcos-live-09-02/09-03 test ISOs)
- `configs/lunduke-7.2.6-lcos15.config` — frozen lcos15 (ASIX USB Ethernet, TUN, and KVM host)
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
- Config history: lcos4 (DRM) → lcos5 (netfilter/iptables) → lcos6 (uinput) → lcos7 (audio/Wi-Fi/BT/UVC/HID/2.5GbE) → lcos8 (RTL8187/RTL8187B, LCOS#81) → lcos9 (ISO-only: quieter boot, VMware SCSI, B43 SoftMAC) → lcos10 (VMMOUSE) → lcos11 (12 HW gaps: USB4/Type-C, Hyper-V, UAS, laptop WMI, Apple HID, virtio extras, TPM, BRCMSMAC, MWIFIEX) → lcos12 (user namespaces, veth, bridge, BPF, memcg, CFS bandwidth, blk throttle) → lcos13 (laptop buses, SOF/ACP machines, USB Ethernet, hwmon/idle, in-tree Surface, vendor hotkeys) → lcos14 (snd-intel8x0 for 8086:2415, LCOS#94; mt76x0e for 14c3:7630, LCOS#95) → lcos15 (ASIX AX88179/AX88178A, AX8817X, and CDC NCM, LCOS#100; TUN for rootless podman, LCOS#87; KVM Intel/AMD host, LCOS#103) → lcos16 (LCOS 0.9 hardware gap pick-list: USB net/WWAN/serial, AMD audio, Type-C, input, sensors, Wi-Fi/BT tail, Apple, NPU, VFIO, vhost-net) → lcos17 (SMB2/SMB3 client: CIFS=m, CIFS_XATTR=y, LCOS#111; SMB1 legacy and ksmbd off) → lcos18 (dm-crypt/LUKS LCOS#123, UHID LCOS#120, RMI4 F11/F3A LCOS#121)

## License

Linux kernel: GPL-2.0 (see upstream).  
Packaging/scripts in this repository: GPL-2.0.


## Build status

**7.2.6-lcos19** — lcos17 + LUKS disk encryption (`CONFIG_DM_CRYPT=m`, `CRYPTO_XTS=m`, `CRYPTO_ESSIV=m`, `CRYPTO_AES_NI_INTEL=m`, `CRYPTO_USER_API_SKCIPHER=m`, `CRYPTO_USER_API_HASH=m`; LCOS#123), `CONFIG_UHID=m` for Bluetooth LE mice/keyboards (LCOS#120), and `CONFIG_RMI4_F11=y` + `CONFIG_RMI4_F3A=y` for Synaptics RMI4 touchpads such as the ThinkPad X1 Carbon (LCOS#121). `DM_SNAPSHOT` stays off. `# CONFIG_RUST is not set`. `CONFIG_LOCALVERSION="-lunduke"`. lcos12 through lcos17 stay frozen. See `docs/NEXT-BUILD.md`, `docs/config-lcos17-to-lcos18.diff`, and `docs/lcos18-module-verify.txt`. ISO seeding and apt publish are separate editor greenlights.

**7.2.6-lcos17** — lcos16 + the SMB2/SMB3 network file system client (`CONFIG_CIFS=m`, `CONFIG_CIFS_XATTR=y`, LCOS#111) so NAS/Windows/Samba shares mount with `cifs-utils`. `CIFS_ALLOW_INSECURE_LEGACY` (SMB1/SMB2.0), `CIFS_POSIX` (depends on it), `CIFS_SMB_DIRECT`, and `SMB_SERVER` (ksmbd) stay off. `# CONFIG_RUST is not set`. `CONFIG_LOCALVERSION="-lunduke"`. lcos12 through lcos16 stay frozen. Debs built on the LCOS builder from this branch (not committed). See `docs/NEXT-BUILD.md`, `docs/config-lcos16-to-lcos17.diff`, and `docs/lcos17-module-verify.txt`. ISO seeding and apt publish are separate editor greenlights.
