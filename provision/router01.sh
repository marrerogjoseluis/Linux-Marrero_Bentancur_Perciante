#!/bin/sh
ORIGEN='/vagrant/provision/'

export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get -y install vim 

# Tunel para SSH
if ! grep -q "GatewayPorts yes" /etc/ssh/ssh_config 
    then echo "GatewayPorts yes" >> /etc/ssh/ssh_config
fi

# Router 
echo 1 > /proc/sys/net/ipv4/ip_forward
iptables -t nat -F
iptables -t filter -F
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -o eth1 -j MASQUERADE
iptables -A FORWARD -i eth0 -o eth1 -j ACCEPT
iptables -A FORWARD -i eth1 -o eth0 -j ACCEPT
iptables -t nat -A PREROUTING -p tcp -i eth0 --dport 8080 -j DNAT --to-destination 10.0.0.210:80
iptables -t nat -A PREROUTING -p tcp -i eth0 --dport 8443 -j DNAT --to-destination 10.0.0.210:443





