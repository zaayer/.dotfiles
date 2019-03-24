#!/usr/bin/env bash

if [ ! -d ./pkgs ]; then
    mkdir pkgs
fi

# List explicitly installed packages, exlcuding base and base-devel with size/desc
expac -H M "%011m\t%-40n\t%10d" \
$(comm -23 <(pacman -Qqen | sort) <(pacman -Qqg base base-devel | sort)) | \
sort -n > ./pkgs/explicit-installed.txt

# List changed system configuration files
pacman -Qii | awk '/^MODIFIED/ {print $2}' > ./pkgs/changed-system-files.txt
