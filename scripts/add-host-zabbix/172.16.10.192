#!/bin/bash

# Script of Automated Installation of Zabbix Agent 3.0
# Created by the department Infraestructura Tecnologica 
# GYSMO CORPORACION.- 
#
#	Developed by:
#	Jonathan Melendez - Analista de Servidores | jmelendez@gysmo.co
#
# Date: 25 de Abril de 2016
# 
# Comments:
#	This script installs the following packages:
#	-zabbix-agent
#	Compatible only with: 
#	- Debian 7 x64
#	- Debian 8 x64
#	- Ubuntu Trusty 14.04 x64
#	- Ubuntu Xenial 16.04 x64
#	- CentOS 6 x64
#	- Centos 7 x64
#
#
# Observations:
#	This script must be executed by only ROOT
#	********************************EXECUTE ONLY ROOT**************************************
# Updates:
#
#	09/05/2016= Added Metadata Items for Linux operative Systems
#
#Starting Script:
PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

#Determining Network 
headquartersAT=`hostname | grep -c at`

if [ $headquartersAT -eq 1 ]
	then 
	echo "Your Network is Atlantic, Configuring Installer for Zabbix Proxy AT Connection"
	sleep 3
	zabbixip="172.16.31.145"
	else
	echo "Your Network is External (Hilocentro - Triangulo - Urbina - Befranza - Autana), Configuring Installer for Zabbix Server Connection"
	sleep 3
	zabbixip="172.16.10.57,172.16.10.58"
fi 

# Determining OS in this server
OSFlavor='unknown'

if [ -f /etc/redhat-release ]
then
        OSFlavor='redhat-based'
fi

if [ -f /etc/centos-release ]
then
        OSFlavor='centos-based'
	release7=`grep -c release.\7. /etc/centos-release`
fi

if [ -f /etc/debian_version ]
then
        OSFlavor='debian-based'
	jessiver=`grep -c ^8. /etc/debian_version`
	ubuntuos=`grep -c sid /etc/debian_version` 
		if [ $ubuntuos -eq 1 ]
		then 
			OSFlavor='ubuntu-distro'
			xenialver=`lsb_release -a | grep -c xenial`
		fi			
fi

echo "OS Flavor is: $OSFlavor"

if [ $OSFlavor == "unknown" ]
then
        echo "Unknown OS Flavor - Aborting"
        exit 0
fi

#Validating previous installation of Zabbix Agent
if [ -d /etc/zabbix ] 
then
	zbver=`zabbix_agent -V | grep v | awk '{print $3}'`
	echo "It already exists Zabbix Agent in this server, please uninstall old version $zbver which is installed in this Server $OSFlavor"
	exit 0
else
	echo "Continuing Unattended Installer"
fi

#Step by Step for install and autoconfigure Zabbix in your server

echo "Step 1: Installing And Configuring Zabbix Agent in your server $OSFlavor"
sleep 5
case $OSFlavor in
redhat-based|centos-based)
	sleep 5
	echo "Step 1.1: Identifying your Centos Version in this server"
	case $release7 in
		1)
		rpm -ivh http://repo.zabbix.com/zabbix/3.0/rhel/7/x86_64/zabbix-release-3.0-1.el7.noarch.rpm
		;;
		0)
		rpm -ivh http://repo.zabbix.com/zabbix/3.0/rhel/6/x86_64/zabbix-release-3.0-1.el6.noarch.rpm
		yum -y install zabbix-agent.x86_64
		;;
	esac
	yum -y install zabbix-agent.x86_64
	cp /etc/zabbix/zabbix_agentd.conf /etc/zabbix/zabbix_agentd.conf.ORIGINAL
	sed -r -i 's/Server=127.0.0.1/\#Server=127.0.0.1/g' /etc/zabbix/zabbix_agentd.conf;
	sed -r -i 's/ServerActive=127.0.0.1/\#ServerActive=127.0.0.1/g' /etc/zabbix/zabbix_agentd.conf;
	sed -r -i 's/Hostname=Zabbix server/\#Hostname=Zabbix server/g' /etc/zabbix/zabbix_agentd.conf;
	echo "#Parametros de Conexion a Zabbix Server P2P" >> /etc/zabbix/zabbix_agentd.conf;
	echo "Server=$zabbixip" >> /etc/zabbix/zabbix_agentd.conf;
	echo "ServerActive=$zabbixip" >> /etc/zabbix/zabbix_agentd.conf;
	echo "HostMetadata=Linux" >> /etc/zabbix/zabbix_agentd.conf;
	echo "HostMetadataItem=Linux" >> /etc/zabbix/zabbix_agentd.conf;
	echo ""
