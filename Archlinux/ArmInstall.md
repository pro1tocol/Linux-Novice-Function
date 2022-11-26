# This article mainly explains how to install the Archlinux on ARM device
-----------------------------------------

<div align="center">

The equipment information is as follows:

OnePlus 6T

OxygenOS Android 9.0 (Pie)

Qualcomm SDM845 Snapdragon 845

Adreno 630

128GB 8GB RAM

A6010, A6013

thanks：@snnbyyds

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
#### Copy and deploy esp directory files ( download folder [arch]() and [BOOT]() )

    adb push */arch /sdcard
    adb push */BOOT /sdcard
    adb shell
    
    mkdir esp
    mount /dev/block/by-name/esp esp
    mkdir esp/EFI
    cp -r /sdcard/arch/ /esp/EFI
    cp -r /sdcard/BOOT/ /esp/EFI
