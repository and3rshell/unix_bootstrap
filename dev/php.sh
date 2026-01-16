#!/usr/bin/env bash

set -euo pipefail

PACMAN_FLAGS=(--needed --noconfirm)

sudo pacman -Syu "${PACMAN_FLAGS[@]}" composer php php-gd

sudo sed -i 's/;\(extension=gd\)/\1/' /etc/php/php.ini
