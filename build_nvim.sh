#!/usr/bin/env bash

NVIM_TMP_DIR="$HOME/tmp/neovim"

killall -9 nvim

git clone "https://github.com/neovim/neovim" "$NVIM_TMP_DIR" || exit 1
cd "$NVIM_TMP_DIR" || exit 1
make CMAKE_BUILD_TYPE=RelWithDebInfo
git checkout stable
sudo make install || exit 1

rm -rf "$NVIM_TMP_DIR"
