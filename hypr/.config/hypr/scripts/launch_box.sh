#!/bin/bash

echo ""
read -e -p " > " cmd
[ -n "$cmd" ] && eval "$cmd"
