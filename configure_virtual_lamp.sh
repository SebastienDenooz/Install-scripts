#!/bin/sh

debian_source="
###### Debian Main Repos
deb http://ftp.be.debian.org/debian/ squeeze main contrib non-free 
deb-src http://ftp.be.debian.org/debian/ squeeze main contrib non-free 

###### Debian Update Repos
deb http://security.debian.org/ squeeze/updates main contrib non-free 
deb http://ftp.be.debian.org/debian/ squeeze-proposed-updates main contrib non-free 
deb-src http://security.debian.org/ squeeze/updates main contrib non-free 
deb-src http://ftp.be.debian.org/debian/ squeeze-proposed-updates main contrib non-free 
deb http://download.virtualbox.org/virtualbox/debian squeeze contrib non-free
"
mv /etc/apt/sources.list /etc/apt/sources.list.orig

echo debian_source > /etc/apt/sources.list

wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O- | sudo apt-key add -

apt-get update

apt-get upgrade

apt-get install -y htop vim mysql-server php-apc php5-xdebug php5-intl php5-sqlite git htop

apt-get install -y phpmyadmin

a2enmod rewrite

/etc/init.d/apache2 restart

sed -i.orig -e "s/;date.timezone =/date.timezone = Europe\/Brussels/g" /etc/php5/cli/php.ini /etc/php5/apache2/php.ini
sed -i.orig -e "s/short_open_tag = On/short_open_tag = Off/g" /etc/php5/cli/php.ini /etc/php5/apache2/php.ini
