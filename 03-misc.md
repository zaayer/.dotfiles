# Various other items to do at some point

## Sound

**Option 1** Packages to install (Pulse Audio)
```bash
yay -S pulseaudio-alsa speex
```

**Option 2** Packages to install (jack) *work in progress*
```bash
yay -S jack2-dbus realtime-privileges
useradd -G realtime {name}
```

Modprobe
```bash
sudo cp $HOME/.dotfiles/etc/modprobe.d/sound.conf /etc/modprobe.d/
```

## Bluetooth

Packages (no pulseaudio-bluetooth if using jack)
```bash
yay -S pulseaudio-bluetooth
```

## Other graphical stuff

Sublime
```bash
yay -S sublime-text sublime-merge
```

Alacritty
```bash
yay -S alacritty alacritty-terminfo
```

Fonts
```bash
yay -S gwaterfall
```

Browser
```bash
yay -S chromium profile-sync-daemon
sudo nano /etc/fstab
```
Add to the bottom of the fstab
> tmpfs /home/{user}/.cache/chromium tmpfs rw,noatime,size=1G,nr_inodes=5k,noexec,nodev,nosuid,uid={username},gid={group},mode=1700 0 0

```bash
psd
nano $HOME/.config/psd/psd.conf
```
> USE_OVERLAYFS="yes"
> BROWSERS="chromium"

```bash
sudo visudo /etc/sudoers.d/psd
```
> {username} ALL=(ALL) NOPASSWD: /usr/bin/psd-overlay-helper

```bash
systemctl --user enable psd.service --now
```

General desktop (work in progress)
```bash
yay -S eog evince file-roller gdm gnome-backgrounds gnome-calculator gnome-clocks gnome-characters gnome-control-center gnome-font-viewer gnome-keyring gnome-menus gnome-screenshot gnome-session gnome-settings-daemon gnome-shell mutter nautilus sushi tracker xdg-user-dirs-gtk gnome-logs gnome-tweaks alacarte gnome-shell-extensions gnome-shell-extension-dash-to-dock gnome-shell-extension-impatience-git gnome-shell-extension-no-topleft-hot-corner gnome-shell-extension-panel-osd dconf-editor
```

More updated TUI tools
```bash
yay -S mtr pydf multitail
```

Plymouth
```bash
yay -S gdm-plymouth
```
> Add sd-plymouth after systemd in the hooks section of /etc/mkinticpio.conf

## Packages to potentially add later

```bash
yay -S mpv docker docker-compose docker-machine virtualbox virtualbox-host-modules-arch youtube-dl pass pass-otp docker-credential-pass
sudo usermod -Ag docker {name}
pass init {email}
pass git remote add origin git@github.com:{name}/{repo}.git
pass git pull
```

## Backup

```bash
yay -S restic
```

## Other programming tools

```bash
yay -S python-pipenv pypy3
```
