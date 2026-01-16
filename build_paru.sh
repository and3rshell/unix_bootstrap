#!/usr/bin/env bash

PARU_TMP_DIR="$HOME/tmp/paru"

[ ! -d "$HOME/tmp" ] && mkdir -p "$HOME/tmp"
[ -d "$PARU_TMP_DIR" ] && rm -rf "$PARU_TMP_DIR"

sudo pacman -S --needed base-devel

git clone https://aur.archlinux.org/paru-bin "$PARU_TMP_DIR" || exit 1
cd "$PARU_TMP_DIR" || exit 1
makepkg -si
[ -d "$PARU_TMP_DIR" ] && rm -rf "$PARU_TMP_DIR"

echo -e "\nSuccess"
