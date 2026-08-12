#!/bin/bash

count=$(swaync-client -c)

if [ "$count" -eq 0 ]; then
    text="󰂜"
    tooltip="No new notifications."
else
    text="󱅫  ($count)"
    tooltip="$count unread notification"
    [ "$count" -ne 1 ] && tooltip="${tooltip}s"
fi

echo "{\"text\":\"$text\", \"tooltip\":\"$tooltip\"}"
