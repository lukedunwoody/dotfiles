#!/bin/bash

echo
read -e -p " > " cmd

if [ -n "$cmd" ]; then
    systemd-run --user --collect --quiet --service-type=exec \
        --property=ExitType=cgroup -- bash -c "$cmd"
fi
