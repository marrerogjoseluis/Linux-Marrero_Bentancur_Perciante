#!/bin/sh
ORIGEN='/vagrant/provision/'

export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get -y install vim 

#Password?, darle permisos como root, dar acceso como respaldo@control

#agregar usuario a grupo admin o root

#Creamos usuarios 
useradd respaldo -d /home/respaldo -m

useradd operador -d /home/operador -m
echo operador:password | chpasswd

#Creamos los certificados
#ssh-keygen -t rsa -N "" -f /root/.ssh/

#copiamos certificados
#cat /vagrant/provision/id_rsa.pub >> /root/.ssh/authorized_keys


#Hosts:
cat  <<EOF>> /etc/hosts
10.0.0.210 server
10.0.0.211 datos
10.0.0.212 control
EOF


