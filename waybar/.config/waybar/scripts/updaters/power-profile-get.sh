#!/bin/bash

pending_file="${XDG_RUNTIME_DIR:-/tmp}/waybar-power-profile.pending"
profile_path="/sys/firmware/acpi/platform_profile"

read_profile() {
    local profile

    # The HP platform-profile interface can briefly return EINVAL while the
    # firmware is reinitializing after resume. Keep Waybar's one-shot startup
    # refresh, but wait briefly for the interface to become available.
    for _ in {1..8}; do
        if profile=$(cat "$profile_path" 2>/dev/null); then
            printf '%s\n' "$profile"
            return 0
        fi
        sleep 0.25
    done

    return 1
}

# Do not read the hardware while a change is in progress: that read can wait
# for the firmware write. The pending file is enough to update immediately.
if [ -f "$pending_file" ]; then
    profile=$(cat "$pending_file")
    tooltip="Switching to: $profile"
elif profile=$(read_profile); then
    tooltip="Current profile: $profile"
else
    echo '{"text":"", "tooltip":"Power profile is temporarily unavailable"}'
    exit 0
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
