#!/usr/bin/env bash

GIT_DIR="$HOME/.local/projects/git"
GIT_USERNAME="prosp3ro"

[ ! -d "$GIT_DIR" ] && mkdir -p "$GIT_DIR"

echo "Build st? [y/N]"
read -rp "Choice: " answer
if [ "$answer" == "y" ]; then
    git clone "git@github.com:$GIT_USERNAME/st-enhanced.git" "$GIT_DIR/st-enhanced"
    cd "$GIT_DIR/st-enhanced" || exit 1
    sudo make install || exit 1
fi

echo "Build dmenu? [y/N]"
read -rp "Choice: " answer
if [ "$answer" == "y" ]; then
    git clone "git@github.com:$GIT_USERNAME/dmenu-enhanced.git" "$GIT_DIR/dmenu-enhanced"
    cd "$GIT_DIR/dmenu-enhanced" || exit 1
    sudo make install || exit 1
fi

#echo "Build moonwm? [y/N]"
#read -rp "Choice: " answer
#if [ "$answer" == "y" ]; then
#    git clone "git@github.com:$GIT_USERNAME/moonwm.git" "$GIT_DIR/moonwm"
#    cd "$GIT_DIR/moonwm" || exit 1
#    sudo make install || exit 1
#fi

#echo "Build dwmblocks-async? [y/N]"
#read -rp "Choice: " answer
#if [ "$answer" == "y" ]; then
#    git clone "git@github.com:$GIT_USERNAME/dwmblocks-async.git" "$GIT_DIR/dwmblocks-async"
#    cd "$GIT_DIR/dwmblocks-async" || exit 1
#    sudo make install || exit 1
#fi
