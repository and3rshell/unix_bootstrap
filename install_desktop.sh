#!/usr/bin/env bash

set -euo pipefail

PACMAN_FLAGS=(--needed --noconfirm)

pacman_packages=(
    "i3-wm"
    "i3status"
    "polkit"
    "tmux"
    "stow"
    "picom"
    "arandr"
    "exfat-utils"
    "ntfs-3g"
    "maim"
    "unclutter"
    "unzip"
    "xcape"
    "xclip"
    "yt-dlp"
    "zathura"
    "zathura-pdf-mupdf"
    "poppler"
    "fzf"
    # "gparted"
    "ueberzug"
    "mediainfo"
    "bat"
    "ffmpeg"
    "ffmpegthumbnailer"
    "odt2txt"
    "atool"
    "mpd"
    "mpv"
    "mpc"
    "ncmpcpp"
    "dunst"
    "libnotify"
    # "libreoffice"
    "moreutils"
    "findutils"
    "gawk"
    "ripgrep"
    # "gimp"
    "highlight"
    "less"
    "lua"
    "pinentry"
    "sed"
    "unrar"
    "zip"
    "tzdata"
    "whois"
    "xwallpaper"
    "ninja"
    "direnv"
    "nodejs"
    "npm"
    "wmname"
    "go"
    # "csvlens"

    #"chromium"

    "gtk2"
    "gtk3"
    # "gtk4"
    "lxappearance"
    "qt5ct"
    "python-qdarkstyle"

    # "ttf-linux-libertine"
    # "ttf-font-awesome"
    # "ttf-dejavu"
    "ttc-iosevka"
    #"noto-fonts"
    #"noto-fonts-emoji"

    "python"
    "python-pip"

    "lazygit"
    "btop"
    "keepassxc"
    "fd"
    #"ttf-jetbrains-mono"
    #"ttf-hack-nerd"
    "dust"
    "github-cli"
    "xdotool"

#"networkmanager-vpnc"
#"vpnc"
)

sudo pacman -Syu "${PACMAN_FLAGS[@]}" "${pacman_packages[@]}" || exit 1

paru_packages=(
    "lf-bin"
    "zsh-fast-syntax-highlighting"
    "zsh-system-clipboard-git"
    # "simple-mtpfs"
    "htop-vim"
    # "task-spooler"
    # "abook"
    "nsxiv"
    "mmv-go"
    "veracrypt-console-bin"

    # "burpsuite"
    # "postman-bin"
    "brave-bin"
    "obsidian-bin"
    # "noto-color-emoji-fontconfig"
)

for paru_package in "${paru_packages[@]}"; do
    paru -S --noconfirm "$paru_package"
done

echo -e "\nlsblk"
echo "sudo mount -t vfat /dev/sdbX /mnt/second-usb -o rw,umask=0000"
echo -e "git@github.com:<username>/<repo>\n"

echo -e "\nSuccess"
