# LLK amdgpu/radeon audit vs Ubuntu generic (LCOS #115, #118)

Reference: Ubuntu 26.04 `linux-modules-7.0.0-38-generic` (resolute-updates) `/boot/config`.
Base: `configs/lunduke-7.2.6-lcos18.config`. Proposed: `configs/lunduke-7.2.6-lcos19.config`
(resolved with `make olddefconfig` on a clean 7.2.6 tree). UNMERGED, UNBUILT.

Already matching Ubuntu: DRM_AMDGPU=m with SI+CIK, DRM_AMD_DC(+FP), DRM_AMD_ACP, DRM_AMD_ISP,
SIMPLEDRM + SYSFB_SIMPLEFB, DRM_FBDEV_EMULATION, AMD_IOMMU, MMU_NOTIFIER/HMM_MIRROR,
X86_AMD_PSTATE, AMD_PMC, FW_LOADER_USER_HELPER, EXTRA_FIRMWARE="".

Enabled in lcos19 (Ubuntu has them):
- DRM_RADEON=m: TeraScale/pre-GCN Radeons (HD 2000-6000, Llano/Trinity/Richland APUs)
  have no KMS driver at all in lcos18. Also restores the radeon.cik_support=1
  amdgpu.cik_support=0 escape hatch for CIK APUs like the A8-6410 (amdgpu stays default).
- VGA_SWITCHEROO=y: hybrid iGPU+dGPU laptops.
- DRM_AMD_DC_SI=y: DC display path for SI (HD 7000) cards.
- DRM_AMDGPU_USERPTR=y, HSA_AMD=y: userptr BOs / KFD compute (ROCm, some Vulkan/OpenCL paths).
- FW_LOADER_COMPRESS (+XZ, ZSTD): load .bin.xz/.bin.zst firmware (newer linux-firmware
  installs, Ubuntu-style). Debian's current firmware is uncompressed, so not the cause today.
- X86_AMD_PLATFORM_DEVICE=y, I2C_PIIX4=m: AMD laptop GPIO/I2C/SMBus.
- PM_DEVFREQ (+PM_OPP), CPU_FREQ_GOV_POWERSAVE/CONSERVATIVE: power management.
- DRM_DISPLAY_DP_AUX_CHARDEV/CEC, DRM_LOAD_EDID_FIRMWARE, UDMABUF: display debugging/EDID override.

Not taken (noted):
- HSA_AMD_SVM / ZONE_DEVICE / DEVICE_PRIVATE: need memory hotplug, which LLK leaves off.
- DMABUF_HEAPS: pulls in TEE/OP-TEE options; not needed for GPUs.
- FB_EFI=y and FB_VESA=y in LLK (Ubuntu: n). Left alone because nomodeset safe mode
  may depend on them; consider dropping later so only simpledrm owns the boot framebuffer.
- Accelerators (AMDXDNA NPU etc.), Type-C muxes for other vendors: not GPU related.
