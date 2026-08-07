#!/bin/bash

nmcli monitor | while read -r line; do
    pkill -SIGRTMIN+3 waybar
done
