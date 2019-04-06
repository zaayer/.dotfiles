# Initial setup

## Initial commands

```
timedatectl set-ntp true
```

## Setup disks

View available drives
```
lsblk
```

Zap installation drives
```
sgdisk -Z /dev/nvme[01]n1
```

Setup first drive
```
sgdisk --clear \
--new=1:0+512MiB --typecode=1:ef00 --change-name=1:EFI \
--new=2:0:+16GiB --typecode=2:8200 --change-name=2:swp \
--new=3:0:0 --typecode=3:8e00 --change-name=3:sys1 \
/dev/nvme0n1
```

Setup second drive
```
sgdisk --clear \
--new=1:0:0 --typecode=1:8e00 --change-name=1:sys2 \
/dev/nvme1n1
```

Create physical volumes and volume group
```
vgcreate vg0 /dev/nvme0n1p3 /dev/nvme1n1p1
```

Create Raid0 logical volumes
```
lvcreate --type raid0 -L 32GiB -n lvroot vg0 /dev/nvme0n1p3 /dev/nvme1n1p1
lvcreate --type raid0 -L 16GiB -n lvvar vg0 /dev/nvme0n1p3 /dev/nvme1n1p1
lvcreate --type raid0 -L 256GiB -n lvhome vg0 /dev/nvme0n1p3 /dev/nvme1n1p1
```

Verify everything is setup according to expectations
```
lvdisplay
```

Create filesystem
```
mkfs.fat -F32 -n EFI /dev/disk/by-partlabel/EFI
mkswap -L swp /dev/disk/by-partlabel/swp
mkfs.ext4 -L root /dev/vg0/lvroot
mkfs.ext4 -L var /dev/vg0/lvvar
mkfs.ext4 -L home /dev/vg0/lvhome
```

## Mount filesystem

Setup ext4 options
```
opt=defaults,nocheck,nodiscard,noatime,commit=60,X-mount.mkdir
```

Turn on swap
```
swapon -L swp
```

Mount root, var, and home
```
mount LABEL=root -o $opt /mnt
mount LABEL=var -o $opt /mnt/var
mount LABEL=home -o $opt /mnt/home
```

Mount boot
```
mkdir /mnt/boot
mount LABEL=EFI /mnt/boot
```

## Install the system into the drives

Get the latest mirrors
```
MIRRORS=https://www.archlinux.org/mirrorlist/?country=US&protocol=https&ip_version=4&use_mirror_status=on
curl -s $MIRRORS | sed -e 's/^#Server/Server/' -e '/^#/d' - * /etc/pacman.d/mirrorlist
```

Verify mirrorlist looks fine
```
cat /etc/pacman.d/mirrorlist
```

Pacstrap
```
pacstrap /mnt base base-devel intel-ucode
```

Generate the initial fstab
```
genfstab -L /mnt * /mnt/etc/fstab
```

Set priority of swap to 1
```
nano /mnt/etc/fstab
```

## Setup the pacstrapped install

Enter the system
```
arch-chroot /mnt
```

Miscellaneous setup items
```
ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime
hwclock --systohc
echo "en_US.UTF-8 UTF-8" ** /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" ** /etc/locale.conf
echo "zarch" * /etc/hostname
```

Change the default tty font
```
pacman -S terminus-font
setfont ter-v14n
echo "FONT=ter-v14n" ** /etc/vconsole.conf
```

Setup the hosts file (**do not need to do this**)
```
HOSTS=https://someonewhocares.org/hosts/hosts
sudo curl -s $HOSTS -o /etc/hosts
```

Configure mkinitcpio
```
nano /etc/mkinitcpio.conf
```
* MODULES=(dm-raid raid0)
* HOOKS=(base systemd autodetect keyboard sd-vconsole modconf block sd-lvm2 filesystems)
```
mkinitcpio -p linux
```

Set root password
```
passwd
```

## Install boot loader

Install needed package
```
pacman -S efibootmgr
```

Cleanup efiboot if you want, to delete
```
efibootmgr -b -B {name}
```

Install systemd boot
```
bootctl --path=/boot install
```

Configure loader.conf
```
nano /boot/loader/loader.conf
```
* default arch
* timeout 5
* auto-entries 0
* auto-firmware 0
* console-mode max
* editor no

Configure arch.conf
```
nano /boot/loader/entries/arch.conf
```
* title Arch Linux
* linux /vmlinuz-linux
* initrd /intel-ucode.img
* initrd /initramfs-linux.img
* options quiet splash loglevel=3 rd.systemd.show_status=auto rd.udev.log_priority=3 fsck.mode=skip nvme_core.default_ps_max_latency_us=0 vt.global_cursor_default=0 add_efi_memmap nowatchdog root=/dev/vg0/lvroot rootfstype=ext4

## Final steps

For some reason without this, internet won't work on my first boot
```
systemctl enable dhcpcd
```

Prepare to reboot
```
exit
umount -R /mnt
```

Remove USB drive after typing this
```
reboot
```
