#!/usr/bin/env bash

set -eo pipefail

if [[ $# -eq 0 ]]; then
    echo "Usage: $0 {icon-set-folder-name}"
    exit 1
fi

PATHARR=(
    "/usr/share/icons/$1/cursors"
    "$HOME/.local/share/icons/$1/cursors"
    "$HOME/.icons/$1/cursors"
)

EXIST=false

NOTFOUNDERR="$1 or cursors directory not found in:
    /usr/share/icons/$1/cursors/
    $HOME/.local/share/icons/$1/cursors
    $HOME/.icons/$1/cursors

Aborting."

for dir in "${PATHARR[@]}"; do
    if [ -d $dir ]; then
        EXIST=true
        break
    fi
done

if $EXIST; then
    sudo -u gdm dbus-launch gsettings set org.gnome.desktop.interface cursor-theme $1
    exit 0
else
    echo "$NOTFOUNDERR"
    exit 1
fi


