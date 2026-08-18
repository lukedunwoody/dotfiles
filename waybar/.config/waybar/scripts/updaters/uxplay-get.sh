#!/usr/bin/env bash

if pgrep -x uxplay > /dev/null; then
    text="󰦉"
    tooltip="UxPlay is running."
    class="active"
else
    text="󰄢"
    tooltip="UxPlay is not running."
    class="inactive"
fi

echo "{\"text\":\"$text\", \"tooltip\":\"$tooltip\", \"class\":\"$class\"}"
