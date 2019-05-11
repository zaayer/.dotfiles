#!/usr/bin/env bash

# Use colored man pages
man() {
    env LESS_TERMCAP_mb="\e[1;31m" \
        LESS_TERMCAP_md="\e[1;34m" \
        LESS_TERMCAP_me="\e[0m" \
        LESS_TERMCAP_so="\e[47m\e[1;30m" \
        LESS_TERMCAP_se="\e[0m" \
        LESS_TERMCAP_us="\e[1;32m" \
        LESS_TERMCAP_ue="\e[0m" \
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
