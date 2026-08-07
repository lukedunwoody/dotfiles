#!/bin/bash

# Check if Bluetooth is powered on
powered=$(bluetoothctl show | grep "Powered: yes")

if [ -z "$powered" ]; then
    text="󰂲"
    tooltip="Bluetooth is disabled."
else
    # Get connected devices
    devices=$(bluetoothctl devices Connected | sed 's/Device [A-F0-9:]* //')
    device_count=$(echo "$devices" | grep -c .)

    if [ "$device_count" -eq 0 ]; then
        text="󰂯"
        tooltip="Bluetooth is enabled but no devices are connected."
    else
        text="󰂱  ($device_count)"
        tooltip="Devices connected:\n$devices"
    fi
fi

echo "{\"text\":\"$text\", \"tooltip\":\"$tooltip\"}"
