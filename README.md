# Linux-Novice-Function-1.0.2
-----------------------------
This repository is used to store descriptions of commands and tools commonly used in the Linux/Save for beginners

-----------------------------

<div align="center">

| OS  | Directory| Based| Content|
| ---------- | -----------| -----------| -----------|
| Manjaro   | [Page](#manjaro)   | Archlinux   | [Go](https://github.com/pro1tocol/Linux-Novice-Function-1.0.2/tree/main/Manjaro)   |
| Blackarch   | [Page](#blackarch)   | Archlinux   | [Go](https://github.com/pro1tocol/Linux-Novice-Function-1.0.2/tree/main/Blackarch)   |
| Ubuntu   | [Page](#ubuntu)   | Debian   | [Go](https://github.com/pro1tocol/Linux-Novice-Function-1.0.2/tree/main/Ubuntu)   |
| Kali   | [Page](#kali)   | Debian   | [Go](https://github.com/pro1tocol/Linux-Novice-Function-1.0.1/tree/main/Kali)   |

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

## `Manjaro`
replace the update source in China

    pacman-mirrors -i -c China -m rank

add and update China Tsinghua sources in the file

    /etc/pacman.conf
    [archlinux]
    Server = https://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch

## `Blackarch`
modifying siglevel can exempt key verification

    /etc/pacman.conf
    SigLevel = Never
    [archlinux]
    Server = https://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch
changing the mainland China update source also requires changes:

    /etc/pacman.d/mirrorlist
    /etc/pacman.d/blackarch-mirrorlist

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

## `Kali`
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

[back ↑ TOP](#linux-novice-function-102)
