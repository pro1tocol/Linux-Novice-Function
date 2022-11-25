# Linux-Novice-Function-1.3.5
-----------------------------
This repository is used to store descriptions of commands and tools commonly used in the Linux

Save for beginners

-----------------------------

<div align="center">

| OS  | Dir| Based| Link|
| ---------- | -----------| -----------| -----------|
| Archcraft   | [Page](#archcraft)   | Archlinux   | [Go](https://github.com/pro1tocol/Linux-Novice-Function/tree/main/Archcraft)   |
| Manjaro   | [Page](#manjaro)   | Archlinux   | [Go](https://github.com/pro1tocol/Linux-Novice-Function/tree/main/Manjaro)   |
| Blackarch   | [Page](#blackarch)   | Archlinux   | [Go](https://github.com/pro1tocol/Linux-Novice-Function/tree/main/Blackarch)   |
| Ubuntu   | [Page](#ubuntu)   | Debian   | [Go](https://github.com/pro1tocol/Linux-Novice-Function/tree/main/Ubuntu)   |
| Kalilinux   | [Page](#kali-linux)   | Debian   | [Go](https://github.com/pro1tocol/Linux-Novice-Function/tree/main/Kali)   |
| Debian10   | [Page](#debian-10)   | FreeBSD   | [Go](https://github.com/pro1tocol/Linux-Novice-Function/tree/main/Debian%2010)   |
| CentOS 7   | [Page](#centos-7)   | RHEL   | [Go](https://github.com/pro1tocol/Linux-Novice-Function/tree/main/CentOS%207)   |
| Archlinux   | [Building]()   | x86-64 GNU/Linux   | [Go](https://github.com/pro1tocol/Linux-Novice-Function/tree/main/Archlinux)   |

</div>

## Compiler tools
Recommended vi/vim tool

    vim [file name] = open a file
     i  = edit file
    Esc = toggle
    :q! = force quit, the file will be lost if not saved
    :w! = force save
    :wq = save and exit
    :q  = exit

## Update sources for various OS

## `Archcraft`
replace the update source in China

    reflector --verbose -c China --latest 12 --sort rate --threads 100 --save /etc/pacman.d/mirrorlist
Sinicization

    pacman -S adobe-source-han-sans-cn-fonts

add and update China Tsinghua sources in the file

    /etc/pacman.conf
    [archlinux]
    Server = https://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch
    
    # [chaotic-aur]
    # Include = /etc/pacman.d/chaotic-mirrorlist
The `chaotic-aur` source has speed and copyright issues, it is recommended to cancel

[Archcraft-Details](https://github.com/pro1tocol/Linux-Novice-Function/tree/main/Archcraft)

[back ↑ TOP](#linux-novice-function-135)

## `Manjaro`
replace the update source in China

    pacman-mirrors -i -c China -m rank

add and update China Tsinghua sources in the file

    /etc/pacman.conf
    [archlinux]
    Server = https://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch

[Manjaro-Details](https://github.com/pro1tocol/Linux-Novice-Function/tree/main/Manjaro)

[back ↑ TOP](#linux-novice-function-135)

## `Blackarch`
modifying siglevel can exempt key verification

    /etc/pacman.conf
    SigLevel = Never
    [archlinux]
    Server = https://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch
changing the mainland China update source also requires changes:

    /etc/pacman.d/mirrorlist
    /etc/pacman.d/blackarch-mirrorlist

[Blackarch-Details](https://github.com/pro1tocol/Linux-Novice-Function/tree/main/Blackarch)

[back ↑ TOP](#linux-novice-function-135)

## `Ubuntu`
source storage directory file

    /etc/apt/sources.list
add and update China Aliyun sources in the file

    deb http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse
    deb-src http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse
    deb http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse
    deb-src http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse
    deb http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse
    deb-src http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse
    deb http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse
    deb-src http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse
    deb http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse
    deb-src http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse

[Ubuntu-Details](https://github.com/pro1tocol/Linux-Novice-Function/tree/main/Ubuntu)

[back ↑ TOP](#linux-novice-function-135)

## `Kali-Linux`
source storage directory file

    /etc/apt/sources.list
add and update China Aliyun sources in the file

    deb http://mirrors.aliyun.com/kali kali-rolling main non-free contrib
    deb-src http://mirrors.aliyun.com/kali kali-rolling main non-free contrib
add and update China USTC sources in the file

    deb http://mirrors.ustc.edu.cn/debian/ buster main contrib non-free
    deb http://mirrors.ustc.edu.cn/debian/ buster-updates main contrib non-free
    deb http://mirrors.ustc.edu.cn/debian/ buster-backports main contrib non-free
    deb http://mirrors.ustc.edu.cn/debian-security buster/updates main contrib non-free

[Kali-Details](https://github.com/pro1tocol/Linux-Novice-Function/tree/main/Kali)

[back ↑ TOP](#linux-novice-function-135)

## `Debian 10`
source storage directory file

    /etc/apt/sources.list
add and update China Tsinghua sources in the file

    deb https://mirrors.tuna.tsinghua.edu.cn/debian/ buster main contrib non-free
    deb https://mirrors.tuna.tsinghua.edu.cn/debian/ buster-updates main contrib non-free
    deb https://mirrors.tuna.tsinghua.edu.cn/debian/ buster-backports main contrib non-free
    deb https://mirrors.tuna.tsinghua.edu.cn/debian-security buster/updates main contrib non-free
adding the following sources increases the update time

    deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ buster main contrib non-free
    deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ buster-updates main contrib non-free
    deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ buster-backports main contrib non-free
    deb-src https://mirrors.tuna.tsinghua.edu.cn/debian-security buster/updates main contrib non-free

[Debian 10-Details](https://github.com/pro1tocol/Linux-Novice-Function/tree/main/Debian%2010)

[back ↑ TOP](#linux-novice-function-135)

## `CentOS 7`
One-click replacement China Tsinghua sources

    sudo sed -e 's|^mirrorlist=|#mirrorlist=|g' \
             -e 's|^#baseurl=http://mirror.centos.org|baseurl=https://mirrors.tuna.tsinghua.edu.cn|g' \
             -i.bak \
             /etc/yum.repos.d/CentOS-*.repo

Update package cache

    yum makecache
    
[CentOS 7-Details](https://github.com/pro1tocol/Linux-Novice-Function/tree/main/CentOS%207)

[back ↑ TOP](#linux-novice-function-135)

## `Archlinux`
Replacement China Tsinghua sources(/etc/pacman.d/mirrorlist)

x86_64

    Server = https://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch
arm64

    Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxarm/$arch/$repo
Third party sources(/etc/pacman.conf)

    [archlinuxcn]
    Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch

Update package cache

    pacman -Syy && pacman -Syu
    
[Archlinux-Details](https://github.com/pro1tocol/Linux-Novice-Function/tree/main/Archlinux)

[back ↑ TOP](#linux-novice-function-135)
