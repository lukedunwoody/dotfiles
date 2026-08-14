#!/bin/bash

if pgrep -x uxplay > /dev/null; then
    pkill -x uxplay
    while pgrep -x uxplay > /dev/null; do
        sleep 0.1
    done
else
    uxplay -p 35000 >/dev/null 2>&1 &
fi

pkill -RTMIN+8 waybar
