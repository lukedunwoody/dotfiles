#!/bin/bash

count=$(swaync-client -c)

if [ "$count" -eq 0 ]; then
    text="󰂜"
    tooltip="No new notifications."
    class="no-notifications"
else
    text="󱅫  ($count)"
    tooltip="$count unread notification"
    class="has-notifications"
    [ "$count" -ne 1 ] && tooltip="${tooltip}s"
fi

echo "{\"text\":\"$text\", \"tooltip\":\"$tooltip\", \"class\":\"$class\"}"
