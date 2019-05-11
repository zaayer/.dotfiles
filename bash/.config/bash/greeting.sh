#!/usr/bin/env bash

echo -e "\e[1;36mWelcome to Bash $BASH_VERSION\n"

if command -v neofetch &>/dev/null; then
    neofetch
    echo -e "\n"
fi

if command -v fortune &>/dev/null; then
    echo -e "\e[0;33m$(fortune -sa)\n"
fi
