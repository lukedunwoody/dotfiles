#!/bin/bash

yay -Syu --noconfirm
flatpak update -y

killall -SIGRTMIN+1 waybar
