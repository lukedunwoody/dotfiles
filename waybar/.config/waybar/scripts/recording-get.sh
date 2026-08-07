#!/bin/bash

PIDFILE="${XDG_RUNTIME_DIR:-/tmp}/wf-recorder.pid"

if [[ -r "$PIDFILE" ]]; then
    read -r pid < "$PIDFILE"

    if [[ "$pid" =~ ^[0-9]+$ && -r "/proc/$pid/comm" ]]; then
        read -r process < "/proc/$pid/comm"

        if [[ "$process" == "wf-recorder" ]]; then
            echo "󰻃  Recording"
            exit 0
        fi
    fi
fi

echo "󰝦"
