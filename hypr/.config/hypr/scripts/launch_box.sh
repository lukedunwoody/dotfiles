#!/bin/bash

echo
read -e -p " > " cmd

if [ -n "$cmd" ]; then
    systemd-run --user --collect --quiet -- bash -c "$cmd"
fi
