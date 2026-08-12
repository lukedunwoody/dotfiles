#!/bin/bash

nmcli monitor | while read -r line; do
    pkill -SIGRTMIN+4 waybar
done
