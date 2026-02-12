#!/usr/bin/env bash

set -euo pipefail

PACMAN_FLAGS=(--needed --noconfirm)

sudo pacman -Syu "${PACMAN_FLAGS[@]}" composer php php-fpm php-gd

sudo sed -i 's/;\(extension=gd\)/\1/' /etc/php/php.ini

echo "php-fpm installed. Enable it with: sudo systemctl enable --now php-fpm"
