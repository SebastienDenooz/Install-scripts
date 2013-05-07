#!/bin/sh

ARCH=`uname -p`
SYNC_FOLDER=~/Dropbox/INFORMATIQUE/SYNC
APPLICATION_DIR=~/Programmes

mkdir -p $SYNC_FOLDER
mkdir -p $APPLICATION_DIR

sudo apt-get update
sudo apt-get upgrade

# Git: One to rules them all
sudo apt-get install git ssh

git config --global core.editor geany
git config --global user.name "Sébastien Denooz"
git config --global user.email "sebastien.denooz@lattirail.net"
git config --global diff.tool meld
git config --global core.editor subl

git config --global color.ui true

mkdir -p $APPLICATION_DIR
mkdir -p $SYNC_FOLDER

# SCMBreeze, for easy giting, just in case it works well one day...
# git clone git://github.com/ndbroadbent/scm_breeze.git $APPLICATION_DIR/scm_breeze
# echo '[ -s "$APPLICATION_DIR/scm_breeze/scm_breeze.sh" ] && source "$APPLICATION_DIR/scm_breeze/scm_breeze.sh"' >> ~/.bashrc
# cp $APPLICATION_DIR/scm_breeze/git.scmbrc.example ~/.git.scmbr


# Source list for different good app ;-)

# Google
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
# Install google earth package to provide google repos in apt.
if [ "$ARCH" = "x86_64" ];
then wget http://dl.google.com/dl/earth/client/current/google-earth-stable_current_amd64.deb -O /tmp/google-earth.deb
else wget http://dl.google.com/dl/earth/client/current/google-earth-stable_current_i386.deb -O /tmp/google-earth.deb
fi
sudo dpkg -i /tmp/google-earth.deb

# Clean the install
sudo apt-get -f install

sudo echo "

deb http://repository.spotify.com stable non-free

" >> /etc/apt/source.list
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 94558F59
sudo apt-get update
sudo apt-get -y install spotify-client spotify-client-gnome-support

# Install Medibuntu repos
sudo -E wget --output-document=/etc/apt/sources.list.d/medibuntu.list http://www.medibuntu.org/sources.list.d/$(lsb_release -cs).list && sudo apt-get --quiet update && sudo apt-get --yes --quiet --allow-unauthenticated install medibuntu-keyring && sudo apt-get --quiet update
sudo apt-get install -y app-install-data-medibuntu apport-hooks-medibuntu

wget -q "http://deb.playonlinux.com/public.gpg" -O- | sudo apt-key add -
sudo wget http://deb.playonlinux.com/playonlinux_precise.list -O /etc/apt/sources.list.d/playonlinux.list
sudo apt-get update
sudo apt-get install -y playonlinux

# Dropbox install
if [ "$ARCH" = "x86_64" ];
then cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
else cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86" | tar xzf -
fi

# Don't start dropbox now
# ~/.dropbox-dist/dropboxd

# Install Tomboy
sudo apt-get install tomboy

# Install ubuntu-tweak
sudo add-apt-repository ppa:tualatrix/ppa
sudo apt-get update
sudo apt-get install ubuntu-tweak

# Install FileZilla
ln -s $SYNC_FOLDER/filezilla /home/$USER/.filezilla
sudo apt-get install -y filezilla

# Remove this bad and fat app's !
sudo apt-get remove --purge -y avahi-autoipd avahi-utils libnss-mdns libavahi-client-dev libavahi-common-dev libavahi-core6
sudo apt-get remove --purge -y empathy empathy-common telepathy-salut telepathy-gabble telepathy-haze telepathy-idle telepathy-mission-control-5 python-telepathy indicator-messages
sudo apt-get remove --purge -y speech-dispatcher python-speechd libespeak1
sudo apt-get remove --purge -y gwibber gwibber-service
sudo apt-get remove --purge -y ubuntuone-client ubuntuone-client-gnome python-ubuntuone-storageprotocol python-ubuntuone-client

# some of previous command could sometimes remove gnome-shell
sudo apt-get install -y gnome-shell

# Install proper social tool for gnome
sudo apt-get -y install account-plugin-aim account-plugin-facebook account-plugin-flickr account-plugin-google account-plugin-icons account-plugin-identica account-plugin-jabber account-plugin-salut account-plugin-twitter account-plugin-windows-live account-plugin-yahoo accountsservice account-plugin-foursquare account-plugin-gadugadu account-plugin-groupwise account-plugin-icq account-plugin-irc account-plugin-mxit account-plugin-myspace account-plugin-sametime account-plugin-sina account-plugin-sip account-plugin-sohu account-plugin-tools account-plugin-yahoojp account-plugin-zephyr 

