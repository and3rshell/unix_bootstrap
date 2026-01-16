#!/usr/bin/env bash

set -euo pipefail

PACMAN_FLAGS=(--needed --noconfirm)

sudo pacman -Syu "${PACMAN_FLAGS[@]}" postgresql php-pgsql
sudo su -l postgres -c "initdb --locale=C.UTF-8 --encoding=UTF8 -D '/var/lib/postgres/data'"
sudo systemctl enable --now postgresql
sudo su -l postgres -c "createuser --interactive"

sudo sed -i 's/;\(extension=pdo_pgsql\)/\1/' /etc/php/php.ini
sudo sed -i 's/;\(extension=pgsql\)/\1/' /etc/php/php.ini
