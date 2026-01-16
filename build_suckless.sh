#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=config.sh
. "$SCRIPT_DIR/config.sh"

[ ! -d "$GIT_DIR" ] && mkdir -p "$GIT_DIR"

usage() {
    echo "Usage: $0 [--all] [--st] [--dmenu]"
}

clone_or_update() {
    local repo_url="$1"
    local repo_dir="$2"

    if [ -d "$repo_dir/.git" ]; then
        git -C "$repo_dir" pull --rebase
        return
    fi

    git clone "$repo_url" "$repo_dir"
}

build_repo() {
    local name="$1"
    local repo_url="$2"
    local repo_dir="$3"

    echo "==> Building $name"
    clone_or_update "$repo_url" "$repo_dir"
    sudo make -C "$repo_dir" install
}

if [ "$#" -eq 0 ]; then
    usage
    exit 1
fi

build_all=0
build_st=0
build_dmenu=0

while [ "$#" -gt 0 ]; do
    case "$1" in
        --all) build_all=1 ;;
        --st) build_st=1 ;;
        --dmenu) build_dmenu=1 ;;
        -h|--help) usage; exit 0 ;;
        *) echo "Unknown flag: $1"; usage; exit 1 ;;
    esac
    shift
done

if [ "$build_all" -eq 1 ]; then
    build_st=1
    build_dmenu=1
fi

if [ "$build_st" -eq 1 ]; then
    build_repo "st" "git@github.com:$GIT_USERNAME/st-enhanced.git" "$GIT_DIR/st-enhanced"
fi

if [ "$build_dmenu" -eq 1 ]; then
    build_repo "dmenu" "git@github.com:$GIT_USERNAME/dmenu-enhanced.git" "$GIT_DIR/dmenu-enhanced"
fi
