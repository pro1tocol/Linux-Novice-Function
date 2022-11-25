# This article mainly explains the system installation and deployment

----------------------------------------------

#### The installation of the archlinux system does not have a graphical interface, and the installation process is highly customized and can be arranged according to your preferences.
----------------------------------------------

<div align="center">

| Num  | Menu|
| ---------- | -----------|
| NO.1   | [Disk]()   |
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
Connect WIFI network

    systemctl status iwd
    systemctl start iwd

    iwctl                           # into the interact
    device list                     # show wlan devices
    station wlan0 scan              # scan
    station wlan0 get-networks      # show can be connect wifi list
    station wlan0 connect wifi-name # and connect
    exit


