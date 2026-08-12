#!/bin/bash

swaync-client -swb | while read -r _; do
    pkill -SIGRTMIN+2 waybar
done
