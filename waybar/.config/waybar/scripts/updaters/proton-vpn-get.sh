#!/usr/bin/env bash

vpn=$(nmcli -t -f TYPE,NAME connection show --active | grep '^vpn:')

if [ -n "$vpn" ]; then
    server=$(echo "$vpn" | sed 's/^vpn://')

    text="󱎚"
    tooltip="Proton VPN connected\nServer: $server"
    class="connected"
else
    text="󱚱"
    tooltip="Proton VPN disconnected"
    class="disconnected"
fi

echo "{\"text\":\"$text\", \"tooltip\":\"$tooltip\", \"class\":\"$class\"}"
