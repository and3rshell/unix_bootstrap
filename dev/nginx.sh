#!/usr/bin/env bash

set -euo pipefail

PACMAN_FLAGS=(--needed --noconfirm)

sudo pacman -Syu "${PACMAN_FLAGS[@]}" nginx php-fpm

sudo systemctl enable --now nginx
sudo systemctl enable --now php-fpm
