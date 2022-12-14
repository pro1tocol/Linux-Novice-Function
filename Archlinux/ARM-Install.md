<div align="center">

# How to install Archlinux on ARM device
-----------------------------------------
    
[No.1Partition](#step-no1)
    
[No.2Construction](#step-no2)
    
[No.3Infrastructure](#step-no3)
    
[No.4Flash](#step-no4)

-----------------------------------------
    
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
Storage partition configuration ( You need to `unlock` the mobile device and flash [`twrp 3.2.3-1.img`](https://twrp.me/oneplus/oneplus6t.html) )

Into the recovery ( download [parted](https://github.com/pro1tocol/Linux-Novice-Function/blob/main/Archlinux/parted) )

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
#### Copy and deploy esp directory files ( download folder [arch](https://github.com/pro1tocol/Linux-Novice-Function/tree/main/Archlinux/arch) and [BOOT](https://github.com/pro1tocol/Linux-Novice-Function/tree/main/Archlinux/BOOT), recommended download tool: [DownGit](https://minhaskamal.github.io/DownGit/#/home) )

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
    sudo apt install libc6-dev libidn11-dev rsync bc liblz4-tool gcc-aarch64-linux-gnu dpkg-dev dpkg git wget qemu-user-static
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

    wget https://github.com/pro1tocol/Linux-Novice-Function/raw/main/Archlinux/tfa98xx.cnt
    cp -r tfa98xx.cnt ../arch/root/
Return to the chroot environment to continue configuration

    sudo chroot arch
    cd ~
    dpkg -i firmware-atheros_20210818-1_all.deb
    dpkg -i firmware-oneplus6_0.0.2_all.deb
    dpkg -i firmware-qcom-soc_20210818-1_all.deb
    mv ~/tfa98xx.cnt /usr/lib/firmware/
    ldconfig
Find mkinitcpio.conf

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
    wget https://github.com/pro1tocol/Linux-Novice-Function/raw/main/Archlinux/sdm845-oneplus-fajita.dtb
    wget https://github.com/pro1tocol/Linux-Novice-Function/raw/main/Archlinux/OnePlus6T.dtb
    cp -r sdm845-oneplus-fajita.dtb ../arch/boot
    cp -r OnePlus6T.dtb ../arch/boot
-----------------------------------------
### Step No.3 
Basic system configuration ( return chroot )

Timezone setting

    sudo chroot arch
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

    su alarm && cd ~/
    git clone https://hub.fastgit.org/andersson/pd-mapper.git
    git clone https://hub.fastgit.org/andersson/tqftpserv.git
    cd pd-mapper && make && sudo make install && cd ..
    cd tqftpserv && make && sudo make install && cd ..
    sudo systemctl enable tqftpserv pd-mapper
Add danctnix source

    vim /etc/pacman.conf
    [danctnix]
    Server = https://p64.arikawa-hi.me/$repo/$arch/
    
    [archlinuxcn]
    Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch
    
    cd ~/
    wget https://p64.arikawa-hi.me/danctnix/aarch64/danctnix-keyring-2-1-any.pkg.tar.xz
    pacman -U danctnix-keyring-2-1-any.pkg.tar.xz
    
    pacman-key --init
    pacman-key --populate danctnix
    pacman -Syy
    pacman -S archlinuxcn-keyring
    pacman -Syu
Install the USB network adapter

    pacman -Sy danctnix-usb-tethering
    systemctl enable usb-tethering.service
Install the fonts pack
    
    pacman -S noto-fonts noto-fonts-cjk ibus ibus-pinyin mpv
    pacman -S adobe-source-han-serif-cn-fonts wqy-zenhei noto-fonts-emoji noto-fonts-extra
Deploy yay

    pacman -S yay
Install the `gnome` desktop environment

    pacman -S gnome
    systemctl enable gdm
Install such as alsa and call audio ( [alsa](https://github.com/pro1tocol/Linux-Novice-Function/blob/main/Archlinux/alsa-ucm-oneplus-0.5.9-0-any.pkg.tar.zst) and [q6voiced](https://github.com/pro1tocol/Linux-Novice-Function/blob/main/Archlinux/q6voiced-0_git20210408-0-aarch64.pkg.tar.zst) )

    pacman -U alsa-ucm-oneplus-0.5.9-0-any.pkg.tar.zst
    pacman -U q6voiced-0_git20210408-0-aarch64.pkg.tar.zst
    systemctl enable q6voiced
    echo 'snd-soc-tfa98xx' > /etc/modules-load.d/snd-soc-tfa98xx.conf
Remake Modemanager ( download [PKGBUILD](https://github.com/pro1tocol/Linux-Novice-Function/blob/main/Archlinux/PKGBUILD) )

!! It is best to execute after the system is officially started

    su alarm
    mkdir ~/modemmanager
    cd ~/modemmanager
    wget https://raw.githubusercontent.com/pro1tocol/Linux-Novice-Function/main/Archlinux/PKGBUILD
    makepkg -rsi
    exit
GRUB settings （ download folder [efi](https://github.com/pro1tocol/Linux-Novice-Function/tree/main/Archlinux/boot/efi) and [grub](https://github.com/pro1tocol/Linux-Novice-Function/tree/main/Archlinux/boot/grub), recommended download tool: [DownGit](https://minhaskamal.github.io/DownGit/#/home))

    cd /boot
    download here
    cd /boot/grub
    wget https://raw.githubusercontent.com/pro1tocol/Linux-Novice-Function/main/Archlinux/grub.cfg
Replace all `UUIDs` in the grub.cfg file

Packaging system

    pacman -Scc
    su alarm
    cat /dev/null > ~/.bash_history && history -c && exit
    cat /dev/null > ~/.bash_history && history -c
    exit
    
    sudo umount ../arch/run
    sudo umount ../arch/sys
    sudo umount ../arch/proc
    sudo umount ../arch/dev/pts
    sudo umount ../arch/dev
To solve the umount failure, you can restart Ubuntu and remount
    
    sudo mount archlinux.img arch
Encapsulation

    cd ../arch
    sudo tar -czvf ../Oneplus6t-Archlinux.tar.gz *
-----------------------------------------
### Step No.4 
Enter twrp to write to the device

    adb push ../Oneplus6t-Archlinux.tar.gz /sdcard
    adb shell
    cd ~
    mkdir temp
    mount /dev/block/by-name/arch ~/temp
    
    cd ~/temp
    tar -xpvf /sdcard/Oneplus6t-Archlinux.tar.gz
Enter bootloader switch partition

    fastboot devices
    fastboot set_active b
Write UEFI recovery ( dowload [edk2-msm](https://github.com/edk2-porting/edk2-msm/releases) )

    fastboot flash boot boot-fajita.img
    fastboot reboot

# Done and enjoy ! ~!

## [`GotoTOP`](#How-to-install-archlinux-on-arm-device)
