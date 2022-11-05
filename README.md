# Linux-Novice-Function-1.0.1
-----------------------------
This repository is used to store descriptions of commands and tools commonly used in the Linux environment/Save for beginners

-----------------------------

# Integrate update sources for various OS

# 1)Manjaro
-------------based on Archlinux
:pacman-mirrors -i -c China -m rank:
replace the update source in China
  $ /etc/pacman.conf                                 //Meaning: source storage directory file
[archlinux]
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch
/*Meaning: add and update China Tsinghua sources in the file*/

# 2)Blackarch
-------------based on Archlinux
/etc/pacman.conf                                                                                 //Meaning: source storage directory file
SigLevel = Never                                                                                 //Meaning: modifying siglevel can exempt key verification
[archlinux]
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch                           //Meaning: add and update China Tsinghua sources in the file
/etc/pacman.d/mirrorlist                                                                         //Meaning: change the update source in mainland China
/etc/pacman.d/blackarch-mirrorlist                                                               //Meaning: change the update source in mainland China

# 3)Ubuntu--based on Debian
/etc/apt/sources.list                                                                            //Meaning: source storage directory file
deb http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse    //Meaning: add and update China Aliyun sources in the file

# 4)Kalilinux--based on Debian
/etc/apt/sources.list                                                                            //Meaning: source storage directory file
deb http://mirrors.aliyun.com/kali kali-rolling main non-free contrib
deb-src http://mirrors.aliyun.com/kali kali-rolling main non-free contrib                        //Meaning: add and update China Aliyun sources in the file

deb http://mirrors.ustc.edu.cn/debian/ buster main contrib non-free
deb http://mirrors.ustc.edu.cn/debian/ buster-updates main contrib non-free
deb http://mirrors.ustc.edu.cn/debian/ buster-backports main contrib non-free
deb http://mirrors.ustc.edu.cn/debian-security buster/updates main contrib non-free              //Meaning: add and update China USTC sources in the file
