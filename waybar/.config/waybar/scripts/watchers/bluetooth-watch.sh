#!/bin/bash

while true; do
    bluetoothctl monitor | while read -r line; do
        pkill -SIGRTMIN+3 waybar
    done

    sleep 1
done
