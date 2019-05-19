#!/usr/bin/env bash

# Only needed if not using stow

. bootstrap/funcs.sh

info "Prompting for sudo password..."
if sudo -v; then
    # Keep alive and update existing `sudo` timestamp until complete
    while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
        success "Sudo credentials updated."
else
    error "Failed to obtain sudo credentials."
fi

# Location of the repo
scriptDir=$(dirname -- "$(readlink -f -- "$BASH_SOURCE")")
dotHomeDir="$scriptDir/home/user"

# Locations where files will be symlinked
configDir="$HOME/.config"
localBinDir="$HOME/bin"

# Create the directories if they don't exist
if mkdir -p $configDir $localBinDir; then
    success "Created .config and bin directories in home."
else
    error "Failed to create directories in home."
    exit 1
fi

# link config
info "Linking files and directories to $HOME/.config..."
for file in $dotHomeDir/.config/*; do
    source=$(basename $file)
    symlink $file $configDir/$source
done
unset file

# link bin scripts
info "Linking files and directories to $HOME/bin..."
for file in $dotHomeDir/bin/*; do
    source=$(basename $file)
    symlink $file $localBinDir/$source
done
unset file
