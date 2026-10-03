# Next LLK build

| Item | Value |
|------|--------|
| Version | `7.2.6-lcos12` |
| Config | `configs/lunduke-7.2.6-lcos12.config` |
| Why | Container basics on lcos11: user namespaces, veth, bridge, bridge netfilter, BPF syscall/cgroup/JIT, memcg, CFS bandwidth, blk throttle |
| Delta | `docs/config-lcos11-to-lcos12.diff` |
| Base | lcos11 (`configs/lunduke-7.2.6-lcos11.config`) |

**lcos12 is the container-basics pass on lcos11.** No Forced Rust (`# CONFIG_RUST is not set`). MACVLAN, IPVLAN, VXLAN, dummy, and 802.1Q VLAN stay off. No ISO bake and no apt publish from the builder unless separately greenlit. Stage debs for editor sign.
