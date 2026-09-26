# Lunduke's Linux Kernel

Optional alternate Linux kernel for [LCOS](https://lunduke.com) (Lunduke Computer Operating System).

LCOS ISOs continue to ship the **Devuan-supplied** kernel by default. This tree is for people who want to install and test **Lunduke's Linux Kernel** from the LCOS apt overlay.

## Install (on LCOS)

```bash
sudo apt update
sudo apt install lunduke-linux-kernel
```

Reboot and pick **7.2.6-lunduke** in GRUB. The Devuan kernel stays installed.

Apt overlay: `https://lcos.lunduke.com/apt` (suite `excalibur`, component `main`).

## Current release

| Field | Value |
|-------|-------|
| Upstream | Linux **7.2.6** ([kernel.org](https://www.kernel.org/)) |
| Flavor / LOCALVERSION | `-lunduke` |
| Package version | **7.2.6-lcos7** |
| Metapackage | `lunduke-linux-kernel` |
| Image | `linux-image-7.2.6-lunduke` |
| Headers | `linux-headers-7.2.6-lunduke` |

## What this repo contains

- `configs/lunduke-7.2.6-lcos7.config` — current Kconfig (lcos6 + high-impact HW modules)
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

- Optional via apt — not the default ISO kernel
- Next official LCOS 0.6 ISO track remains based on Devuan’s kernel
- Switch LCOS default to LLK only if a future release decides testing went well

## License

Linux kernel: GPL-2.0 (see upstream).  
Packaging/scripts in this repository: GPL-2.0.


## Build status

**7.2.6-lcos7** — high-impact hardware modules pass (audio/Wi-Fi/BT/UVC/HID/Ethernet). See `docs/NEXT-BUILD.md` and `docs/config-lcos6-to-lcos7.diff`. No ISO bake / apt publish from this hop unless separately greenlit.

