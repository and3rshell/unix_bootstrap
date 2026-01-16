#!/usr/bin/env bash

sudo pacman -Sy
sudo pacman -S archlinux-keyring
sudo pacman -Su

corePackages=(
    "intel-ucode"
    "xf86-input-libinput"
    "xf86-video-intel"

    "networkmanager"
    "network-manager-applet"
    "wireless_tools"
    "wpa_supplicant"

    "dialog"
    "mtools"
    "dosfstools"
    "base"
    "base-devel"
    "curl"
    "wget"
    "cmake"
    "socat"
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
    "xorg-xbacklight"
    "inetutils"
)

echo -e "\n===========\n\n=> Installing pacman packages..."
sudo pacman -S ${corePackages[*]} || exit 1

echo -e "\n=> Enabling systemd units..."
sudo systemctl enable --now NetworkManager bluetooth || exit 1
systemctl --user enable --now pipewire pipewire-pulse wireplumber || exit 1
# sudo systemctl enable --now cups || exit 1

echo -e "\n=> Change default shell to /bin/zsh"
echo "For root:"
sudo chsh
echo -e "\nFor user:"
chsh

if [ ! "$HOME" ]; then
    echo "HOME variable isn't set!"
    exit 1
fi

echo -e "\n=> Creating dirs..."
[ ! -d "$HOME/.cache" ] && mkdir -v "$HOME/.cache"
[ ! -f "$HOME/.cache/zsh_history" ] && touch "$HOME/.cache/zsh_history"
[ ! -d "$HOME/tmp" ] && mkdir -v "$HOME/tmp"
# [ ! -d "$HOME/.local/scripts" ] && mkdir -v "$HOME/.local/scripts"

#echo -e "\n=> Rust init..."
#sudo pacman -S rustup || exit 1

#if [ "$(command -v rustup)" ]; then
#    rustup default stable || exit 1
#fi

echo "Success."
