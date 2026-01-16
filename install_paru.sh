#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=config.sh
. "$SCRIPT_DIR/config.sh"

PARU_TMP_DIR="$TMP_DIR/paru"

[ ! -d "$TMP_DIR" ] && mkdir -p "$TMP_DIR"
[ -d "$PARU_TMP_DIR" ] && rm -rf "$PARU_TMP_DIR"

trap 'rm -rf "$PARU_TMP_DIR"' EXIT

PACMAN_FLAGS=(--needed --noconfirm)

read -rp "Install base-devel? [y/N] " answer
if [ "$answer" == "y" ]; then
    sudo pacman -Syu "${PACMAN_FLAGS[@]}" base-devel
fi

git clone https://aur.archlinux.org/paru "$PARU_TMP_DIR"
(cd "$PARU_TMP_DIR" && makepkg -si)

echo -e "\nSuccess"
