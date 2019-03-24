#!/usr/bin/env sh

url="https://someonewhocares.org/hosts/hosts"

sudo cp /etc/hosts /etc/hosts.backup
sudo curl -s $url -o /etc/hosts

if [ -d "$HOME/.dotfiles/etc/" ]; then
    if [ -e "$HOME/.dotfiles/etc/hosts" ]; then
        cp $HOME/.dotfiles/etc/hosts $HOME/.dotfiles/etc/hosts.backup
    fi
    cp /etc/hosts $HOME/.dotfiles/etc/hosts
fi
