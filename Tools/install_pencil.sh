#!/bin/sh

ARCH=`uname -p`

if [ "$ARCH" = "x86_64" ];
then 
	wget http://evoluspencil.googlecode.com/files/evoluspencil_2.0.2_amd64.deb
	sudo dpkg -i evoluspencil_2.0.2_amd64.deb
	rm evoluspencil_2.0.2_amd64.deb
else 
	wget http://evoluspencil.googlecode.com/files/evoluspencil_2.0.2-1_i386.deb
	sudo dpkg -i evoluspencil_2.0.2-1_i386.deb
	rm evoluspencil_2.0.2-1_i386.deb
fi

sudo apt-get -f -y install