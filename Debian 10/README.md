### Time-setting

    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
### User-setting

    usermod -aG sudo qoant
### Fonts-install

    xfonts-intl-chinese
    xfonts-wqy
    fonts-noto-cjk
### GUI-install

    gnome-core
    ibus ibus-pinyin
### Language setting

    vim /etc/locale.gen
    en_US.UTF-8 UTF-8
    zh_CN.UTF-8 UTF-8
    locale-gen
    echo 'LANG=zh_CN.UTF-8'  > /etc/locale.conf
### Network-driver

    firmware-atheros
    firmware-iwlwifi
### Graphics-driver

    
    
