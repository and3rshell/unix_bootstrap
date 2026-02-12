#!/usr/bin/env bash

set -euo pipefail

PACMAN_FLAGS=(--needed --noconfirm)

echo "=> Installing Composer..."
sudo pacman -Syu "${PACMAN_FLAGS[@]}" php composer

if [ "$#" -eq 0 ]; then
    echo "Composer installed. Pass package names to install global Composer packages."
    exit 0
fi

echo "=> Installing global Composer packages..."
composer global require "$@"
