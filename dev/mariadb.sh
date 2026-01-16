#!/usr/bin/env bash

set -euo pipefail

PACMAN_FLAGS=(--needed --noconfirm)

sudo pacman -Syu "${PACMAN_FLAGS[@]}" mariadb
sudo mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

sudo systemctl start mysqld
sudo systemctl start mysql.service
sudo systemctl enable --now mariadb

read -rp "Database username: " user
read -rp "Database user password: " password

# [ ! "$USER" ] && echo "USER variable is not set!" && exit 1

db_command="CREATE USER '$user'@'localhost' IDENTIFIED BY '$password';"

echo "running command: $db_command..."
sudo mariadb -e "$db_command" || exit 1
