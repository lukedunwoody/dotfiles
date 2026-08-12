#!/bin/bash

pending_file="${XDG_RUNTIME_DIR:-/tmp}/waybar-power-profile.pending"

# Do not read the hardware while a change is in progress: that read can wait
# for the firmware write. The pending file is enough to update immediately.
if [ -f "$pending_file" ]; then
    profile=$(cat "$pending_file")
    tooltip="Switching to: $profile"
else
    profile=$(cat /sys/firmware/acpi/platform_profile)
    tooltip="Current profile: $profile"
fi

case "$profile" in
    quiet)
        text="󰾆"
        ;;
    balanced)
        text="󰾅"
        ;;
    performance)
        text="󰓅"
        ;;
    *)
        text=""
        ;;
esac

echo "{\"text\":\"$text\", \"tooltip\":\"$tooltip\"}"
