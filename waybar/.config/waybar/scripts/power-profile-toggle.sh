#!/usr/bin/env bash

set -euo pipefail

profile_path="/sys/firmware/acpi/platform_profile"
pending_file="${XDG_RUNTIME_DIR:-/tmp}/waybar-power-profile.pending"
script_dir="$(dirname "$0")"
current="$(<"$profile_path")"

case "$current" in
    quiet)
        next="balanced"
        ;;
    balanced)
        next="performance"
        ;;
    performance)
        next="quiet"
        ;;
    *)
        printf 'Unknown platform profile: %s\n' "$current" >&2
        exit 1
        ;;
esac

# Update Waybar first, then apply the slow firmware change in the background.
printf '%s\n' "$next" > "$pending_file"
pkill -SIGRTMIN+7 waybar
nohup "$script_dir/power-profile-apply.sh" "$next" >/dev/null 2>&1 &
