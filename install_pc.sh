#!/bin/sh

ARCH=`uname -p`
SYNC_FOLDER=~/ownCloud/sync
APPLICATION_DIR=~/Programmes
# Git: One to rules them all
apt-get install git ssh

mkdir -p $APPLICATION_DIR

# Source list for different good app ;-)

# Google
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
# Install google earth package to provide google repos in apt.
wget http://dl.google.com/dl/earth/client/current/google-earth-stable_current_amd64.deb -O /tmp/google-earth.deb
sudo dpkg -i /tmp/google-earth.deb

sudo echo "
deb http://repository.spotify.com stable non-free

" >> /etc/apt/source.list

wget -q "http://deb.playonlinux.com/public.gpg" -O- | sudo apt-key add -
sudo wget http://deb.playonlinux.com/playonlinux_precise.list -O /etc/apt/sources.list.d/playonlinux.list
sudo apt-get update
sudo apt-get install playonlinux


# Install xpad
ln -s $SYNC_FOLDER/xpad /home/$USER/.config/xpad
sudo apt-get install xpad 

# Install FileZilla
ln -s $SYNC_FOLDER/filezilla /home/$USER/.filezilla
sudo apt-get install filezilla

sudo apt-get remove --purge avahi-autoipd avahi-utils libnss-mdns libavahi-client-dev libavahi-common-dev libavahi-core6
sudo apt-get remove --purge empathy empathy-common telepathy-salut telepathy-gabble telepathy-haze telepathy-idle telepathy-mission-control-5 python-telepathy indicator-messages
sudo apt-get remove --purge speech-dispatcher python-speechd libespeak1
sudo apt-get remove --purge gwibber gwibber-service
sudo apt-get remove --purge ubuntuone-client ubuntuone-client-gnome python-ubuntuone-storageprotocol python-ubuntuone-client

sudo apt-get install deborphan
sudo apt-get remove --purge `deborphan`

# some of previous command could sometimes remove gnome-shell
sudo apt-get install gnome-shell

# Install hamster & hamster-shell
sudo apt-get remove --purge hamster-indicator hamster-applet
killall -9 hamster-service
killall -9 hamster-time-tracker
sudo apt-get install git-core gettext intltool gnome-control-center-dev
./waf configure build --prefix=/usr
sudo ./waf install

cd $APPLICATION_DIR
git clone git://github.com/projecthamster/shell-extension.git
cd ~/.local/share/gnome-shell/extensions/
ln -s $APPLICATION_DIR/shell-extension hamster@projecthamster.wordpress.com

