#!/bin/bash
ORIGEN='/var/cache/apt/archives/restore/'
export DEBIAN_FRONTEND=noninteractive

# Disponibiliza index de repos
test -d /var/lib/apt/lists && rm -R /var/lib/apt/lists
ln -s /var/cache/apt/archives/lists/ /var/lib/apt/lists

# Actualizacion e instalacion
apt-get update
apt-get -y install vim apache2 mysql-server php5 php5-mysql php5-gd mediawiki dnsutils

# Configura mysql y DB
mysqladmin -u root password password
mysql -u root -ppassword -e "CREATE DATABASE IF NOT EXISTS my_wiki;"
mysql -u root -ppassword -e "GRANT ALL PRIVILEGES ON my_wiki.* TO 'wikiuser'@'localhost' IDENTIFIED BY 'toto23';"
mysql -u root -ppassword -e "flush privileges;"
mysql -u root -ppassword my_wiki < $ORIGEN/my_wiki.sql

# Archivos base "a fuego"
cp $ORIGEN/LocalSettings.php /etc/mediawiki/
cp $ORIGEN/mediawiki.conf /etc/mediawiki/apache.conf
cp $ORIGEN/ucu1.jpg /usr/share/mediawiki/skins/common/images/
cp $ORIGEN/bashrc /etc/skel/.bashrc
cp $ORIGEN/bashrc /home/vagrant/.bashrc
cp $ORIGEN/bashrc-root /root/.bashrc
cp $ORIGEN/vimrc /etc/vim/vimrc
a2enconf mediawiki
systemctl restart apache2

# Ruta por defecto y DNS contra router
ip route del default
ip route add default via 10.0.0.222
echo "nameserver 10.0.0.222" > /etc/resolv.conf

# examle.com
mkdir /var/www/example.com
cp $ORIGEN/example.com.conf.apache /etc/apache2/sites-available/example.com.conf
cp $ORIGEN/example.com.index.php /var/www/example.com/index.php
a2ensite example.com
apache2ctl graceful

# LXC
cp $ORIGEN/lamp.lxc.interfaces /root








