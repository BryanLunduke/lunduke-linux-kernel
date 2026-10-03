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
| Package version | **7.2.6-lcos12** |
| Metapackage | `lunduke-linux-kernel` |
| Image | `linux-image-7.2.6-lunduke` |
| Headers | `linux-headers-7.2.6-lunduke` |

## What this repo contains

- `configs/lunduke-7.2.6-lcos12.config` — current Kconfig (lcos11 + user ns / veth / bridge / BPF / memcg / cfs bandwidth / blk throttle; No Forced Rust)
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
- Config history: lcos4 (DRM) → lcos5 (netfilter/iptables) → lcos6 (uinput) → lcos7 (audio/Wi-Fi/BT/UVC/HID/2.5GbE) → lcos8 (RTL8187/RTL8187B, LCOS#81) → lcos9 (ISO-only: quieter boot, VMware SCSI, B43 SoftMAC) → lcos10 (VMMOUSE) → lcos11 (12 HW gaps: USB4/Type-C, Hyper-V, UAS, laptop WMI, Apple HID, virtio extras, TPM, BRCMSMAC, MWIFIEX) → lcos12 (user namespaces, veth, bridge, BPF, memcg, CFS bandwidth, blk throttle)

## License

Linux kernel: GPL-2.0 (see upstream).  
Packaging/scripts in this repository: GPL-2.0.


## Build status

**7.2.6-lcos12** — lcos11 + user namespaces, veth, bridge, bridge netfilter, bpf() syscall, cgroup BPF, BPF JIT, memcg, CFS bandwidth, and block I/O throttling. MACVLAN/IPVLAN/VXLAN/dummy/802.1Q left off. `# CONFIG_RUST is not set`. See `docs/NEXT-BUILD.md` and `docs/config-lcos11-to-lcos12.diff`. ISO seeding and apt publish are separate editor greenlights.
