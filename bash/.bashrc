#!/usr/bin/env bash

# If not running interactively, do nothing
[ -z "$PS1" ] && return

##################################
####    from sensible.bash    ####
##################################

## GENERAL OPTIONS ##

# Prevent file overwrite on stdout redirection
# Use `>|` to force redirection to an existing file
set -o noclobber

# Update window size after every command
shopt -s checkwinsize

# Automatically trim long paths in the prompt (requires Bash 4.x)
PROMPT_DIRTRIM=2

# Enable history expansion w/ space (!!<space> will replace !! with last cmd)
bind Space:magic-space

# Turn on recursive globbing (enables ** to recurse all directories)
shopt -s globstar 2> /dev/null

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

## SMARTER TAB-COMPLETION (Readline bindings) ##

# Perform file completion in a case insensitive fashion
bind 'set completion-ignore-case on'

# Treat hyphens and underscores as equivalent
bind 'set completion-map-case on'

# Display matches for ambiguous patterns at first tab press
bind 'set show-all-if-ambiguous on'

# Immediately add a trailing slash when autocompleting symlinks to directories
bind 'set mark-symlinked-directories on'

## SANE HISTORY DEFAULTS ##

# Append to the history file, don't overwrite it
shopt -s histappend

# Save multi-line commands as one command
shopt -s cmdhist

# Record each line as it gets issued
PROMPT_COMMAND='history -a'

# Unlimited history
HISTSIZE=-1
HISTFILESIZE=-1

# Avoid duplicate entries, ignoredups handled by first two
# patterns in HISTIGNORE
HISTCONTROL="erasedups"

# Don't record some commands
HISTIGNORE="&:[ ]*:exit:ls:la:ll:l:cd:bg:fg:history:clear:pass*:gopass*:top:htop:gotop:youtube-dl*:kitty*"

# Use standard ISO 8601 timestamp
# %F equivalent to %Y-%m-%d
# %T equivalent to %H:%M:%S (24-hours format)
HISTTIMEFORMAT=$(echo -e "\e[1;32m%F\e[1;34m | \e[1;32m%T\e[1;34m |\e[0m ")

# Enable incremental history search with up/down arrows
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\e[C": forward-char'
bind '"\e[D": backward-char'

## BETTER DIRECTORY NAVIGATION ##

# Prepend cd to directory names automatically
shopt -s autocd 2> /dev/null
# Correct spelling errors during tab-completion
shopt -s dirspell 2> /dev/null
# Correct spelling errors in arguments supplied to cd
shopt -s cdspell 2> /dev/null

# This defines where cd looks for targets
# Add the directories you want to have fast access to, separated by colon
# CDPATH="."

# Define a variable containing a path and you will be able to cd into it
# regardless of the directory you're in
shopt -s cdable_vars

##################################
####   dylanaraps/dotfiles    ####
##################################

bind 'TAB: menu-complete'
bind 'set page-completions off'
bind 'set menu-complete-display-prefix on'
bind 'set completion-query-items 0'

##################################
####         env vars         ####
##################################

# Preferred editors
export EDITOR=nvim
export VISUAL=subl
export PAGER=less

# Preferred browser
export BROWSER=chromium

# XDG directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# Store bash history elsewhere
export HISTFILE="$XDG_DATA_HOME/bash/eternal_history"

# Options for fzf
if [ -f /usr/share/fzf/key-bindings.bash ]; then
    . /usr/share/fzf/key-bindings.bash
fi

export FZF_DEFAULT_OPTS='--height 60% --reverse --border'
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d'

# Options for less
export LESSHISTFILE=-
export LESS='-F -g -i -M -R -S -w -X -z-4'

if [ -x /usr/bin/pygmentize ]; then
    export LESSCOLORIZER=pygmentize
fi

if [ -x /usr/bin/lesspipe.sh ]; then
    export LESSOPEN="| /usr/bin/lesspipe.sh %s"
    export LESS_ADVANCED_PREPROCESSOR=1
fi

# Options for pyenv
export PYENV_ROOT="$XDG_DATA_HOME/pyenv"
export PYENV_SHELL=bash
if command -v pyenv 1>/dev/null 2>&1; then
    command pyenv rehash 2>/dev/null
fi

# Location of VSCode
export CODE_HOME="$HOME/.local/bin/vscode"

# Tab complete sudo commands
complete -cf sudo

# Source kitty tab-completion
if command -v kitty 1>/dev/null 2>&1; then
    source <(kitty + complete setup bash)
fi

# Fixes for XDG structure for certain programs
if [ -f ~/.config/bash/xdgfix.sh ]; then
    . ~/.config/bash/xdgfix.sh
fi

# Source api keys
if [ -f ~/.local/share/apikeys/api.sh ]; then
    . ~/.local/share/apikeys/api.sh
fi

##################################
####    aliases/functions     ####
##################################

if [ -f ~/.config/bash/aliases.sh ]; then
    . ~/.config/bash/aliases.sh
fi

if [ -f ~/.config/bash/functions.sh ]; then
    . ~/.config/bash/functions.sh
fi

##################################
####      update path         ####
##################################

[[ -d $CARGO_HOME/bin ]] && PATH="$CARGO_HOME/bin:${PATH}"
[[ -d $GOPATH/bin ]] && PATH="$GOPATH/bin:${PATH}"
[[ -d $HOME/.local/bin ]] && PATH="$HOME/.local/bin:${PATH}"
[[ -d $PYENV_ROOT/shims ]] && PATH="$PYENV_ROOT/shims:${PATH}"
[[ -d $CODE_HOME ]] && PATH="$CODE_HOME:${PATH}"

##################################
####        set prompt        ####
##################################

if [ -f ~/.config/bash/prompt.sh ]; then
    . ~/.config/bash/prompt.sh
else
    PS1="➜ "
fi

##################################
####    run bash greeting     ####
##################################

if [ -f ~/.config/bash/greeting.sh ]; then
    . ~/.config/bash/greeting.sh
fi
