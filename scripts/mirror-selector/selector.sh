#!/bin/bash
# By: Jonathan Melendez | Infraestructure IT
# Created: 13/06/2016
# GYSMO Corporacion.
# Mirror and Repos Selector
#
######################
# Execute as Root!!!!#
######################
# Starting Script
PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

clear
echo "Please indicate which repository to use P2P or External (archive.ubuntu) (P2P / EXT)"
read site

if [ "$site" == "" ]; then 
	clear
	echo "The repository must not be empty"
	echo -e "\n"
	exit 1
fi

case $site  in
P2P|p2p)
	echo "" > /etc/apt/sources.list
	echo "deb http://172.16.15.25/ubuntu/ xenial main restricted" >> /etc/apt/sources.list
	echo "deb http://172.16.15.25/ubuntu/ xenial-updates main restricted" >> /etc/apt/sources.list
	echo "deb http://172.16.15.25/ubuntu/ xenial universe" >> /etc/apt/sources.list
	echo "deb http://172.16.15.25/ubuntu/ xenial-updates universe" >> /etc/apt/sources.list
	echo "deb http://172.16.15.25/ubuntu/ xenial multiverse" >> /etc/apt/sources.list
	echo "deb http://172.16.15.25/ubuntu/ xenial-updates multiverse" >> /etc/apt/sources.list
	echo "deb http://172.16.15.25/ubuntu/ xenial-backports main restricted universe multiverse" >> /etc/apt/sources.list
	echo "deb http://172.16.15.25/ubuntu xenial-security main restricted" >> /etc/apt/sources.list
	echo "deb http://172.16.15.25/ubuntu xenial-security universe" >> /etc/apt/sources.list
	echo "deb http://172.16.15.25/ubuntu xenial-security multiverse" >> /etc/apt/sources.list
	echo "" >> /etc/apt/sources.list
	echo "#Generate by Mirror Selector by Jonathan Melendez" >> /etc/apt/sources.list
	apt-get update -y

;;
EXT|ext) 
	echo "" > /etc/apt/sources.list
	echo "deb http://ve.archive.ubuntu.com/ubuntu/ xenial main restricted" >> /etc/apt/sources.list
	echo "deb http://ve.archive.ubuntu.com/ubuntu/ xenial-updates main restricted" >> /etc/apt/sources.list
	echo "deb http://ve.archive.ubuntu.com/ubuntu/ xenial universe" >> /etc/apt/sources.list
	echo "deb http://ve.archive.ubuntu.com/ubuntu/ xenial-updates universe" >> /etc/apt/sources.list
	echo "deb http://ve.archive.ubuntu.com/ubuntu/ xenial multiverse" >> /etc/apt/sources.list
	echo "deb http://ve.archive.ubuntu.com/ubuntu/ xenial-updates multiverse" >> /etc/apt/sources.list
	echo "deb http://ve.archive.ubuntu.com/ubuntu/ xenial-backports main restricted universe multiverse" >> /etc/apt/sources.list
	echo "deb http://security.ubuntu.com/ubuntu xenial-security main restricted" >> /etc/apt/sources.list
	echo "deb http://security.ubuntu.com/ubuntu xenial-security universe" >> /etc/apt/sources.list
	echo "deb http://security.ubuntu.com/ubuntu xenial-security multiverse" >> /etc/apt/sources.list
	echo "" >> /etc/apt/sources.list
	echo "#Generate by Mirror Selector by Jonathan Melendez" >> /etc/apt/sources.list
	apt-get update -y

;;
*)
  echo "You must indicate an external mirror or P2P (P2P or EXT)"
  exit 1
;;
esac
echo "Thanks for use the script Mirror Selector by Infraestructure IT"






