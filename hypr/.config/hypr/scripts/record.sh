#!/bin/bash

DIR="$HOME/Videos/Recordings"
PIDFILE="${XDG_RUNTIME_DIR:-/tmp}/wf-recorder.pid"

mkdir -p "$DIR"

is_our_recorder_running() {
    local pid process

    [[ -r "$PIDFILE" ]] || return 1
    read -r pid < "$PIDFILE"
    [[ "$pid" =~ ^[0-9]+$ && -r "/proc/$pid/comm" ]] || return 1

    read -r process < "/proc/$pid/comm"
    [[ "$process" == "wf-recorder" ]]
}

notify_waybar() {
    pkill -SIGRTMIN+5 waybar
}

if is_our_recorder_running; then
    read -r pid < "$PIDFILE"
    kill -INT "$pid" 2>/dev/null || true

    while kill -0 "$pid" 2>/dev/null; do
        sleep 0.1
    done

    rm -f "$PIDFILE"
    notify_waybar
    exit 0
fi

rm -f "$PIDFILE"

FILE="$DIR/record_$(date +%F_%H-%M-%S).mp4"
wf-recorder -f "$FILE" --framerate 60 &
printf '%s\n' "$!" > "$PIDFILE"

notify_waybar
