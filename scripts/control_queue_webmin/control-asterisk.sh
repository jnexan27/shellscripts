#!/bin/bash
#
# Script de Gestion para Asterisk - Queue en Webmin
# Creado por el Departamento de Infraestructura TI | 2015
# 
# Credits: 
# Created by Jonathan Melendez
#
# SOLO PARA SER EJECUTADO POR EL USUARIO QUE EJECUTE ASTERISK
#
# Start and Stop callcenter services

PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

host=`cat /var/log/control-queue/hostname.webmin`

if [ ! -z $2 ]
	then
		case $2 in
		yes|YES)
			case $1 in
			start)
				echo "" >> /var/log/control-queue/asterisk-start.log
				echo "Starting Asterisk P2P Services in $host:" > /var/log/control-queue/asterisk-start.log
				/etc/init.d/asterisk start >> /var/log/control-queue/asterisk-start.log
				cat /var/log/control-queue/asterisk-start.log
				;;
			stop)
				echo "" >> /var/log/control-queue/asterisk-stop.log
				echo "Stopping Asterisk P2P Services in $host:" > /var/log/control-queue/asterisk-stop.log
				/etc/init.d/asterisk stop >> /var/log/control-queue/asterisk-stop.log
				cat /var/log/control-queue/asterisk-stop.log
				;;
			status)
				echo "" >> /var/log/control-queue/asterisk-status.log
				echo "Status of Asterisk P2P Services in $host:" > /var/log/control-queue/asterisk-status.log
				/etc/init.d/asterisk status >> /var/log/control-queue/asterisk-status.log
				cat /var/log/control-queue/asterisk-status.log 
				;;
			esac

		;;
		*)
			echo "Esta accion NO se ejecutara, debes escribir yes para su ejecucion."
		exit 0
		;;
		esac
fi

