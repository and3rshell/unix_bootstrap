#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=config.sh
. "$SCRIPT_DIR/config.sh"

NVIM_TMP_DIR="$TMP_DIR/neovim"

cleanup_nvim_tmp_dir() {
    if [ -d "$NVIM_TMP_DIR" ]; then
        rm -rf "$NVIM_TMP_DIR" 2>/dev/null || sudo rm -rf "$NVIM_TMP_DIR"
    fi
}

if pgrep -x nvim >/dev/null; then
    killall -9 nvim
fi

cleanup_nvim_tmp_dir
trap cleanup_nvim_tmp_dir EXIT

git clone --branch stable --single-branch "https://github.com/neovim/neovim" "$NVIM_TMP_DIR"
make -C "$NVIM_TMP_DIR" CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make -C "$NVIM_TMP_DIR" install
