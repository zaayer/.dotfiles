#!/usr/bin/env bash

# # Reset variable
# local reset="\e[0m"

# # Define font settings
# local normal="\e[0"
# local bold="\e[1"
# local dim="\e[2"
# local italic="\e[3"
# local underline="\e[4"
# local blink="\e[5"
# local reverse="\e[7"

# # Define text colors
# local black_fg=";30m"
# local red_fg=";31m"
# local green_fg=";32m"
# local yellow_fg=";33m"
# local blue_fg=";34m"
# local magenta_fg=";35m"
# local cyan_fg=";36m"
# local white_fg=";37m"
# local black_bright_fg=";90m"
# local red_bright_fg=";91m"
# local green_bright_fg=";92m"
# local yellow_bright_fg=";93m"
# local blue_bright_fg=";94m"
# local magenta_bright_fg=";95m"
# local cyan_bright_fg=";96m"
# local white_bright_fg=";97m"

# # Define background colors
# local black_bg=";40m"
# local red_bg=";41m"
# local green_bg=";42m"
# local yellow_bg=";43m"
# local blue_bg=";44m"
# local magenta_bg=";45m"
# local cyan_bg=";46m"
# local white_bg=";47m"
# local black_bright_bg=";100m"
# local red_bright_bg=";101m"
# local green_bright_bg=";102m"
# local yellow_bright_bg=";103m"
# local blue_bright_bg=";104m"
# local magenta_bright_bg=";105m"
# local cyan_bright_bg=";106m"
# local white_bright_bg=";107m"

__makePS1() {
    # Start with a line separator from last output
    PS1="\n"

    # Check if root, use bashism if possible for speed
    # else use id command for POSIX, which is slower
    if ((${EUID:-0} || "$(id -u)")); then
        PS1+="\e[1;32mλ\e[0m "
    else
        PS1+="\e[1;31mπ\e[0m "
    fi
}

# Set the main prompt
PS1="$(__makePS1)"

# Set the continuation prompt
PS2="\e[1;33m...\e[0m "
