#!/usr/bin/env bash

set -eo pipefail

sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup

curl -s "https://www.archlinux.org/mirrorlist/?country=US&protocol=https&ip_version=4&use_mirror_status=on" | \
sed -e 's/^#Server/Server/' -e '/^#/d' - | \
rankmirrors -n 5 - | \
sudo tee /etc/pacman.d/mirrorlist > /dev/null


if [ -d "$HOME/.dotfiles/_@root/etc/pacman.d" ]; then
    if [ -e "$HOME/.dotfiles/_@root/etc/pacman.d/mirrorlist" ]; then
        cp $HOME/.dotfiles/_@root/etc/pacman.d/mirrorlist $HOME/.dotfiles/_@root/etc/pacman.d/mirrorlist.backup
    fi
    cp /etc/pacman.d/mirrorlist $HOME/.dotfiles/_@root/etc/pacman.d/mirrorlist
fi
