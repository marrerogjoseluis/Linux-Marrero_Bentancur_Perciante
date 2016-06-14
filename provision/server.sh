#!/bin/bash
ORIGEN='/vagrant/provision/'
export DEBIAN_FRONTEND=noninteractive

# Actualizacion e instalacion
apt-get update
apt-get -y install vim apache2 php5 php5-mysql php5-gd dnsutils

useradd operador -d /home/operador -m
echo operador:password | chpasswd





#Hosts:
cat  <<EOF>> /etc/hosts
10.0.0.210 server
10.0.0.211 datos
10.0.0.212 control
EOF


#copiamos certificados
chmod 600  ~/.ssh/authorized_keys
cat /vagrant/provision/id_rsa.pub >> ~/.ssh/authorized_keys


#Escuchar en puerto 4000





