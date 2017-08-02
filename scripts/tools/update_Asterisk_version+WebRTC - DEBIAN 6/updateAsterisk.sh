#!/bin/bash

# Created: 02feb2016

# By: Hector Gonzalez

# GYSMO Corporacion.

# Update asterisk 11 version and install librarys WebRTC

#

#
PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin






echo "Install Dependencies"

sudo apt-get install build-essential subversion libncurses5-dev libssl-dev libxml2-dev libsqlite3-dev \uuid-dev vim-nox screen lsof mlocate wget git linux-headers-`uname -r` doxygen autoconf bison flex curl sox libncurses5-dev libssl-dev libmysqlclient-dev mpg123 libxml2-dev libnewt-dev sqlite3 libsqlite3-dev pkg-config automake libtool unixodbc-dev uuid uuid-dev libasound2-dev libogg-dev libvorbis-dev libcurl4-openssl-dev libical-dev libneon27-dev libsrtp0-dev libspandsp-dev



sudo apt-get install libresample1 libresample1-dev speex libspeex1 libspeex-dev libspeexdsp1 libspeexdsp-dev libgsm1-dev



cd /var/tmp/



echo "Install jansson"



sudo wget http://www.digip.org/jansson/releases/jansson-2.5.tar.gz
sudo tar zxvf jansson-2.5.tar.gz



cd jansson-2.5



autoreconf --force --install

./configure --libdir=/usr/lib64/

sudo make
sudo make install



cd ..



sudo git clone https://github.com/cisco/libsrtp.git

cd libsrtp

sudo ./configure CFLAGS=-fPIC --libdir=/usr/lib64/
sudo make

sudo make uninstall
sudo make install



cd ..

#######Varibles of update asterisk##### 
myuser=`whoami` 
mygroup=`groups` 
actuallyrute=`pwd`
asteriskrute='/etc/asterisk/'
###Ending Variables of update asterisk#

echo "Downloading Asterisk... Please wait..."
sudo wget http://downloads.asterisk.org/pub/telephony/asterisk/old-releases/asterisk-11.11.0.tar.gz

echo "Shutoff Asterisk service"
/etc/init.d/asterisk stop

echo "Copy the important files in /var/tmp"
sudo cp /etc/logrotate.d/asterisk asterisk_old
sudo mkdir -p /var/tmp/asterisk_important_files_in_etc
cd $asteriskrute 
sudo cp * /var/tmp/asterisk_important_files_in_etc
echo "Copy Files finished"

echo "Installing Asterisk 11.11"
cd $actuallyrute
sudo tar -zxvf asterisk-11.11.0.tar.gz
cd asterisk-11.11.0
sudo ./configure CFLAGS=-mtune=native --libdir=/usr/lib64 --disable-asteriskssl
sudo make menuselect
sudo make
sudo make all	
sudo make install	cd 
sudo make samples	
sudo make config
sudo make install-logrotate

sudo chown -R $myuser.$mygroup /usr/lib64/asterisk/	
sudo chown -R $myuser.$mygroup /var/lib/asterisk/
sudo chown -R $myuser.$mygroup /var/spool/asterisk/
sudo chown -R $myuser.$mygroup /var/log/asterisk/
sudo chown -R $myuser.$mygroup /var/run/asterisk/
sudo chown -R $myuser.$mygroup /usr/sbin/asterisk
sudo chown $myuser.$mygroup /etc/default/asterisk
sudo mkdir /var/log/call-queue
sudo chown $myuser.$mygroup /var/log/call-queue

echo "Fixing /etc/asterisk file directory"
cd $asteriskrute
sudo rm -rf *
sudo mv /var/tmp/asterisk_important_files_in_etc/* .

echo "Starting Asterisk service"
/etc/init.d/asterisk start
/etc/init.d/asterisk status
sleep 5

asteriskver=`/usr/sbin/asterisk -rV`
echo "Instalation Finished. The new version installed in this server is: $asteriskver"