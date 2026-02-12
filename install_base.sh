#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=config.sh
. "$SCRIPT_DIR/config.sh"

PACMAN_FLAGS=(--needed --noconfirm)

sudo pacman -Syu "${PACMAN_FLAGS[@]}" archlinux-keyring

corePackages=(
    "amd-ucode"
    "xf86-input-libinput"
    "networkmanager"
    "network-manager-applet"
    "wireless_tools"
    "wpa_supplicant"
    "openvpn"
    "dialog"
    "mtools"
    "dosfstools"
    "base"
    "base-devel"
    "curl"
    "wget"
    "cmake"
    "go"
    "socat"
    "docker"
    "docker-compose"
    "lazydocker"
    "dive"
    "trivy"
    "openssh"
    "zsh"
    "zsh-autosuggestions"
    "bluez"
    "bluez-utils"
    "blueman"
    "pipewire"
    "wireplumber"
	"pipewire-audio"
	"pipewire-pulse"
	"pipewire-alsa"
	"pipewire-jack"
	"gst-plugin-pipewire"
    "xdg-utils"
    "xdg-user-dirs"
    "xorg"
    "xorg-server"
    "xorg-xwininfo"
    "xorg-setxkbmap"
    "xorg-xprop"
    "inetutils"
)

echo -e "\n===========\n\n=> Installing pacman packages..."
sudo pacman -Syu "${PACMAN_FLAGS[@]}" "${corePackages[@]}" || exit 1

echo -e "\n=> Enabling systemd units..."
sudo systemctl enable --now NetworkManager bluetooth docker || exit 1
systemctl --user enable --now pipewire pipewire-pulse wireplumber || exit 1
# sudo systemctl enable --now cups || exit 1

TARGET_USER="${SUDO_USER:-${USER:-}}"
if [ -n "$TARGET_USER" ] && [ "$TARGET_USER" != "root" ] && id -u "$TARGET_USER" >/dev/null 2>&1; then
    if ! id -nG "$TARGET_USER" | grep -qw docker; then
        echo -e "\n=> Adding '$TARGET_USER' to docker group..."
        sudo usermod -aG docker "$TARGET_USER" || exit 1
        echo "Re-login is required for docker group membership to take effect."
    fi
fi

echo -e "\n=> Change default shell to /bin/zsh"
echo "For root:"
sudo chsh
echo -e "\nFor user:"
chsh

if [ -z "${HOME:-}" ]; then
    echo "HOME variable isn't set!"
    exit 1
fi

echo -e "\n=> Creating dirs..."
[ ! -d "$HOME/.cache" ] && mkdir -v "$HOME/.cache"
[ ! -f "$HOME/.cache/zsh_history" ] && touch "$HOME/.cache/zsh_history"
[ ! -d "$HOME/tmp" ] && mkdir -v "$HOME/tmp"
[ ! -d "$HOME/.local" ] && mkdir -v "$HOME/.local"

if [ -z "${GIT_USERNAME:-}" ]; then
    echo "GIT_USERNAME is not set in config.sh."
    exit 1
fi

SCRIPTS_REPO_URL="git@github.com:${GIT_USERNAME}/scripts.git"
SCRIPTS_DIR="$HOME/.local/scripts"

if [ -d "$SCRIPTS_DIR" ]; then
    echo -e "\n=> $SCRIPTS_DIR already exists; skipping clone."
else
    echo -e "\n=> Cloning $SCRIPTS_REPO_URL to $SCRIPTS_DIR..."
    git clone "$SCRIPTS_REPO_URL" "$SCRIPTS_DIR" || exit 1
fi

#echo -e "\n=> Rust init..."
#sudo pacman -S rustup || exit 1

#if [ "$(command -v rustup)" ]; then
#    rustup default stable || exit 1
#fi

echo "Success."
