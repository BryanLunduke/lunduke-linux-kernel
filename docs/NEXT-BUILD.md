# Next LLK build

| Item | Value |
|------|--------|
| Version | `7.2.6-lcos18` |
| Config | `configs/lunduke-7.2.6-lcos18.config` |
| Why | LUKS disk encryption (LCOS#123), Bluetooth LE HID (LCOS#120), RMI4 touchpads (LCOS#121) on frozen lcos17 |
| Delta | `docs/config-lcos17-to-lcos18.diff` |
| Verify | `docs/lcos18-module-verify.txt` |
| Base | lcos17 (`configs/lunduke-7.2.6-lcos17.config`, merge c4059c6e) |

**lcos18 on lcos17.** Requested: `CONFIG_DM_CRYPT=m`, `CONFIG_CRYPTO_XTS=m`, `CONFIG_CRYPTO_ESSIV=m`, `CONFIG_CRYPTO_AES_NI_INTEL=m`, `CONFIG_CRYPTO_USER_API_SKCIPHER=m`, `CONFIG_CRYPTO_USER_API_HASH=m` (LCOS#123); `CONFIG_UHID=m` (LCOS#120); `CONFIG_RMI4_F11=y`, `CONFIG_RMI4_F3A=y` (LCOS#121). Filled by olddefconfig: `CRYPTO_USER_API=m` and `CRYPTO_LIB_GF128MUL=m` (selected), `CRYPTO_USER_API_ENABLE_OBSOLETE=y` (Kconfig default; the obsolete ciphers it exposes all stay unset). `BLK_DEV_DM=y`, `CRYPTO_AES/CBC/ECB/SHA256=y` and `RMI4_CORE/RMI4_SMB/RMI4_2D_SENSOR` were already on in lcos17. `DM_SNAPSHOT` stays off (not needed for LUKS). `HID_RMI` (HID-over-I2C RMI) stays off. No Forced Rust. No proprietary NVIDIA. No VirtualBox vmwgfx cursor patch. `CONFIG_LOCALVERSION="-lunduke"`.

## Build (2026-10-09)

Built on the LCOS builder (box) from branch `cursor/lcos18-dmcrypt-uhid-rmi4` with `scripts/build-lunduke-kernel.sh` (JOBS=6) and `scripts/build-metapackage.sh`, fresh clean linux-7.2.6 tree (tarball sha256 `039aef84f2b0994aeda3f4fcfc3d02ec9d7a9bbb9020ea264c43f446c860f606`).

- Toolchain note: the builder is now Debian 13 gcc 14.2.0-19 / binutils 2.44 / pahole 1.30 (lcos17: Ubuntu gcc-14 14.2.0, binutils 2.42, pahole 1.25). Only the toolchain-detected `*_VERSION` lines and `OPENSSL_SUPPORTS_ML_DSA` differ for that reason.
- `uname -v`: `#lcos18 SMP PREEMPT_DYNAMIC Fri Oct 9 19:50:55 CDT 2026`, `uname -r` `7.2.6-lunduke`
- Modules: **946** `.ko` (lcos17: 937). +9: `drivers/md/dm-crypt.ko`, `crypto/xts.ko`, `crypto/essiv.ko`, `arch/x86/crypto/aesni-intel.ko`, `crypto/af_alg.ko`, `crypto/algif_skcipher.ko`, `crypto/algif_hash.ko`, `lib/crypto/gf128mul.ko`, `drivers/hid/uhid.ko`. None removed. RMI4 F11/F3A are built into `rmi_core.ko`.
- vermagic `7.2.6-lunduke SMP preempt mod_unload`; `depmod -e -F System.map`: no unresolved symbols.
- QEMU (TCG) boot of the lcos18 vmlinuz with a test initramfs: modprobe dm_crypt, xts, essiv, aesni_intel, algif_skcipher, algif_hash, uhid, rmi_core all OK; `/dev/uhid` present; cryptsetup LUKS1 aes-xts-plain64 512-bit luksFormat/open/write OK (Calamares uses luks1); LUKS2 format/open OK; aes-xts-aesni-avx driver in /proc/crypto.

| Deb | Bytes | SHA256 |
|-----|-------|--------|
| `linux-image-7.2.6-lunduke_7.2.6-lcos18_amd64.deb` | 37253576 | `7031f89b416273fa6573dead8552e79daf25112ebe8f712a014352ddb175554b` |
| `linux-headers-7.2.6-lunduke_7.2.6-lcos18_amd64.deb` | 9840720 | `e6397a1ff384e3861c835b4d49f294398335f941559c4e1f33ef4a609aabe784` |
| `lunduke-linux-kernel_7.2.6-lcos18_all.deb` | 2468 | `2933ede87267865a6d35a882244375e41a57cde34045679c68fab04b9f63af97` |
| `linux-libc-dev_7.2.6-lcos18_amd64.deb` (not seeded) | 1506304 | `5b4481c5892c9ca3ee4ce85ea10a46b8a608ac29fd714635b60cdd5012026173` |

Debs are not committed and not seeded into the LCOS 0.9.2 recipe; that waits for the editor to merge this PR. No ISO bake, no apt publish.
