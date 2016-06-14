#!/bin/sh
ORIGEN='/vagrant/provision/'

export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get -y install vim mysql-server
#mysqladmin -u root password root

useradd operador -d /home/operador -m
echo operador:password | chpasswd

# Crear BD
#mysqladmin -u root password password
#mysql -u root -e "CREATE DATABASE IF NOT EXISTS WP;"
#mysql -u root -ppassword -e "CREATE USER wp@10.0.0.210;"
#mysql -u root -ppassword -e "SET PASSWORD FOR wp@10.0.0.210= PASSWORD('pass');"
#mysql -u root -p password -e "GRANT ALL PRIVILEGES ON WP.* TO wp@10.0.0.210 IDENTIFIED BY 'pass';"
#mysql -u root -p password -e "flush privileges;"


Generar el DUMP

#mysql -u root -p password WP < $ORIGEN/WP.sql
#mysqldump -u root -p demodb > dbbackup.sql

#Hosts:
cat  <<EOF>> /etc/hosts
10.0.0.210 server
10.0.0.211 datos
10.0.0.212 control
EOF


#copiamos certificados
#como accedemos como root ponemos las credenciales en /root/.ssh/
mkdir -p /root/.ssh/

#damos permisos a la carpeta

chmod 600  /root/.ssh/authorized_keys
cat /vagrant/provision/id_rsa.pub >> /root/.ssh/authorized_keys
#cat /root/.ssh/authorized_keys >> /vagrant/provision/id_rsa.pub


#Escuchar en puerto 4000






