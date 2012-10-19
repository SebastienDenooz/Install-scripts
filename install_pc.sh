#!/bin/sh

ARCH=`uname -p`
SYNC_FOLDER=~/Sync
APPLICATION_DIR=~/Programmes

sudo apt-get update
sudo apt-get upgrade

# Git: One to rules them all
sudo apt-get install git ssh

mkdir -p $APPLICATION_DIR
mkdir -p $SYNC_FOLDER

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

# Install xpad
ln -s $SYNC_FOLDER/xpad /home/$USER/.config/xpad
sudo apt-get install -y xpad 

# Install FileZilla
ln -s $SYNC_FOLDER/filezilla /home/$USER/.filezilla
sudo apt-get install -y filezilla

# Remove this bad and fat app's !
sudo apt-get remove --purge -y avahi-autoipd avahi-utils libnss-mdns libavahi-client-dev libavahi-common-dev libavahi-core6
sudo apt-get remove --purge -y empathy empathy-common telepathy-salut telepathy-gabble telepathy-haze telepathy-idle telepathy-mission-control-5 python-telepathy indicator-messages
sudo apt-get remove --purge -y speech-dispatcher python-speechd libespeak1
sudo apt-get remove --purge -y gwibber gwibber-service
sudo apt-get remove --purge -y ubuntuone-client ubuntuone-client-gnome python-ubuntuone-storageprotocol python-ubuntuone-client

sudo apt-get install -y deborphan
sudo apt-get remove --purge -y `deborphan`

# some of previous command could sometimes remove gnome-shell
sudo apt-get install -y gnome-shell

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


# DVD Read capacity
sudo apt-get install -y libdvdread4
sudo /usr/share/doc/libdvdread4/install-css.sh

# Other good stuff
sudo apt-get install -y sshfs vim vlc ubuntu-restricted-extras p7zip-full unrar cheese inkscape compizconfig-settings-manager firefox thunderbird non-free-codecs

if [ "$ARCH" = "x86_64" ];
then sudo apt-get install -y w64codecs
else sudo apt-get install -y w32codecs
fi

# Finish the install
sudo apt-get update
sudo apt-get upgrade

echo "Installation finished!"
echo "Reboot needed."
