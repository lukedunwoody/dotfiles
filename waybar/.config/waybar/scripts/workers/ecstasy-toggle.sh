#!/usr/bin/env bash

set -euo pipefail

RUNTIME_DIR="${XDG_RUNTIME_DIR:-/tmp}"
PID_FILE="$RUNTIME_DIR/ecstasy-lid.pid"

is_enabled() {
    [[ -f "$PID_FILE" ]] && kill -0 "$(<"$PID_FILE")" 2>/dev/null
}

enable() {
    # Pause hypridle
    pkill -STOP -x hypridle 2>/dev/null || true

    # Start lid inhibitor
    systemd-inhibit \
        --what=handle-lid-switch \
        --who="Ecstasy" \
        --why="Prevent suspend while Ecstasy is enabled" \
        sleep infinity &

    echo $! > "$PID_FILE"
}

disable() {
    # Resume hypridle
    pkill -CONT -x hypridle 2>/dev/null || true

    # Stop lid inhibitor
    if [[ -f "$PID_FILE" ]]; then
        kill "$(cat "$PID_FILE")" 2>/dev/null || true
        rm -f "$PID_FILE"
    fi
}

if is_enabled; then
    disable
else
    rm -f "$PID_FILE" 2>/dev/null || true
    enable
fi

pkill -RTMIN+6 waybar
