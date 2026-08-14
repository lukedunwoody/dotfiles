#!/bin/bash

PIDFILE="${XDG_RUNTIME_DIR:-/tmp}/wf-recorder.pid"

text="󰝦"
tooltip="Record script inactive"
class="not-recording"

if [[ -r "$PIDFILE" ]]; then
    read -r pid < "$PIDFILE"

    if [[ "$pid" =~ ^[0-9]+$ && -r "/proc/$pid/comm" ]]; then
        read -r process < "/proc/$pid/comm"

        if [[ "$process" == "wf-recorder" ]]; then
            text="󰻃"
            tooltip="Record script active"
            class="is-recording"
        fi
    fi
fi

echo "{\"text\":\"$text\", \"tooltip\":\"$tooltip\", \"class\":\"$class\"}"
