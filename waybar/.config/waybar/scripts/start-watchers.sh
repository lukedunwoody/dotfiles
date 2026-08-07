#!/bin/bash

set -u

runtime_dir="${XDG_RUNTIME_DIR:-/tmp}"

start_watcher() {
    local name="$1"
    local script="$2"
    local pid_file="$runtime_dir/waybar-${name}-watch.pid"

    if [[ -f "$pid_file" ]] && kill -0 "$(<"$pid_file")" 2>/dev/null; then
        return
    fi

    rm -f "$pid_file"
    nohup "$script" >/dev/null 2>&1 &
    printf '%s\n' "$!" > "$pid_file"
}

start_watcher "bluetooth" "$HOME/.config/waybar/scripts/bluetooth-watch.sh"
start_watcher "proton-vpn" "$HOME/.config/waybar/scripts/proton-vpn-watch.sh"
start_watcher "swaync" "$HOME/.config/waybar/scripts/swaync-watch.sh"
