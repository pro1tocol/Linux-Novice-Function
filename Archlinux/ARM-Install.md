# This article mainly explains how to install Archlinux on ARM device
-----------------------------------------

<div align="center">

The equipment information is as follows:

OnePlus 6T

OxygenOS Android 9.0 (Pie)

Qualcomm SDM845 Snapdragon 845

Adreno 630

128GB 8GB RAM

A6010, A6013

thanks：[@snnbyyds](https://forum.renegade-project.org/t/install-archlinux-on-your-oneplus-6t-oneplus-6-or-pocophone-f1/2530) and his team

Dual system coexistence Android 64G and Archlinux 64G

</div>

-----------------------------------------
### Step No.1 
Storage partition configuration ( You need to `unlock` the mobile device and flash [`twrp.img`](https://twrp.me/oneplus/oneplus6t.html) )

Into the recovery ( download [parted]() )

    adb push */parted /sdcard
    adb shell
    cp /sdcard/parted /sbin/ && chmod 755 /sbin/parted
    umount /data && umount /sdcard
    
    parted /dev/block/sda
    p
    resizepart 17
    mkpart esp fat32 61GB 62GB
    mkpart arch ext4 62GB 125GB
    set 18 esp on
    p
    q
Reboot recovery

    adb shell
    
    mkfs.fat -F32 -s1 /dev/block/by-name/esp
    mke2fs -t ext4 /dev/block/by-name/userdata
    mke2fs -t ext4 /dev/block/by-name/arch
Record the `UUID` of the arch partition
#### Copy and deploy esp directory files ( download folder [arch](https://github.com/pro1tocol/Linux-Novice-Function/tree/main/Archlinux/arch) and [BOOT](https://github.com/pro1tocol/Linux-Novice-Function/tree/main/Archlinux/BOOT) )

    adb push */arch /sdcard
    adb push */BOOT /sdcard
    adb shell
    
    mkdir esp
    mount /dev/block/by-name/esp esp
    mkdir esp/EFI
    cp -r /sdcard/arch/ /esp/EFI
    cp -r /sdcard/BOOT/ /esp/EFI
    exit
-----------------------------------------
### Step No.2 
System installation and deployment ( you need to do it in Ubuntu 22.04 LTS )

Install related dependencies

    sudo apt install build-essential openssl pkg-config libssl-dev libncurses5-dev pkg-config minizip libelf-dev flex bison vim sudo
    sudo apt install libc6-dev libidn11-dev rsync bc liblz4-tool install gcc-aarch64-linux-gnu dpkg-dev dpkg git wget qemu-user-static
Find the kernel version you need, check [here](https://gitlab.com/sdm845-mainline/linux)

It is recommended to use the relatively stable version 5.19

    git clone https://gitlab.com/sdm845-mainline/linux.git -b sdm845/5.19-release
At this point a `linux` folder will be generated and entered

    cd linux
    make ARCH=arm64 defconfig sdm845.config
    make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j$(nproc)
    cd ..
Download Archlinux-ARM system files, check [here](http://fl.us.mirror.archlinuxarm.org/os/ArchLinuxARM-aarch64-latest.tar.gz)

Make rootfs and enter chroot

    dd if=/dev/zero of=archlinux.img bs=1G count=6
    mkfs.ext4 archlinux.img
    mkdir arch
    sudo mount archlinux.img arch
    cd arch
    sudo tar -xpvf ../ArchLinuxARM-aarch64-latest.tar.gz
    
    cd ..
    sudo mount --bind /dev arch/dev
    sudo mount -t devpts devpts arch/dev/pts -o gid=5,mode=620
    sudo mount -t proc proc arch/proc
    sudo mount -t sysfs sysfs arch/sys
    sudo mount -t tmpfs tmpfs arch/run
    
    sudo rm -rf arch/etc/resolv.conf && sudo cp /etc/resolv.conf arch/etc/
    
    sudo chroot arch
Initialization

    pacman-key --init
    pacman-key --populate archlinuxarm
    pacman -Syy && pacman -Syu
    pacman -S git wget vim sudo dpkg
Uninstall old kernel and firmware (done and exit chroot)

    pacman -Q | grep -i linux
    pacman -R linux-aarch64 linux-firmware linux-firmware-whence
    exit
Install new kernel and firmware (dowload [file](https://stor.classfun.cn:4443/s/0Nsa) and decompress)

    cd /linux
    sudo make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-  INSTALL_MOD_PATH=../arch modules_install
    sudo make ARCH=arm64 INSTALL_PATH=../arch/boot install
    
    sudo su
    cp -r firmware-atheros_20210818-1_all.deb ../arch/root/
    cp -r firmware-oneplus6_0.0.2_all.deb ../arch/root/
    cp -r firmware-qcom-soc_20210818-1_all.deb ../arch/root/
download sound [file](https://github.com/pro1tocol/Linux-Novice-Function/blob/main/Archlinux/tfa98xx.cnt)

    cp -r tfa98xx.cnt ../arch/root/
Return to the chroot environment to continue configuration

    sudo chroot arch
    cd ~
    dpkg -i firmware-atheros_20210818-1_all.deb.deb
    dpkg -i firmware-oneplus6_0.0.2_all.deb.deb
    dpkg -i firmware-qcom-soc_20210818-1_all.deb.deb
    mv ~/tfa98xx.cnt /usr/lib/firmware/
    ldconfig
Find and  mkinitcpio.conf

    vim /etc/mkinitcpio.conf
    
    # BINARIES
    # This setting includes any additional binaries a given user may
    # wish into the CPIO image.  This is run last, so it may be used to
    # override the actual binaries included by a given hook
    # BINARIES are dependency parsed, so you may safely ignore libraries
    BINARIES=()
Revise
    
    BINARIES=(/usr/lib/firmware/qcom/sdm845/oneplus6/a630_zap.mbn /usr/lib/firmware/qcom/sdm845/oneplus6/ipa_fws.mbn)
Get new kernel version

    ls /usr/lib/modules
    mkinitcpio --generate /boot/initrd.img-5.19.16-sdm845 --kernel 5.19.16-sdm845
Download and copy ( [sdm845-oneplus-fajita.dtb](https://github.com/pro1tocol/Linux-Novice-Function/blob/main/Archlinux/sdm845-oneplus-fajita.dtb) and [OnePlus6T.dtb](https://github.com/pro1tocol/Linux-Novice-Function/blob/main/Archlinux/OnePlus6T.dtb) )

    exit
    cp -r sdm845-oneplus-fajita.dtb ../arch/boot
    cp -r OnePlus6T.dtb ../arch/boot
-----------------------------------------
### Step No.3 
Basic system configuration ( return chroot )

Timezone setting

    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
    vim /etc/locale.gen
    en_US.UTF-8 UTF-8
    zh_CN.UTF-8 UTF-8
    locale-gen
Setting hostname ( must be consistent, otherwise an error will be reported )

    echo 'OnePlus6T' > /etc/hostname
Set up a non-root user

    passwd alarm
    usermod -aG wheel alarm
    
    EDITOR=vim visudo
    %wheel ALL=(ALL:ALL) ALL
Install necessary packages

    pacman -S base base-devel dhcpcd iwd
    pacman -S grub efibootmgr
    
    pacman -S networkmanager modemmanager
    pacman -S bluez bluez-utils pulseaudio-bluetooth
    pacman -S qrtr rmtfs
    systemctl enable NetworkManager bluetooth qrtr-ns rmtfs 
    systemctl enable ModemManager
    
    pacman -S ntfs-3g usbutils
Install pd-mapper and tqftpserv

    git clone https://hub.fastgit.org/andersson/pd-mapper.git
    git clone https://hub.fastgit.org/andersson/tqftpserv.git
    
    cd pd-mapper && make && make install && cd ..
    cd tqftpserv && make && make install && cd ..
    
    rm -rf tqftpserv pd-mapper
    sudo systemctl enable tqftpserv pd-mapper
Add danctnix source

    vim /etc/pacman.conf
    [danctnix]
    Server = https://p64.arikawa-hi.me/$repo/$arch/
    
    cd ~
    wget https://p64.arikawa-hi.me/danctnix/aarch64/danctnix-keyring-2-1-any.pkg.tar.xz
    pacman -U danctnix-keyring-2-1-any.pkg.tar.xz
    
    pacman-key --init
    pacman-key --populate danctnix
    
    pacman -Syy
Install the USB network adapter

    pacman -Sy danctnix-usb-tethering
    systemctl enable usb-tethering.service
Install the fonts pack
    
    pacman -S noto-fonts noto-fonts-cjk ibus ibus-pinyin gedit mpv
    pacman -S adobe-source-han-serif-cn-fonts wqy-zenhei noto-fonts-emoji noto-fonts-extra
Deploy yay

    su alarm
    cd ~
    git clone https://aur.archlinux.org/yay-bin.git
    cd yay-bin && makepkg -si
    exit
Install the `gnome` desktop environment

    pacman -S gnome
    systemctl enable gdm

