#!/usr/bin/env bash

set -euo pipefail

# paru -S mailhog-bin
# paru -S mailpit
paru -S --noconfirm mailpit-bin

# sudo systemctl enable --now mailhog
sudo systemctl enable --now mailpit

# go install github.com/mailhog/MailHog@latest
# go install github.com/axllent/mailpit@latest
