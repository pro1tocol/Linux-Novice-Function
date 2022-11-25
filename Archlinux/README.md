# This article mainly explains the system installation and deployment

----------------------------------------------

#### The installation of the archlinux system does not have a graphical interface, and the installation process is highly customized and can be arranged according to your preferences.
----------------------------------------------

<div align="center">

| Num  | Menu|
| ---------- | -----------|
| NO.1   | [Disk](#write-to-disk)   |
| NO.2   | [Chroot]()   |
| NO.3   | [Uefi]()   |
| NO.4   | [Deploy]()   |

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
Connect WIFI network

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
    

