#!/bin/bash
#
# Script de Gestion para Asterisk - Queue - Monit en Webmin
# Creado por el Departamento de Infraestructura TI | 2015
# 
# Credits: 
# Created by Jonathan Melendez
#
# SOLO PARA SER EJECUTADO POR EL USUARIO ROOT SIN SUDO
# OJO= NO USAR SUDO, SOLO ROOT
# Start and Stop callcenter services

PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

host=`cat /var/log/control-queue/hostname.webmin`

if [ ! -z $2 ]
	then
		case $2 in
		yes|YES)
			case $1 in
			start)
				echo "" >> /var/log/control-queue/monit-start.log
				echo "Starting Monit P2P Services in $host:" > /var/log/control-queue/monit-start.log
				/etc/init.d/monit start >> /var/log/control-queue/monit-start.log
				cat /var/log/control-queue/monit-start.log
				;;
			stop)
				echo "" >> /var/log/control-queue/monit-stop.log
				echo "Stopping Monit P2P Services in $host:" > /var/log/control-queue/monit-stop.log
				/etc/init.d/monit stop >> /var/log/control-queue/monit-stop.log
				cat /var/log/control-queue/monit-stop.log
				;;
			status)
				echo "" >> /var/log/control-queue/monit-status.log
				echo "Status of Monit P2P Services in $host:" > /var/log/control-queue/monit-status.log
				/etc/init.d/monit status >> /var/log/control-queue/monit-status.log
				cat /var/log/control-queue/monit-status.log 
				;;
			esac

		;;
		*)
			echo "Esta accion NO se ejecutara, debes escribir yes para su ejecucion."
		exit 0
		;;
		esac
else
	echo "Debes especificar YES para que se ejecute el comando"
fi

