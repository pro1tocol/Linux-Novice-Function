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
    127.0.0.1   localhost
    127.0.1.1   xxx.localdomain	xxx
    ::1         localhost xxx ip6-localhost ip6-loopback
    fe00::0     ip6-localnet
    ff00::0     ip6-mcastprefix
    ff02::1     ip6-allnodes
    ff02::2     ip6-allrouters
### Modify static IP address

    vim /etc/network/interfaces
    address 192.168.1.14
    netmask 255.255.255.0
    gateway 192.168.1.1
            hwaddress ether 8E:66:EB:AC:3D:EE
    
### Close rpc port

    sudo apt purge --remove rpcbind
