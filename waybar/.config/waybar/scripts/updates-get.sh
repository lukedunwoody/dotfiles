#!/bin/bash

# Get update counts
pacman_updates=$(checkupdates 2>/dev/null | wc -l)
aur_updates=$(yay -Qua 2>/dev/null | wc -l)
flatpak_updates=$(flatpak remote-ls --updates 2>/dev/null | wc -l)

total=$((pacman_updates + aur_updates + flatpak_updates))

# Text shown in Waybar
if [ "$total" -gt 0 ]; then
    text="  ($total)"
    class="has-updates"
else
    text=""
    class="up-to-date"
fi

# Build tooltip
tooltip=""

[ "$pacman_updates" -gt 0 ] && tooltip+="Pacman: $pacman_updates\n"
[ "$aur_updates" -gt 0 ] && tooltip+="AUR: $aur_updates\n"
[ "$flatpak_updates" -gt 0 ] && tooltip+="Flatpak: $flatpak_updates\n"

# Remove trailing newline
tooltip="${tooltip%\\n}"

# If no updates exist
if [ -z "$tooltip" ]; then
    tooltip="Everything is up to date."
fi

echo "{\"text\":\"$text\", \"tooltip\":\"$tooltip\", \"class\":\"$class\"}"
