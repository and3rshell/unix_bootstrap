#!/usr/bin/env bash

set -euo pipefail

sudo id

paru -S --noconfirm php74
paru -S --noconfirm php74-mbstring
paru -S --noconfirm php74-phar
paru -S --noconfirm php74-iconv
paru -S --noconfirm php74-gd
paru -S --noconfirm php74-pgsql
paru -S --noconfirm php74-openssl
paru -S --noconfirm php74-json
paru -S --noconfirm php74-fileinfo
paru -S --noconfirm php74-tokenizer
paru -S --noconfirm php74-dom
paru -S --noconfirm php74-pdo
paru -S --noconfirm php74-pear
paru -S --noconfirm php74-xmlwriter
paru -S --noconfirm php74-ctype
paru -S --noconfirm php74-simplexml
paru -S --noconfirm php74-xmlreader
paru -S --noconfirm php74-zip
paru -S --noconfirm php74-mysql

sudo sed -i 's/;\(extension=gd\)/\1/' /etc/php74/php.ini
