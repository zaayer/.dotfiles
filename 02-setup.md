# Setup guide after installation

## Intial activities

Update the system
`pacman -Syu`

Install useful packages
`pacman -S --needed - < pkg01.txt`

Setup firewall
`systemctl enable ufw`
`systemctl start ufw`
`ufw default deny`
`ufw allow from 192.168.8.0/24`
`ufw limit ssh`
`ufw enable`

Use dash as the default /bin/sh instead of bash
`ln -sfT dash /usr/bin/sh`

Enable trim timer
`systemctl enable fstrim.timer --now`

Create user and set passwd (optionally may need to add to audio group as well)
`useradd -m -G wheel,lp -s /usr/bin/fish {name}`
`passwd {name}`

Let user have sudo
`visudo`
    uncomment %wheel ALL=(ALL) ALL

Switch to user
`su - zaayer`

Verify sudo is working
`sudo pacman -Syu`

Copy over config files
`cp -r .dotfiles/ $HOME`
`cp -r $HOME/.dotfiles/home/user/.config/ $HOME`

Reboot and then login using user to make sure everything is OK
`reboot`

## Setup AUR and add other packages

Install yay
`git clone https://aur.archlinux.org/yay.git`
`cd yay`
`makepkg -si`
`cd ..`
`rm -rf yay`

Copy over pacman.conf
`sudo cp $HOME/.dotfiles/etc/pacman.conf /etc/pacman.conf`

Install second set of packages
`yay -S --needed - < pkg02.txt`

## Setup graphics

Updates to mkinitcpio
`sudo nano /etc/mkinitcpio.conf`
    Add to MODULES - (amdgpu intel_agp i915)

Updates to boot entries
`sudo nano /boot/loader/entries/arch.conf`
    Add to options - amdgpu.dc=1

## Setup NetworkManager

Install packages
`yay -S networkmanager dhclient iwd dnsmasq`

Various systemctl changes
`sudo systemctl enable NetworkManager --now`
`sudo systemctl stop dhcpcd`
`sudo systemctl disable dhcpcd`
`sudo systemctl stop wpa_supplicant`
`sudo systemctl disable wpa_supplicant`
`sudo systemctl enable iwd --now`

Remove unneeded packages
`yay -Rs netctl dhcpcd`

Copy over conf files
`sudo cp $HOME/.dotfiles/etc/NetworkManager/conf.d/* /etc/NetworkManager/conf.d/`

## Disable other watchdogs

Copy over file for nmi
`sudo cp $HOME/.dotfiles/etc/sysctl.d/disable_watchdog.conf /etc/sysctl.d/`

Blacklist mod
`sudo cp $HOME/.dotfiles/etc/modprobe.d/blacklist.conf /etc/modprobe.d/`

## Move journal to volatile file storage

`sudo mkdir -p /etc/systemd/journald.conf.d`
`sudo cp $HOME/.dotfiles/etc/systemd/journald.conf.d/log.conf /etc/systemd/journald.conf.d/`

## Setup nvim

Install dein.sh
`curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh && \
sh ./installer.sh ~/.local/share/dein && \
rm installer.sh`

Setup nvim dein etc
`nvim`
`:call dein#install()`
`:q`
`nvim`
`:BlackUpgrade`
`:UpdateRemotePlugins`
`:q`

## Rebuild and reboot

Remake initcpio
`sudo mkinitcpio -p linux`

Reboot the system
`reboot`