# Remove Ubuntu version of hamster
sudo apt-get remove --purge -y hamster-indicator hamster-applet
killall -9 hamster-service
killall -9 hamster-time-tracker

# Install the good hamster & hamster-shell
sudo apt-get install -y git-core gettext intltool gnome-control-center-dev
cd $APPLICATION_DIR
git clone git://github.com/projecthamster/hamster.git
cd hamster
./waf configure build --prefix=/usr
sudo ./waf install

cd $APPLICATION_DIR
git clone git://github.com/projecthamster/shell-extension.git
mkdir -p ~/.local/share/gnome-shell/extensions/
cd ~/.local/share/gnome-shell/extensions/
ln -s $APPLICATION_DIR/shell-extension hamster@projecthamster.wordpress.com

# Add equalizer for pulseaudio
sudo add-apt-repository ppa:nilarimogard/webupd8
sudo apt-get update
sudo apt-get install -y pulseaudio-equalizer

# DVD Read capacity
sudo apt-get install -y libdvdread4
sudo /usr/share/doc/libdvdread4/install-css.sh

# Other good stuff
sudo apt-get install -y chromium-browser guake eclipse gnome-tweak-tool p7zip sshfs vim vlc ubuntu-restricted-extras p7zip-full unrar cheese inkscape compizconfig-settings-manager firefox chrome thunderbird non-free-codecs

# Install Java
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo mkdir -p /usr/lib/mozilla/plugins #just in case, this will be added to the package in the next version
sudo apt-get install oracle-jdk7-installer

# Install BFGMiner, a Bitcoin miner
sudo apt-get install gcc g++ libpcre++-dev libcurl4-openssl-dev unzip unace libjansson-dev screen make automake
sudo apt-get install libtool libcurl4-gnutls-dev pkg-config yasm
sudo apt-get install ocl-icd-opencl-dev
cd $APPLICATION_DIR
git clone git://github.com/luke-jr/bfgminer.git
cd bfgminer/
./autogen.sh
make clean
./configure --enable-cpumining --enable-scrypt
make
sudo make install
# use it with: ./bfgminer -u LOGIN -p PASSWORD -o http://mint.bitminter.com:8332 -a sse4_64 -C


if [ "$ARCH" = "x86_64" ];
then sudo apt-get install -y w64codecs
else sudo apt-get install -y w32codecs
fi

# Install tracer, if pc is stolen
apt-get install python gnupg net-tools iw traceroute scrot streamer
wget https://github.com/BoboTiG/pombo/raw/master/pombo.py -O /tmp/pombo.py
wget https://raw.github.com/BoboTiG/pombo/master/pombo.conf -O /tmp/pombo.conf
install -v /tmp/pombo.conf /etc
install -v /tmp/pombo.py /usr/local/bin/pombo
chmod 600 -v /etc/pombo.conf
chmod +x -v /usr/local/bin/pombo
if test -f /etc/crontab ; then
	if [ $(grep -c "/usr/local/bin/pombo" /etc/crontab) != 0 ] ; then
		echo "« sed -i '\/usr\/local\/bin\/pombo/d' /etc/crontab »"
		sed -i '\/usr\/local\/bin\/pombo/d' /etc/crontab
	fi
else
	echo "« touch /etc/crontab »"
	touch /etc/crontab
	chmod 644 -v /etc/crontab
fi
echo "« */15 * * * * root /usr/local/bin/pombo >>/etc/crontab »"
echo "*/15 * * * * root /usr/local/bin/pombo" >>/etc/crontab
[ -f /var/local/pombo ] && rm -fv /var/local/pombo
rm /tmp/pombo.conf
rm /tmp/pombo.py
echo "Done."

# Install the sublime text 2 text editor
sudo add-apt-repository ppa:webupd8team/sublime-text-2 
sudo apt-get update
sudo apt-get install sublime-text-2-beta

sudo apt-get install -y deborphan
sudo apt-get remove --purge -y `deborphan`


# Finish the install
sudo apt-get update
sudo apt-get upgrade

echo "Installation finished!"
echo "Please, update your /etc/pombo.conf. Ex: vim /etc/pombo.conf"
echo "Reboot needed."
