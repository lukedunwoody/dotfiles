#!/bin/bash

DIR="$HOME/Videos/Recordings"
mkdir -p "$DIR"

PIDFILE="/tmp/wf-recorder.pid"

# STOP if running
if pgrep wf-recorder >/dev/null; then
    killall wf-recorder
    rm -f "$PIDFILE"
    exit 0
fi

FILE="$DIR/record_$(date +%F_%H-%M-%S).mp4"

wf-recorder -f "$FILE" --framerate 60 &
echo $! > "$PIDFILE"
