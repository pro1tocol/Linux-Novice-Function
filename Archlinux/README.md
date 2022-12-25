# This article mainly explains the system installation and deployment

----------------------------------------------

#### The installation of the archlinux system does not have a graphical interface, and the installation process is highly customized and can be arranged according to your preferences.
----------------------------------------------

<div align="center">

| Num  | Menu|
| ---------- | -----------|
| NO.1   | [Disk](#write-to-disk)   |
| NO.2   | [Chroot](#change-root)   |
| NO.3   | [Uefi](#uefi-setting)   |
| NO.4   | [Deploy](#deploy)   |

## Boot disk creation
##### `1`.Flash drive( at least 4G storage space )
##### `2`.Download IOS file ( [Download-Page](https://archlinux.org/download/) )
##### `3`.Flash disk software ( [balenaEtcher](https://www.balena.io/etcher/) )
##### `4`.Flashing drive and done

</div>

----------------------------------------------
## Write to disk

!!! Notice: 

1.There is enough free space on the disk

2.Bios set UEFI boot mode

3.Start the burned driver image and enter the `root`

Disable service item

    systemctl status reflector.service
    systemctl stop reflector.service
Check UEFI mode

    ls /sys/firmware/efi/efivars
Check network card installed

    lspci -k | grep Network
#### Connect WIFI network

    systemctl status iwd
    systemctl start iwd

    iwctl
    device list
    station wlan0 scan
    station wlan0 get-networks
    station wlan0 connect wifi-name
    exit
Setting time

    timedatectl set-ntp true
    timedatectl status
Repleace source

    vim /etc/pacman.d/mirrorlist
Show partition status

    lsblk
    fdisk -l
    df -h
    free -h
Start hard disk partition

    cfdisk /dev/sdx
`1`.Create EFI partition (At least 600MB and type "efi system")

`2`.Create SWAP partition (At least memory 60% and type "linux sway")

`3`.Create SYSTEM partition (all remaining space or user/root allocated separately)

Save Settings

    write
    exit
Format and create ext4 subvolume

    mkfs.fat -F32 /dev/[efi partition name]
    mkswap /dev/[swap partition name]
    mkfs.ext4 /dev/[user/root partiton name]
Mount partition

    mount /dev/[root partition name] /mnt
    
    mkdir -p /mnt/boot/efi
    mount /dev/[efi partition name] /mnt/boot/efi
    
    mkdir /mnt/home
    mount /dev/[user partition name] /mnt/home
    
    swapon /dev[swap partition name]
Update key
    
    pacman -S archlinux-keyring && sudo pacman -Syy
Installed system

    pacstrap /mnt base base-devel bash-completion linux linux-firmware
    pacstrap /mnt dhcpcd iwd vim sudo zsh zsh-completions
    pacstrap /mnt intel-ucode/amd-ucode
Generating and Querying Parameters

    genfstab -U /mnt > /mnt/etc/fstab
    cat /mnt/etc/fstab
----------------------------------------------
## Change root

Switch system

    arch-chroot /mnt
Setting hostname and timezone

    vim /etc/hostname
    
    vim /etc/hosts
    127.0.0.1   localhost
    ::1         localhost
    127.0.1.1   xxx.localdomain	xxx
    
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
    hwclock --systohc
Setting language

    pacman -S locales
    dpkg-reconfigure locales

    vim /etc/locale.gen
    en_US.UTF-8 UTF-8
    zh_CN.UTF-8 UTF-8
    
    locale-gen
    echo 'LANG=en_US.UTF-8'  > /etc/locale.conf
Setting root password

    passwd root
----------------------------------------------
## UEFI Setting

Generate startup items

    pacman -S grub efibootmgr [os-prober]
    grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=ARCH
    
    vim /etc/default/grub
    ="loglevel=5 nowatchdog"
    
    grub-mkconfig -o /boot/grub/grub.cfg
Finish installation

    exit
    umount -R /mnt
    reboot
----------------------------------------------
## Deploy

Start dhcp and wlan connect

    systemctl enable --now dhcpcd
    systemctl start iwd
Network [connection method](#connect-wifi-network)

Open 32-bit support library and Archlinux Chinese community repository

    vim /etc/pacman.conf
    [multilib]
    Inclu...
    
    [archlinuxcn]
    Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch
Modify source [here](https://github.com/pro1tocol/Linux-Novice-Function#archlinux) and update system

    pacman-key --init
    pacman-key --populate archlinux
    pacman -Syy && pacman -Syu
    pacman -S archlinux-keyring archlinuxcn-keyring
    pacman -S yay
Installation tool

    pacman -S neofetch htop iftop
Default editor

    vim ~/.bash_profile
    export EDITOR='vim'
Create common user and grant permission

    useradd -m -G wheel -s /bin/bash alarm
    passwd alarm
    
    EDITOR=vim visudo
    %wheel ALL=(ALL: ALL) ALL
### ` optional 1 ` KDE Plasma

    pacman -S plasma-meta konsole dolphin yakuake
    pacman -S qt5-virtualkeyboard onboard kded-rotation-git
    systemctl enable sddm
    systemctl start sddm
    
    vim /etc/sddm.conf.d/virtualkbd.conf
    [General]
    InputMethod=qtvirtualkeyboard
    reboot
    
Environment settings

    sudo systemctl disable iwd
    sudo systemctl stop iwd
    sudo systemctl enable --now NetworkManager
    
    sudo pacman -S ntfs-3g adobe-source-han-serif-cn-fonts wqy-zenhei noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra
    sudo pacman -S ark packagekit-qt5 packagekit appstream-qt appstream gwenview mpv 
    sudo pacman -S fcitx5-im fcitx5-chinese-addons
    
    sudo vim /etc/environment
    INPUT_METHOD=fcitx5
    GTK_IM_MODULE=fcitx5
    QT_IM_MODULE=fcitx5
    XMODIFIERS=\@im=fcitx5
    SDL_IM_MODULE=fcitx
    
    sudo pacman -S archlinuxcn-keyring
    sudo pacman -S yay
    
    sudo vim ~/.bashrc
    export EDITOR='vim'
    
    sudo systemctl enable --now bluetooth
### ` optional 2 ` Gnome
    
Environment settings

    pacman -S networkmanager modemmanager bluez bluez-utils pulseaudio-bluetooth
    pacman -S git wget ntfs-3g usbutils
    systemctl enable NetworkManager bluetooth
    systemctl enable ModemManager
    
    pacman -S noto-fonts noto-fonts-cjk ibus ibus-pinyin mpv
    pacman -S adobe-source-han-serif-cn-fonts wqy-zenhei noto-fonts-emoji noto-fonts-extra
    echo 'LANG=zh_CN.UTF-8'  > /etc/locale.conf
    
    pacman -S gnome
    systemctl enable gdm

    reboot
Themes

[Orchis](https://github.com/vinceliuice/Orchis-theme) | [Yaru-Colors](https://github.com/Jannomag/Yaru-Colors) | [Sweet](https://github.com/EliverLara/Sweet) | [Gdm-tools](https://github.com/realmazharhussain/gdm-tools) | [Ccat](https://github.com/owenthereal/ccat)
----------------------------------------------
## Optional tools

    epiphany-browser
    gnome-user-docs
    yelp
    totem
    gnome-maps
    gnome-music
    gnome-text-editor
    gnome-weather
    gnome-contacts
    gnome-photos
    
    gnome-tweaks
    gnome-shell-extensions
    gnome-shell-extension-dash-to-dock
    juno-theme-git
    
    guake
    
[back to Archlinux](#this-article-mainly-explains-the-system-installation-and-deployment)
