# Next LLK build (parked)

**Do not run until the editor says to build.** No ISO bake with this step.

| Item | Value |
|------|--------|
| Version | `7.2.6-lcos6` |
| Config | `configs/lunduke-7.2.6-lcos6.config` |
| Why | Doug Burks: enable `CONFIG_INPUT_UINPUT=m` so `spice-vdagent` can resize SPICE/QEMU guests |
| Delta | `docs/config-lcos5-to-lcos6.diff` |
| Base | lcos5 (netfilter/iptables already fixed) |

When greenlit: `scripts/build-lunduke-kernel.sh` (defaults already point at lcos6), verify `uinput.ko` in the image deb, rebuild metapackage, stage apt for signing. Still optional apt-only.
