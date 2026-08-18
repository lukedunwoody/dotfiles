#!/usr/bin/env bash

RUNTIME_DIR="${XDG_RUNTIME_DIR:-/tmp}"
PID_FILE="$RUNTIME_DIR/ecstasy-lid.pid"

if [[ -f "$PID_FILE" ]] && kill -0 "$(cat "$PID_FILE")" 2>/dev/null; then
    text="󰐂"
    tooltip="Ecstacy enabled"
    class="enabled"
else
    rm -f "$PID_FILE" 2>/dev/null
    text="󱩜"
    tooltip="Ecstacy disabled"
    class="disabled"
fi

echo "{\"text\":\"$text\", \"tooltip\":\"$tooltip\", \"class\":\"$class\"}"
