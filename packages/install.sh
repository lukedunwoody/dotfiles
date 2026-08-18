#!/usr/bin/env bash

set -euo pipefail

if (( EUID == 0 )); then
    echo "Do not run this script with sudo."
    echo "Run it normally; it will use sudo when needed."
    exit 1
fi

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

sudo pacman -S --needed --noconfirm - < "$script_dir/arch.txt"

if ! command -v yay >/dev/null 2>&1; then
    build_dir="$(mktemp -d)"
    trap 'rm -rf "$build_dir"' EXIT

    git clone https://aur.archlinux.org/yay-bin.git "$build_dir/yay-bin"

    (
        cd "$build_dir/yay-bin"
        makepkg -si --noconfirm
    )
fi

yay -S --needed --noconfirm - < "$script_dir/aur.txt"

mapfile -t flatpaks < <(
    grep -Ev '^[[:space:]]*(#|$)' "$script_dir/flatpak.txt"
)

flatpak install -y flathub "${flatpaks[@]}"
