# Next LLK build

| Item | Value |
|------|--------|
| Version | `7.2.6-lcos17` |
| Config | `configs/lunduke-7.2.6-lcos17.config` |
| Why | SMB2/SMB3 (CIFS) client for NAS / Windows / Samba shares (LCOS#111) on frozen lcos16 |
| Delta | `docs/config-lcos16-to-lcos17.diff` |
| Verify | `docs/lcos17-module-verify.txt` |
| Base | lcos16 (`configs/lunduke-7.2.6-lcos16.config`, merge 76140928; build docs 57c39e8d) |

**lcos17 adds the SMB client on lcos16.** `CONFIG_CIFS=m` and `CONFIG_CIFS_XATTR=y`; Kconfig defaults `CIFS_STATS2=y` and `CIFS_DEBUG=y`; selected `SMBFS=m` and `NLS_UCS2_UTILS=m`. Every other CIFS select (keys, DNS resolver, ASN.1, netfs, AES/CCM/GCM, MD5/ARC4/SHA libs) was already on in lcos16. `CIFS_ALLOW_INSECURE_LEGACY` (SMB1 and SMB2.0 dialects) is explicitly off, so `CIFS_POSIX` (which depends on it in 7.2.6) stays off; SMB3.1.1 POSIX extensions do not need it. `SMB_SERVER` (ksmbd), `CIFS_SMB_DIRECT`, `CIFS_UPCALL`, `CIFS_DFS_UPCALL`, and `CIFS_SWN_UPCALL` stay off. Userland is `cifs-utils` (+ `keyutils`) in the LCOS 0.9 recipe. No other option changed. Proprietary NVIDIA is not added. No Forced Rust (`# CONFIG_RUST is not set`). `CONFIG_LOCALVERSION="-lunduke"`. No VirtualBox vmwgfx cursor patch. lcos12 through lcos16 stay frozen. No ISO bake and no apt publish from the builder.

## Build (2026-10-08)

lcos17 was built on the LCOS builder from branch `cursor/lcos17-cifs-client-111`
at `1d5dad8` (config commit) with `scripts/build-lunduke-kernel.sh` and
`scripts/build-metapackage.sh`, the same method as lcos16.
`configs/lunduke-7.2.6-lcos17.config` was used unchanged.

- Upstream: `linux-7.2.6.tar.xz`, sha256 `039aef84f2b0994aeda3f4fcfc3d02ec9d7a9bbb9020ea264c43f446c860f606` (matches kernel.org), fresh clean tree, `JOBS=4`
- Build window: 2026-10-08 12:13 PM to 12:40 PM CT (bindeb-pkg completed)
- `uname -r`: `7.2.6-lunduke`, build string `#lcos17 SMP PREEMPT_DYNAMIC Thu Oct 8 12:38:26 CDT 2026`
- Modules: **937** `.ko` in the image deb (lcos16: 933). The 4 new ones: `fs/smb/client/cifs.ko`, `fs/smb/common/cifs_md4.ko`, `fs/smb/common/smb_compress.ko`, `fs/nls/nls_ucs2_utils.ko`. No module was removed.
- `vermagic`: `7.2.6-lunduke SMP preempt mod_unload` (same as lcos16). `depmod -e` against the shipped System.map: no unresolved symbols.
- Packaged `/boot/config-7.2.6-lunduke` differs from the lcos16 packaged config only in the CIFS/SMBFS/NLS_UCS2_UTILS lines of `docs/config-lcos16-to-lcos17.diff`. `CONFIG_RUST` is not enabled.

| Deb | Version | Bytes | SHA256 |
|-----|---------|-------|--------|
| `linux-image-7.2.6-lunduke_7.2.6-lcos17_amd64.deb` | 7.2.6-lcos17 | 37173884 | `d663a8af0f405901203214ed923ed7cb9ca4942fda0ea0bb6417c8a21b556292` |
| `linux-headers-7.2.6-lunduke_7.2.6-lcos17_amd64.deb` | 7.2.6-lcos17 | 9839932 | `99f6f1639bfb5d98554625a90ada40ca70d61c7e6d7b049947bd9e611568ca3a` |
| `lunduke-linux-kernel_7.2.6-lcos17_all.deb` | 7.2.6-lcos17 | 2192 | `f76621c0cd41eab053ec85c10aacb1752e361d32154279716ed3dbcc86359870` |
| `linux-libc-dev_7.2.6-lcos17_amd64.deb` (not seeded) | 7.2.6-lcos17 | 1506152 | `dd0262bc0910a1e66afa72d01ea4fca2cd4cc38e6529fe9e0e61be0d97eed9c8` |

The debs are **not** seeded into the LCOS 0.9 live-build recipe yet; that waits
for the editor to merge this PR. Debs are not committed to this repo.
