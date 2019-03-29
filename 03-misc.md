# Various other items to do at some point

## Sound

Packages to install (unless using jack)
`yay -S pulseaudio-alsa` <!-- Unless using jack -->

Modprobe
`sudo cp $HOME/.dotfiles/etc/modprobe.d/sound.conf /etc/modprobe.d/`

## Bluetooth

Packages (no pulseaudio-bluetooth if using jack)
`yay -S pulseaudio-bluetooth bluez-utils`

## Other audio

Packages
`yay -S jack2-dbus realtime-privileges`

`useradd -G realtime {name}`

## Other graphical stuff

Sublime
`yay -S sublime-text sublime-merge`

Alacritty
`yay -S alacritty alacritty-terminfo`

Tressorit
- Visit website to get latest linux install script.

MuPDF
`yay -S mupdf-gl`

Fonts
`yay -S gwaterfall`

Browser
`yay -S chromium-vaapi profile-sync-daemon`
`sudo nano /etc/fstab`
    add to bottom - tmpfs /home/{user}/.cache/chromium tmpfs rw,noatime,size=1G,nr_inodes=5k,noexec,nodev,nosuid,uid={username},gid={group},mode=1700 0 0
`psd`
`nano $HOME/.config/psd/psd.conf`
    - USE_OVERLAYFS="yes"
    - BROWSERS="chromium"
`sudo visudo /etc/sudoers.d/psd`
    - {username} ALL=(ALL) NOPASSWD: /usr/bin/psd-overlay-helper
`systemctl --user enable psd.service --now`

General desktop (work in progress)
`yay -S xorg-xinit scrot awesome`

## Packages to potentially add later

`yay -S mpv docker`
