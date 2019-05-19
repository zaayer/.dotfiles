#!/usr/bin/env bash

# Use colored man pages
man() {
    env LESS_TERMCAP_mb=$'\E[1;31m' \
        LESS_TERMCAP_md=$'\E[1;34m' \
        LESS_TERMCAP_me=$'\E[0m' \
        LESS_TERMCAP_so=$'\E[47m\E[1;30m' \
        LESS_TERMCAP_se=$'\E[0m' \
        LESS_TERMCAP_us=$'\E[1;32m' \
        LESS_TERMCAP_ue=$'\E[0m' \
        man "$@"
}

# Shorten fff and use a set cache
f() {
    fff "$@"
    cd "$(< ~/.cache/fff/fff.d)"
}

mkcd() {
    last=$(eval "echo \$$#")
    if [ ! -n "$last" ]; then
        echo "Enter a directory name"
    elif [ -d $last ]; then
        echo "\`$last' already exists"
    else
        mkdir $@ && cd $last
    fi
}

trd() {
    if command -v tree &>/dev/null; then
        command tree -Cd $@
    else
        echo "tree not found in path."
    fi
}

yup() {
    yay
    yay -Yc
    yay -Sc --noconfirm
    rustup update
}
