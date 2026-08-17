#!/usr/bin/env bash

# Install a least-privilege rule that lets the Waybar power-profile module
# switch this laptop's raw ACPI platform profile without prompting for sudo.
set -euo pipefail

profile_path="/sys/firmware/acpi/platform_profile"
choices_path="/sys/firmware/acpi/platform_profile_choices"
sudoers_file="/etc/sudoers.d/waybar-platform-profile"
tee_path="/usr/bin/tee"

if [[ "${EUID}" -eq 0 ]]; then
    printf 'Run this script as your normal user, not as root.\n' >&2
    exit 1
fi

if [[ ! -r "$profile_path" || ! -r "$choices_path" ]]; then
    printf 'No readable ACPI platform-profile interface was found.\n' >&2
    exit 1
fi

choices="$(<"$choices_path")"
for required_profile in quiet balanced performance; do
    if [[ " $choices " != *" $required_profile "* ]]; then
        printf 'This firmware does not support the required profile: %s\n' "$required_profile" >&2
        printf 'Available profiles: %s\n' "$choices" >&2
        exit 1
    fi
done

if [[ ! -x "$tee_path" ]]; then
    printf 'Expected tee at %s, but it was not found.\n' "$tee_path" >&2
    exit 1
fi

if ! command -v visudo >/dev/null; then
    printf 'visudo is required to validate the sudoers rule.\n' >&2
    exit 1
fi

rule_file="$(mktemp)"
trap 'rm -f "$rule_file"' EXIT

user="$(id -un)"
printf '%s ALL=(root) NOPASSWD: %s %s\n' \
    "$user" "$tee_path" "$profile_path" > "$rule_file"

visudo -c -f "$rule_file"

printf 'Installing passwordless access for %s to change the platform profile...\n' "$user"
sudo install -o root -g root -m 0440 "$rule_file" "$sudoers_file"
sudo visudo -c -f "$sudoers_file"

# An empty input verifies that the exact command matches the new rule without
# changing the current profile.
sudo -n "$tee_path" "$profile_path" </dev/null >/dev/null

printf 'Installed %s. Waybar can now switch quiet, balanced, and performance without a password prompt.\n' \
    "$sudoers_file"
