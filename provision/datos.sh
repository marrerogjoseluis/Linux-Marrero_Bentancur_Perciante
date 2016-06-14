#!/bin/sh
ORIGEN='/vagrant/provision/'

export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get -y install vim mysql-server
mysqladmin -u root password root

useradd operador -d /home/operador -m
echo operador:password | chpasswd

# Crear BD
mysql -u root -p password -e "CREATE DATABASE IF NOT EXISTS WP;"
mysql -u root -ppassword -e "CREATE USER wp@10.0.0.210;"
mysql -u root -ppassword -e "SET PASSWORD FOR wp@10.0.0.210= PASSWORD('pass');"
mysql -u root -p password -e "GRANT ALL PRIVILEGES ON WP.* TO wp@10.0.0.210 IDENTIFIED BY 'pass';"
mysql -u root -p password -e "flush privileges;"
mysql -u root -p password WP < $ORIGEN/WP.sql

#Hosts:
cat  <<EOF>> /etc/hosts
10.0.0.210 server
10.0.0.211 datos
10.0.0.212 control
EOF


#copiamos certificados

chmod 600  ~/.ssh/authorized_keys
cat /vagrant/provision/id_rsa.pub >> ~/.ssh/authorized_keys
#cat /root/.ssh/authorized_keys >> /vagrant/provision/id_rsa.pub


#Escuchar en puerto 4000






