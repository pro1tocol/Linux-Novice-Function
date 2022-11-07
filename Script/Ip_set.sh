echo "Test from dot1q.."
ip addr flush dev eth0
ip addr add 192.168.1.48/24 dev eth0
ip route delete default
ip route add default via 192.168.1.1 dev eth0

echo "---------------------dns setting--"
echo "nameserver 192.168.1.1" > /etc/resolv.conf
echo "It's done!"