;;
debian-based)
	sleep 5
	echo "Step 1.1: Identifying your Debian Version in this server"
	case $jessiver in
		1)
		mkdir -p /var/temp/zabbixtemp
		wget http://repo.zabbix.com/zabbix/3.0/debian/pool/main/z/zabbix-release/zabbix-release_3.0-1+jessie_all.deb -O /var/temp/zabbixtemp/zabbix-release_3.0-1+jessie_all.deb
		dpkg -i /var/temp/zabbixtemp/zabbix-release_3.0-1+jessie_all.deb
		;;
		0)
		mkdir -p /var/temp/zabbixtemp
		wget http://repo.zabbix.com/zabbix/3.0/debian/pool/main/z/zabbix-release/zabbix-release_3.0-1+wheezy_all.deb -O /var/temp/zabbixtemp/zabbix-release_3.0-1+wheezy_all.deb
		dpkg -i /var/temp/zabbixtemp/zabbix-release_3.0-1+wheezy_all.deb
		;;
	esac
	apt-get update -y && apt-get -y install zabbix-agent
	/etc/init.d/zabbix-agent stop
	cp /etc/zabbix/zabbix_agentd.conf /etc/zabbix/zabbix_agentd.conf.ORIGINAL
	sed -r -i 's/Server=127.0.0.1/\#Server=127.0.0.1/g' /etc/zabbix/zabbix_agentd.conf;
	sed -r -i 's/ServerActive=127.0.0.1/\#ServerActive=127.0.0.1/g' /etc/zabbix/zabbix_agentd.conf;
	sed -r -i 's/Hostname=Zabbix server/\#Hostname=Zabbix server/g' /etc/zabbix/zabbix_agentd.conf;
	echo "#Parametros de Conexion a Zabbix Server P2P" >> /etc/zabbix/zabbix_agentd.conf;
	echo "Server=$zabbixip" >> /etc/zabbix/zabbix_agentd.conf;
	echo "ServerActive=$zabbixip" >> /etc/zabbix/zabbix_agentd.conf;
	echo "HostMetadata=Linux" >> /etc/zabbix/zabbix_agentd.conf;
	echo "HostMetadataItem=Linux" >> /etc/zabbix/zabbix_agentd.conf;
	rm -rf /var/temp/zabbixtemp
	echo ""
	#Tweaks for your Debian system
	/etc/init.d/zabbix-agent start
	update-rc.d zabbix-agent enable
	update-rc.d zabbix-agent defaults
;;
ubuntu-distro)
	sleep 5
	echo "Step 1.1: Identifying your Ubuntu Version in this server"
	case $xenialver in
		1)
		mkdir -p /var/temp/zabbixtemp
		wget http://repo.zabbix.com/zabbix/3.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_3.0-1+trusty_all.deb -O /var/temp/zabbixtemp/zabbix-release_3.0-1+trusty_all.deb
		dpkg -i /var/temp/zabbixtemp/zabbix-release_3.0-1+trusty_all.deb
		;;
		0)
		mkdir -p /var/temp/zabbixtemp
		wget http://repo.zabbix.com/zabbix/3.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_3.0-1+trusty_all.deb -O /var/temp/zabbixtemp/zabbix-release_3.0-1+trusty_all.deb
		dpkg -i /var/temp/zabbixtemp/zabbix-release_3.0-1+trusty_all.deb
		;;
	esac
	apt-get update -y && apt-get -y install zabbix-agent
	/etc/init.d/zabbix-agent stop
	cp /etc/zabbix/zabbix_agentd.conf /etc/zabbix/zabbix_agentd.conf.ORIGINAL
	sed -r -i 's/Server=127.0.0.1/\#Server=127.0.0.1/g' /etc/zabbix/zabbix_agentd.conf;
	sed -r -i 's/ServerActive=127.0.0.1/\#ServerActive=127.0.0.1/g' /etc/zabbix/zabbix_agentd.conf;
	sed -r -i 's/Hostname=Zabbix server/\#Hostname=Zabbix server/g' /etc/zabbix/zabbix_agentd.conf;
	echo "#Parametros de Conexion a Zabbix Server P2P" >> /etc/zabbix/zabbix_agentd.conf;
	echo "Server=$zabbixip" >> /etc/zabbix/zabbix_agentd.conf;
	echo "ServerActive=$zabbixip" >> /etc/zabbix/zabbix_agentd.conf;
	echo "HostMetadata=Linux" >> /etc/zabbix/zabbix_agentd.conf;
	echo "HostMetadataItem=Linux" >> /etc/zabbix/zabbix_agentd.conf;
	rm -rf /var/temp/zabbixtemp
	#Tweaks for your Ubuntu system
	/etc/init.d/zabbix-agent start
	update-rc.d zabbix-agent enable
	update-rc.d zabbix-agent defaults
;;
esac

#Tweaks ONLY FOR Centos/RHEL Systems

case $OSFlavor in
redhat-based|centos-based)
	case $release7 in
		1) 
		systemctl start zabbix-agent
		systemctl enable zabbix-agent
		;;
		0)
		/etc/init.d/zabbix-agent start
		chkconfig --add zabbix-agent
		chkconfig zabbix-agent on
		;;
	esac
;;
*)
	echo "The Tweaks for your system $OSFlavor have been applied"
	;;
esac
echo "Zabbix Agent 3.0 Successfully Installed in your Server $OSFlavor"

echo "Step 2: For 25 Seconds will be shown the next log, PLEASE WAIT"
echo "REMEMBER: 25 SECONDS, PATIENCE."
echo ""
cat /var/log/zabbix/zabbix_agentd.log
sleep 25
echo "Installation Complete, Thank yor for using Auto-ZabbixV3 Installer by Infraestructure IT" 
