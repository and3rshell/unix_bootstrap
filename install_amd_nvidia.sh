#!/usr/bin/env bash

set -euo pipefail

PACMAN_FLAGS=(--needed --noconfirm)

# Prefer open DKMS for newer NVIDIA GPUs, fall back to proprietary DKMS.
nvidia_driver_package=""
for candidate in nvidia-open-dkms nvidia-dkms; do
    if pacman -Si "$candidate" >/dev/null 2>&1; then
        nvidia_driver_package="$candidate"
        break
    fi
done

if [ -z "$nvidia_driver_package" ]; then
    echo "No supported NVIDIA DKMS driver package found (tried nvidia-open-dkms, nvidia-dkms)."
    exit 1
fi

hardware_packages=(
    "amd-ucode"
    "linux-headers"
    "$nvidia_driver_package"
    "nvidia-utils"
    "nvidia-settings"
    "opencl-nvidia"
    "egl-wayland"
    "libva-nvidia-driver"
    "vulkan-icd-loader"
    "vulkan-tools"
    "nvidia-container-toolkit"
)

optional_hardware_packages=(
    "lib32-nvidia-utils"
    "lib32-vulkan-icd-loader"
)

missing_optional_packages=()
for optional_pkg in "${optional_hardware_packages[@]}"; do
    if pacman -Si "$optional_pkg" >/dev/null 2>&1; then
        hardware_packages+=("$optional_pkg")
    else
        missing_optional_packages+=("$optional_pkg")
    fi
done

if [ "${#missing_optional_packages[@]}" -gt 0 ]; then
    echo "Skipping unavailable optional packages: ${missing_optional_packages[*]}"
    echo "If you need 32-bit Vulkan/OpenGL support, enable [multilib] and re-run this script."
fi

echo -e "\n===========\n\n=> Installing AMD + NVIDIA packages..."
sudo pacman -Syu "${PACMAN_FLAGS[@]}" "${hardware_packages[@]}" || exit 1

echo -e "\n=> Enabling NVIDIA persistence daemon (if available)..."
if systemctl list-unit-files | grep -q '^nvidia-persistenced\.service'; then
    sudo systemctl enable --now nvidia-persistenced.service || exit 1
else
    echo "nvidia-persistenced.service not found; skipping."
fi

if command -v nvidia-ctk >/dev/null 2>&1; then
    echo -e "\n=> Configuring Docker NVIDIA runtime..."
    sudo nvidia-ctk runtime configure --runtime=docker || exit 1
    sudo systemctl restart docker || exit 1
fi

if command -v mkinitcpio >/dev/null 2>&1; then
    echo -e "\n=> Rebuilding initramfs..."
    sudo mkinitcpio -P || exit 1
fi

echo -e "\nSuggested verification:"
echo "lscpu | grep 'Model name'"
echo "nvidia-smi"
echo "vulkaninfo --summary | head -n 20"
echo "docker run --rm --gpus all nvidia/cuda:12.6.0-base-ubuntu24.04 nvidia-smi"

echo -e "\nSuccess"
