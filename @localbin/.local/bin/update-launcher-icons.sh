#!/usr/bin/env bash

set -eo pipefail

if [[ $# -eq 0 ]]; then
    echo "Usage: $0 {icon-set-folder-name}"
    exit 1
fi

PATHARR=(
    "/usr/share/icons/$1"
    "$HOME/.local/share/icons/$1"
    "$HOME/.icons/$1"
)

EXIST=false

NOTFOUNDERR="$1 not found in:
    /usr/share/icons/
    $HOME/.local/share/icons/
    $HOME/.icons/

Aborting."

for dir in "${PATHARR[@]}"; do
    if [ -d $dir ]; then
        EXIST=true
        break
    fi
done

if $EXIST; then
    sudo -u gdm dbus-launch gsettings set org.gnome.desktop.interface icon-theme $1
    exit 0
else
    echo "$NOTFOUNDERR"
    exit 1
fi


