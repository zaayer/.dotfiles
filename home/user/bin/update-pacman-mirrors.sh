#!/usr/bin/env sh

sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup

curl -s "https://www.archlinux.org/mirrorlist/?country=US&protocol=https&ip_version=4&use_mirror_status=on" | \
sed -e 's/^#Server/Server/' -e '/^#/d' - | \
rankmirrors -n 5 - > /tmp/mirrorlist

sudo cp /tmp/mirrorlist /etc/pacman.d/

if [ -d "$HOME/.dotfiles/etc/pacman.d" ]; then
    if [ -e "$HOME/.dotfiles/etc/pacman.d/mirrorlist" ]; then
        cp $HOME/.dotfiles/etc/pacman.d/mirrorlist $HOME/.dotfiles/etc/pacman.d/mirrorlist.backup
    fi
    cp /tmp/mirrorlist $HOME/.dotfiles/etc/pacman.d/mirrorlist
fi

rm /tmp/mirrorlist
