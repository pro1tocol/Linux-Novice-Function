# This file is used to modify the Armbian system of the TV box

View details:[amlogic-s9xxx-armbian](https://github.com/ophub/amlogic-s9xxx-armbian)

-------------------------------------

### After the U disk boots

    armbian-install
    304
    1
### Modify hostname and local loopback mappings

    vim /etc/hostname
    vim /etc/hosts
### modify time zone

    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
### Configure ssh login

    vim /etc/ssh/sshd_config
    
    Port 22
    ListenAddress 0.0.0.0
    ListenAddress ::
    
    PermitRootLogin yes
    PubkeyAuthentication yes
    PasswordAuthentication yes
### Modify static IP address

    vim /etc/network/interfaces
### Close rpc port

    sudo apt purge --remove rpcbind
### Language setting

    vim /etc/locale.gen
    en_US.UTF-8 UTF-8
    zh_CN.UTF-8 UTF-8
    locale-gen
    
    echo 'LANG=en_US.UTF-8'  > /etc/locale.conf
### Fonts-install

    xfonts-intl-chinese
    xfonts-wqy
    fonts-noto-cjk
