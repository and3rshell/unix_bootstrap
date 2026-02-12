#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=config.sh
. "$SCRIPT_DIR/config.sh"

NVIM_TMP_DIR="$TMP_DIR/neovim"

if pgrep -x nvim >/dev/null; then
    killall -9 nvim
fi

rm -rf "$NVIM_TMP_DIR"
trap 'rm -rf "$NVIM_TMP_DIR"' EXIT

git clone "https://github.com/neovim/neovim" "$NVIM_TMP_DIR"
make -C "$NVIM_TMP_DIR" CMAKE_BUILD_TYPE=RelWithDebInfo
git -C "$NVIM_TMP_DIR" checkout stable
sudo make -C "$NVIM_TMP_DIR" install
