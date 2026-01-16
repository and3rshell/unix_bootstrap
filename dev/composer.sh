#!/usr/bin/env bash

set -euo pipefail

if [ "$#" -eq 0 ]; then
    echo "Usage: $0 <package> [package...]"
    exit 1
fi

echo "Make sure you have composer config dotfile first."
read -rp "Continue? [y/N] " answer

if [ "$answer" != "y" ]; then
   exit 1
fi

composer global require "$@"
