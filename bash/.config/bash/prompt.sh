#!/usr/bin/env bash

# # Reset variable
reset="\e[0m"

# # Define font settings
# normal="\e[0"
# bold="\e[1"
# dim="\e[2"
# italic="\e[3"
# underline="\e[4"
# blink="\e[5"
# reverse="\e[7"

# # Define text colors
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

# # Define background colors
# black_bg=";40m"
# red_bg=";41m"
# green_bg=";42m"
# yellow_bg=";43m"
# blue_bg=";44m"
# magenta_bg=";45m"
# cyan_bg=";46m"
# white_bg=";47m"
# black_bright_bg=";100m"
# red_bright_bg=";101m"
# green_bright_bg=";102m"
# yellow_bright_bg=";103m"
# blue_bright_bg=";104m"
# magenta_bright_bg=";105m"
# cyan_bright_bg=";106m"
# white_bright_bg=";107m"

# Used colors
cyanbold="\e[1;36m"
greenbold="\e[1;32m"
redbold="\e[1;31m"
reset="\e[0m"
newline="\n"

__makePS1() {
    # Start with a line separator from last output
    PS1="\[\n\]"

    # Insert path and then new line
    PS1+="\[$cyanbold\]\[\w\]\[$reset\]\[$newline\]"

    # Check if root, use bashism if possible for speed
    # else use id command for POSIX, which is slower
    if ((${EUID:-0} || "$(id -u)")); then
        PS1+="\[$greenbold\]\[λ\]\[$reset\] "
    else
        PS1+="\[$redbold\]\[π\]\[$reset\] "
    fi
}

# Set the main prompt
__makePS1

# Set the continuation prompt
PS2="\[\e[1;33m\]...\[\e[0m\] "
