sudo apt-get install -y libneon27 libneon27-dev fuse fuse-utils libfuse-dev
cd /tmp/
wget http://noedler.de/projekte/wdfs/wdfs-1.4.2.tar.gz
tar xzvf wdfs-1.4.2.tar.gz
cd wdfs-1.4.2
./configure
make
sudo make install
cd src
sudo cp wdfs /usr/local/bin
