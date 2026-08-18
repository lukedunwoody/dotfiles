#!/usr/bin/env bash

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

watch_script_dir="$HOME/.config/waybar/scripts/watchers"

start_watcher "bluetooth" "$watch_script_dir/bluetooth-watch.sh"
start_watcher "proton-vpn" "$watch_script_dir/proton-vpn-watch.sh"
start_watcher "swaync" "$watch_script_dir/swaync-watch.sh"
