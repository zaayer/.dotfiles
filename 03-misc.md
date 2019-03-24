# Various other items to do at some point

## Sound

Packages to install
`yay -S pulseaudio-alsa`

Modprobe
`sudo cp $HOME/.dotfiles/etc/modprobe.d/sound.conf /etc/modprobe.d/`

## Bluetooth

Packages
`yay -S pulseaudio-bluetooth bluez-utils`

## Other graphical stuff

Sublime
`yay -S sublime-text sublime-merge`

Alacritty
`yay -S alacritty alacritty-terminfo`

Fonts
`yay -S gwaterfall`

Browser
`yay -S chromium-vaapi profile-sync-daemon`
`sudo nano /etc/fstab`
    add to bottom - tmpfs /home/{user}/.cache/chromium tmpfs rw,noatime,size=1G,nr_inodes=5k,noexec,nodev,nosuid,uid={username},gid={group},mode=1700 0 0`
`psd`
`nano $HOME/.config/psd/psd.conf`
    - USE_OVERLAYFS="yes"
    - BROWSERS="chromium"
`sudo visudo /etc/sudoers.d/psd`
    - {username} ALL=(ALL) NOPASSWD: /usr/bin/psd-overlay-helper
`systemctl --user enable psd.service --now`

General desktop (work in progress)
`yay -S xorg-xinit scrot awesome`
