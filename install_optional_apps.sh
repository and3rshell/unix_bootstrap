#!/usr/bin/env bash

set -euo pipefail

PACMAN_FLAGS=(--needed --noconfirm)

pacman_optional_packages=(
    "libreoffice"
    "gimp"
    "csvlens"
)

paru_optional_packages=(
    "burpsuite"
    "postman-bin"
)

sudo pacman -Syu "${PACMAN_FLAGS[@]}" "${pacman_optional_packages[@]}" || exit 1

if ! command -v paru >/dev/null 2>&1; then
    echo "paru is not installed. Run ./install_paru.sh first."
    exit 1
fi

for paru_package in "${paru_optional_packages[@]}"; do
    paru -S --needed --noconfirm "$paru_package"
done

echo -e "\nSuccess"
