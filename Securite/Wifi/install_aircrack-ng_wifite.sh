#!/bin/sh

cd /tmp

mkdir wifi_tools

cd wifi_tools

apt-get install build-essential devscripts dpkg-dev debhelper libtool libssl-dev libsqlite0-dev autoconf pyrit tshark libpcap-dev sqlite3 libsqlite3-dev libpcap0.8-dev

wget http://reaver-wps.googlecode.com/files/reaver-1.4.tar.gz

tar -xzvf reaver-1.4.tar.gz

cd reaver-1.4

cd src

./configure

make

make install

cd ../../

wget http://download.aircrack-ng.org/aircrack-ng-1.1.tar.gz

tar xvzf aircrack-ng-1.1.tar.gz

cd aircrack-ng-1.1

echo "If you are under Ubuntu 12.04 (and perhaps some other distrib's, remove the '-Werror' from the line 'CFLAGS          ?= -g -W -Wall -Werror -O3' in the common.mak file"
echo "And just press [ENTER]"
read correction_ok

make sqlite=true 

make install 

cd ../

wget -O wifite.py http://wifite.googlecode.com/svn/trunk/wifite.py

cp wifite.py /usr/local/bin/wifite.py

chmod +x /usr/local/bin/wifite.py

rm wifi_tools/ -Rf