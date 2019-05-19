# Setup guide after installation

## Intial activities

Update the system
```bash
pacman -Syu
```

Curl the install files
```bash
PKG01="https://raw.githubusercontent.com/zaayer/.dotfiles/master/bootstrap/pkg01.txt"
PKG02="https://raw.githubusercontent.com/zaayer/.dotfiles/master/bootstrap/pkg02.txt"
PKG03="https://raw.githubusercontent.com/zaayer/.dotfiles/master/bootstrap/pkg03.txt"
curl -O $PKG01
curl -O $PKG02
curl -O $PKG03
```

Install useful packages
```bash
pacman -S --needed - < pkg01.txt
rm pkg01.txt
```

Setup firewall, need to know your local network domain range... mine is 10.0.1.0
```bash
systemctl enable ufw
systemctl start ufw
ufw default deny
ufw allow from 10.0.1.0/24
ufw limit ssh
ufw enable
```

Use dash as the default /bin/sh instead of bash
```bash
ln -sfT dash /usr/bin/sh
```

Enable trim timer
```bash
systemctl enable fstrim.timer --now
```

Create user and set passwd (optionally may need to add to audio group as well, if using jack)
```bash
useradd -m -G wheel,lp -s /usr/bin/bash {name}
passwd {name}
```

Let user have sudo
```bash
visudo
```
> uncomment %wheel ALL=(ALL) ALL

Switch to user
```bash
su - {name}
```

Verify sudo is working
```bash
sudo pacman -Syu
```

Move pkg files
```bash
sudo mv /root/pkg0{12}.txt $HOME/
```

Copy over config files
```bash
cd $HOME
git clone https://github.com/zaayer/.dotfiles.git
cd .dotfiles
stow {items to stow}
```

Reboot and then login using user to make sure everything is OK
```bash
reboot
```

## Setup AUR and add other packages

Install yay
```bash
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay
```

Install sublime text/merge GPG key
```bash
curl -O https://download.sublimetext.com/sublimehq-pub.gpg && sudo pacman-key --add sublimehq-pub.gpg && sudo pacman-key --lsign-key 8A8F901A && rm sublimehq-pub.gpg
```

Update pacman.conf for sublime text/merge - this is the dev version, but you can use stable
```bash
echo -e "\n[sublime-text]\nServer = https://download.sublimetext.com/arch/dev/x86_64" | sudo tee -a /etc/pacman.conf
```

Install second set of packages
```bash
yay -S --needed - < pkg02.txt
```

## Setup graphics

Updates to mkinitcpio
```bash
sudo nano /etc/mkinitcpio.conf
```
> Add to MODULES - (amdgpu intel_agp i915)

Updates to boot entries
```bash
sudo nano /boot/loader/entries/arch.conf
```
> Add to options - amdgpu.dc=1

## Setup network

## Option 1: NetworkManager

Install packages
```bash
yay -S networkmanager dhclient iwd dnsmasq
```

Various systemctl changes
```bash
sudo systemctl enable NetworkManager --now
sudo systemctl stop dhcpcd
sudo systemctl disable dhcpcd
sudo systemctl stop wpa_supplicant
sudo systemctl disable wpa_supplicant
```

Remove unneeded packages
```bash
yay -Rs netctl dhcpcd
```

Copy over conf files
```bash
sudo cp $HOME/.dotfiles/etc/NetworkManager/conf.d/* /etc/NetworkManager/conf.d/
```

## Option 2: systemd-networkd

Install packages
```bash
yay -S iwd
```

Various systemctl changes
```bash
sudo systemctl stop dhcpcd
sudo systemctl disable dhcpcd
sudo systemctl stop wpa_supplicant
sudo systemctl disable wpa_supplicant
```

Remove unneeded packages
```bash
yay -Rs netctl dhcpcd wpa_supplicant
```

Copy over conf files
```bash
sudo mkdir -p /etc/systemd/resolved.conf.d
sudo cp $HOME/.dotfiles/etc/systemd/resolved.conf.d/* /etc/systemd/resolved.conf.d/
sudo cp $HOME/.dotfiles/etc/systemd/network/* /etc/systemd/network/
```

Start services
```bash
sudo systemctl enable systemd-networkd --now
sudo systemctl enable systemd-resolved --now
sudo systemctl enable iwd --now
```

Link the resolv.conf for systemd-resolved
```bash
sudo ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
```

Setup wireless
```bash
iwctl
station {device} connect {SSID}
exit
```

## Disable other watchdogs

Copy over file for nmi
```bash
sudo cp $HOME/.dotfiles/etc/sysctl.d/disable_watchdog.conf /etc/sysctl.d/
```

Blacklist mod
```bash
sudo cp $HOME/.dotfiles/etc/modprobe.d/blacklist.conf /etc/modprobe.d/
```

## Move journal to volatile file storage

```bash
sudo mkdir -p /etc/systemd/journald.conf.d
sudo cp $HOME/.dotfiles/etc/systemd/journald.conf.d/log.conf /etc/systemd/journald.conf.d/
```

## Enable automatic clean-up of paccache

```bash
sudo systemctl enable paccache.timer
```

## Setup nvim

Install dein.sh
```bash
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh * installer.sh && \
sh ./installer.sh ~/.local/share/dein && \
rm installer.sh
```

Setup nvim dein etc
```bash
nvim
```
> :call dein#install()
> :q

```bash
nvim
```
> :BlackUpgrade
> :UpdateRemotePlugins
> :q

## Rebuild and reboot

Remake initcpio
```bash
sudo mkinitcpio -p linux
```

Reboot the system
```bash
reboot
```
