#!/bin/bash

vpn=$(nmcli -t -f TYPE,NAME connection show --active | grep '^vpn:')

if [ -n "$vpn" ]; then
    server=$(echo "$vpn" | sed 's/^vpn://')

    text="󱎚"
    tooltip="Proton VPN connected\nServer: $server"
else
    text="󱚱"
    tooltip="Proton VPN disconnected"
fi

echo "{\"text\":\"$text\", \"tooltip\":\"$tooltip\"}"
