# Linux-Novice-Function-1.0.1
-----------------------------
This repository is used to store descriptions of commands and tools commonly used in the Linux environment/Save for beginners

-----------------------------

<div align="center">

| 表头1  | 表头2|
| ---------- | -----------|
| 表格单元   | 表格单元   |
| 表格单元   | 表格单元   |

</div>

## compiler tools
Recommended vi/vim tool

    vim [file name] = open a file
    :i  = edit file
    :q! = force quit, the file will be lost if it is not saved
    :w! = force save
    :wq = save and exit
    :q  = exit

## Integrate update sources for various OS

## 1) `Manjaro`_based on Archlinux
    pacman-mirrors -i -c China -m rank               //replace the update source in China

add and update China Tsinghua sources in the file

    /etc/pacman.conf                                 //source storage directory file
    [archlinux]
    Server = https://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch

## 2) `Blackarch`_based on Archlinux
    /etc/pacman.conf
    SigLevel = Never                                 //modifying siglevel can exempt key verification
    [archlinux]
    Server = https://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch
changing the mainland China update source also requires changes:

    /etc/pacman.d/mirrorlist
    /etc/pacman.d/blackarch-mirrorlist

## 3) `Ubuntu`_based on Debian
    /etc/apt/sources.list                            //source storage directory file
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

## 4) `Kali`_based on Debian
    /etc/apt/sources.list                            //source storage directory file
add and update China Aliyun sources in the file

    deb http://mirrors.aliyun.com/kali kali-rolling main non-free contrib
    deb-src http://mirrors.aliyun.com/kali kali-rolling main non-free contrib
add and update China USTC sources in the file

    deb http://mirrors.ustc.edu.cn/debian/ buster main contrib non-free
    deb http://mirrors.ustc.edu.cn/debian/ buster-updates main contrib non-free
    deb http://mirrors.ustc.edu.cn/debian/ buster-backports main contrib non-free
    deb http://mirrors.ustc.edu.cn/debian-security buster/updates main contrib non-free

[back ↑ TOP](./README.md)
