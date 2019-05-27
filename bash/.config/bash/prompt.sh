#!/usr/bin/env bash

# # Reset variable
# reset="\e[0m"

# # Define font settings
# normal="\e[0"
# bold="\e[1"
# dim="\e[2"
# italic="\e[3"
# underline="\e[4"
# blink="\e[5"
# reverse="\e[7"

# # Define text colors, add 10 for background colors
# black_fg=";30m"
# red_fg=";31m"
# green_fg=";32m"
# yellow_fg=";33m"
# blue_fg=";34m"
# magenta_fg=";35m"
# cyan_fg=";36m"
# white_fg=";37m"
# black_bright_fg=";90m"
# red_bright_fg=";91m"
# green_bright_fg=";92m"
# yellow_bright_fg=";93m"
# blue_bright_fg=";94m"
# magenta_bright_fg=";95m"
# cyan_bright_fg=";96m"
# white_bright_fg=";97m"

# Used colors
blackbold="\e[1;30m"
redbold="\e[1;31m"
greenbold="\e[1;32m"
yellowbold="\e[1;33m"
bluebold="\e[1;34m"
magentabold="\e[1;35m"
cyanbold="\e[1;36m"
whitebold="\e[1;37m"
reset="\e[0m"

__makePS1_two() {
    # Start with a line separator from last output
    PS1="\[\n\]"

    # Insert path and then new line
    PS1+="\[$cyanbold\]\w\[\n\]"

    # Check if root, use bashism if possible for speed
    # else use id command for POSIX, which is slower
    if ((${EUID:-0} || "$(id -u)")); then
        PS1+="\[$greenbold\]\[$\]\[$reset\] "
    else
        PS1+="\[$redbold\]\[#\]\[$reset\] "
    fi
}

__makePS1() {
    # Start with a line separator from last output
    PS1="\[\n\]"

    # Check if root, use bashism if possible for speed
    # else use id command for POSIX, which is slower
    if ((${EUID:-0} || "$(id -u)")); then
        PS1+="[\[$yellowbold\]\h\[$whitebold\]:\[$cyanbold\]\W\[$reset\]]\[$greenbold\]\[$\]\[$reset\] "
    else
        PS1+="[\[$yellowbold\]\h\[$whitebold\]:\[$cyanbold\]\W\[$reset\]]\[$redbold\]\[#\]\[$reset\] "
    fi
}

PS0="\[$reset\]"

# Set the main prompt
__makePS1

# Set the continuation prompt
PS2="\[$yellowbold\]...\[$reset\] "

# Unset variables
unset blackbold
unset redbold
unset greenbold
unset yellowbold
unset bluebold
unset magentabold
unset cyanbold
unset whitebold
unset reset
