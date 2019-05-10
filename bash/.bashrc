#!/usr/bin/env bash

# If not running interactively, do nothing
[ -z "$PS1" ] && return

##################################
####    FROM SENSIBLE.BASH    ####
##################################

## GENERAL OPTIONS ##

# Prevent file overwrite on stdout redirection
# Use `>|` to force redirection to an existing file
set -o noclobber

# Update window size after every command
shopt -s checkwinsize

# Automatically trim long paths in the prompt (requires Bash 4.x)
PROMPT_DIRTRIM=2

# Enable history expansion with space
# E.g. typing !!<space> will replace the !! with your last command
bind Space:magic-space

# Turn on recursive globbing (enables ** to recurse all directories)
shopt -s globstar 2> /dev/null

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

## SMARTER TAB-COMPLETION (Readline bindings) ##

# Perform file completion in a case insensitive fashion
bind "set completion-ignore-case on"

# Treat hyphens and underscores as equivalent
bind "set completion-map-case on"

# Display matches for ambiguous patterns at first tab press
bind "set show-all-if-ambiguous on"

# Immediately add a trailing slash when autocompleting symlinks to directories
bind "set mark-symlinked-directories on"

## SANE HISTORY DEFAULTS ##

# Append to the history file, don't overwrite it
shopt -s histappend

# Save multi-line commands as one command
shopt -s cmdhist

# Record each line as it gets issued
PROMPT_COMMAND='history -a'

# Huge history. Doesn't appear to slow things down, so why not?
HISTSIZE=500000
HISTFILESIZE=100000

# Avoid duplicate entries
HISTCONTROL="erasedups:ignoreboth"

# Don't record some commands
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"

# Use standard ISO 8601 timestamp
# %F equivalent to %Y-%m-%d
# %T equivalent to %H:%M:%S (24-hours format)
HISTTIMEFORMAT='%F %T '

# Enable incremental history search with up/down arrows (also Readline goodness)
# Learn more about this here: http://codeinthehole.com/writing/the-most-important-command-line-tip-incremental-history-searching-with-inputrc/
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
# Ex: CDPATH=".:~:~/projects" will look for targets in the current working directory, in home and in the ~/projects folder
CDPATH="."

# This allows you to bookmark your favorite places across the file system
# Define a variable containing a path and you will be able to cd into it regardless of the directory you're in
shopt -s cdable_vars

##################################
####         ENV VARS         ####
##################################

# Preferred editors
export EDITOR=nvim
export VISUAL=subl
export PAGER=less

# XDG directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# Fixes for XDG structure for certain programs
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export LESSHISTFILE="$XDG_DATA_HOME/less/history"
export GOPATH="$XDG_DATA_HOME/go"
export GOCACHE="$XDG_CACHE_HOME/go"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
# export PIP_CONFIG_FILE="$XDG_CONFIG_HOME/pip/pip.conf"
# export PYLINTHOME="$XDG_CACHE_HOME/pylint"
# export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
# export NPM_CONFIG_PREFIX="$XDG_DATA_HOME/npm"
# export NPM_CONFIG_CACHE="$XDG_CACHE_HOME/npm"
# export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"
# export GEM_HOME="$XDG_DATA_HOME/gem"
# export GEM_SPEC_CACHE="$XDG_CACHE_HOME/gem"
# export GEMRC="$XDG_CONFIG_HOME/gem/gemrc"
# export RBENV_ROOT="$XDG_DATA_HOME/rbenv"
# export STACK_ROOT="$XDG_DATA_HOME/stack"
# export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
# export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
# export _JAVA_OPTIONS="Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java"
