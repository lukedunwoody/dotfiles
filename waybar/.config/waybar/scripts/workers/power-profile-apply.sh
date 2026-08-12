#!/usr/bin/env bash

set -euo pipefail

profile_path="/sys/firmware/acpi/platform_profile"
pending_file="${XDG_RUNTIME_DIR:-/tmp}/waybar-power-profile.pending"
next="$1"

if printf '%s\n' "$next" |
    sudo -n /usr/bin/tee "$profile_path" >/dev/null; then
    rm -f "$pending_file"
else
    rm -f "$pending_file"
fi

# Show the confirmed profile, or revert after a failed write.
pkill -SIGRTMIN+5 waybar
