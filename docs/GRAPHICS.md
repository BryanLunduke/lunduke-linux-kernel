# Graphics-related Kconfig (lcos4)

Enabled for modern laptops and common VMs:

| Option | Value | Why |
|--------|-------|-----|
| CONFIG_DRM_I915 | m | Intel GPUs |
| CONFIG_DRM_XE | m | Newer Intel |
| CONFIG_DRM_AMDGPU | m | Modern AMD |
| CONFIG_DRM_AMDGPU_SI | y | Southern Islands via amdgpu |
| CONFIG_DRM_AMDGPU_CIK | y | Sea Islands via amdgpu |
| CONFIG_DRM_NOUVEAU | m | Open NVIDIA |
| CONFIG_DRM_VMWGFX | y | VirtualBox VMSVGA / VMware |
| CONFIG_DRM_VBOXVIDEO | y | VirtualBox VBoxVGA/VBoxSVGA |
| CONFIG_DRM_QXL | m | SPICE/QEMU |
| CONFIG_DRM_BOCHS | y | Bochs/QEMU stdvga |
| CONFIG_DRM_SIMPLEDRM | y | Simple framebuffer DRM |

Not included: proprietary NVIDIA (out of tree), legacy `radeon` (prefer amdgpu SI/CIK).
