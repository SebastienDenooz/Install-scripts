#!/bin/sh

ARCH=`uname -p`

if [ "$ARCH" = "x86_64" ];
then 
	wget http://www.xmind.net/xmind/downloads/xmind-linux-3.3.0.201208102038_amd64.deb
	sudo dpkg -i xmind-linux-3.3.0.201208102038_amd64.deb
	rm xmind-linux-3.3.0.201208102038_amd64.deb
else 
	wget http://www.xmind.net/xmind/downloads/xmind-linux-3.3.0.201208102038_i386.deb
	sudo dpkg -i xmind-linux-3.3.0.201208102038_i386.deb
	rm xmind-linux-3.3.0.201208102038_i386.deb
fi

sudo apt-get -f -y install
