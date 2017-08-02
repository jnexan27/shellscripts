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

optionlist='
	presence
	livemonitor
	agi'

host=`cat /var/log/control-queue/hostname.webmin`

if [ ! -z $3 ]
	then
		case $3 in
		presence)
			optionlist="presence"
		;;
		agi)
			optionlist="agi"
		;;
		livemonitor)
			optionlist="livemonitor"
		;;
		*)
			echo "Parametro NO valido."
			exit 0
		;;
		esac
fi

start(){
	for svc in $optionlist
	do
	case $svc in
		presence)
			echo "" >> /var/log/control-queue/queue-presence-start.log
			echo "Starting Presence of the Queue P2P Services in $host: " > /var/log/control-queue/queue-presence-start.log
			/etc/init.d/callcenter start presence >> /var/log/control-queue/queue-presence-start.log
			cat /var/log/control-queue/queue-presence-start.log
		;;
		livemonitor)
			echo "" >> /var/log/control-queue/queue-livemonitor-start.log
			echo "Starting LiveMonitor of the Queue P2P Services in $host: " > /var/log/control-queue/queue-livemonitor-start.log
			/etc/init.d/callcenter start livemonitor >> /var/log/control-queue/queue-livemonitor-start.log
			cat /var/log/control-queue/queue-livemonitor-start.log
		;;
		agi)
			echo "" >> /var/log/control-queue/queue-agi-start.log
			echo "Starting AGI of the Queue P2P Services in $host: " > /var/log/control-queue/queue-agi-start.log
			/etc/init.d/callcenter start agi >> /var/log/control-queue/queue-agi-start.log
			cat /var/log/control-queue/queue-agi-start.log
		;;
	esac
	done
	}

status(){
	for svc in $optionlist
	do
	case $svc in
		presence)
			echo "" >> /var/log/control-queue/queue-presence-status.log
			echo "Status of Presence of the Queue P2P Services in $host: " > /var/log/control-queue/queue-presence-status.log
			/etc/init.d/callcenter status presence >> /var/log/control-queue/queue-presence-status.log
			cat /var/log/control-queue/queue-presence-status.log
		;;
		livemonitor)
			echo "" >> /var/log/control-queue/queue-livemonitor-status.log
			echo "Status of LiveMonitor of the Queue P2P Services in $host: " > /var/log/control-queue/queue-livemonitor-status.log
			/etc/init.d/callcenter status livemonitor >> /var/log/control-queue/queue-livemonitor-status.log
			cat /var/log/control-queue/queue-livemonitor-status.log
		;;	
		agi)	
			echo "" >> /var/log/control-queue/queue-agi-status.log
			echo "Status of AGI of the Queue P2P Services in $host: " > /var/log/control-queue/queue-agi-status.log
			/etc/init.d/callcenter status agi >> /var/log/control-queue/queue-agi-status.log
			cat /var/log/control-queue/queue-agi-status.log
		;;	
	esac
	done
	}

stop(){
	for svc in $optionlist
	do
	case $svc in
		presence)
			echo "" >> /var/log/control-queue/queue-presence-stop.log
			echo "Stopping Presence of the Queue P2P Services in $host: " > /var/log/control-queue/queue-presence-stop.log
			/etc/init.d/callcenter stop presence >> /var/log/control-queue/queue-presence-stop.log
			cat /var/log/control-queue/queue-presence-stop.log
		;;
		livemonitor)
			echo "" >> /var/log/control-queue/queue-livemonitor-stop.log
			echo "Stopping LiveMonitor of the Queue P2P Services in $host: " > /var/log/control-queue/queue-livemonitor-stop.log
			/etc/init.d/callcenter stop livemonitor >> /var/log/control-queue/queue-livemonitor-stop.log
			cat /var/log/control-queue/queue-livemonitor-stop.log
		;;
		agi)
			echo "" >> /var/log/control-queue/queue-agi-stop.log
			echo "Stopping AGI of the Queue P2P Services in $host: " > /var/log/control-queue/queue-agi-stop.log
			/etc/init.d/callcenter stop agi >> /var/log/control-queue/queue-agi-stop.log
			cat /var/log/control-queue/queue-agi-stop.log
		;;
	esac
	done
	}
		

		


case $2 in
	yes|YES)
		case $1 in
			start)
				start
			;;
			stop)
				stop
			;;
			restart)
	                	stop
        	                echo "Services of queue stopped successfully... Wait 5 seconds..."
                		sleep 5
                        	echo "Starting services..."
                		start
			;;
			status)
				status
			;;
		esac
	;;
	*)
		echo "Esta accion NO se ejecutara, debes escribir yes para su ejecucion."
		exit 0
	;;
esac
