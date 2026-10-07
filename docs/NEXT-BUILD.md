# Next LLK build

| Item | Value |
|------|--------|
| Version | `7.2.6-lcos15` |
| Config | `configs/lunduke-7.2.6-lcos15.config` |
| Why | ASIX USB Ethernet (LCOS#100), TUN (LCOS#87), and KVM host (LCOS#103) on frozen lcos14 |
| Delta | `docs/config-lcos14-to-lcos15.diff` |
| Base | lcos14 (`configs/lunduke-7.2.6-lcos14.config`, commit 6487b4dc) |

**lcos15 enables ASIX USB Ethernet, TUN, and KVM host support on lcos14.** `CONFIG_USB_NET_AX88179_178A=m` covers vendor-class AX88179 (0b95:1790) and AX88178A (0b95:178a). `CONFIG_USB_NET_AX8817X=m` covers the older AX88172/AX88772 family. `CONFIG_USB_NET_CDC_NCM=m` covers AX88179A/AX88772D, which on Linux 7.2.6 enumerate as CDC NCM. `CONFIG_TUN=m` provides `/dev/net/tun` for rootless podman. `CONFIG_KVM=m`, `CONFIG_KVM_INTEL=m`, and `CONFIG_KVM_AMD=m` host guests on Intel and AMD. `CONFIG_TUN_VNET_CROSS_LE`, MACVLAN, IPVLAN, VXLAN, DUMMY, VLAN_8021Q, VFIO, and VHOST_NET stay unset. `CONFIG_KVM_GUEST` stays `y`. The ASIX olddefconfig selected `CONFIG_PHYLINK=m` and `CONFIG_SWPHY=y` and made `CONFIG_SFP` visible (left off). The KVM olddefconfig selected `CONFIG_X86_FRED=y`, the KVM internal bools, `CONFIG_KVM_AMD_SEV=y`, `CONFIG_KVM_IOAPIC=y`, `CONFIG_KVM_SMM=y`, `CONFIG_KVM_HYPERV=y`, `CONFIG_MITIGATION_VMSCAPE=y`, `CONFIG_VHOST_TASK=y`, and `CONFIG_IRQ_BYPASS_MANAGER=m`, and made `CONFIG_KVM_XEN` visible (left off). `CONFIG_KVM_VFIO=y` is the internal KVM symbol; `CONFIG_VFIO` stays unset. No firmware blob. lcos12 shipped on LCOS 0.8 and stays frozen. lcos13 and lcos14 stay frozen. No Forced Rust (`# CONFIG_RUST is not set`). `CONFIG_LOCALVERSION="-lunduke"`. No kernel debs were built. No ISO bake.
