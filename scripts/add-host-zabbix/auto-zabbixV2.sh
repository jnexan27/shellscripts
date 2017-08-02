#!/bin/bash

# Script de Instalacion Automatizada de Zabbix Agend 
# Creado por Infraestructura de Tecnologias de Informacion:
#
#	Jonathan Melendez - Analista de Servidores
#
# Fecha: 29 de Junio de 2015
# 
# Comentarios:
#	Este script instala los paquetes
#	-zabbix-agent
#	Para ser ejecutado en sistemas Debian 7 Wheezy, 8 Jessie, Centos 6 y Centos 7
#
# Orden de Ejecucion:
#
# Paso 1: Instala zabbix-agent
# Paso 2: Respalda conf predeterminada de Zabbix Agent
# Paso 3: Edita los Parametros de Configuracion.
# Paso 4: Inicia Servicio de Zabbix Agent
# Paso 5: Anade el Servicio Zabbix Agent al Arranque
# Paso 6: Genera cat del log de Zabbix por 25 segs
# Paso 7: FIN & Enjoy!-
#
# Observaciones:
#	Este script debe ser ejecutado como ROOT
#	********************************EJECUTAR CON ROOT**************************************
#
# Basado en Script de Autoconfig de Reinaldo Martinez
#
# Actualizaciones:
#
#	16-12-2015= Añadiendo Repositorio P2P de Zabbix 2.2 a Instalacion en Debian 7 Wheezy
#	21-08-2015= Fix para creacion de carpeta zabbix_agentd.d en /etc/zabbix/ en Centos 6
#	10-08-2015= Anadiendo Compatibilidad para Centos 6.7
#	30-06-2015= Anadido Soporte para Debian 8 Jessie

#Comienzo del Script:
PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

# Se determina el S/O. Si no es centos o debian se aborta el proceso

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
	release8=`grep -c ^8. /etc/debian_version`
fi

echo "OS Flavor is: $OSFlavor"

if [ $OSFlavor == "unknown" ]
then
        echo "Unknown OS Flavor - Aborting"
        exit 0
fi

#Validador para Instalacion de Zabbix Agent
case $OSFlavor in
redhat-based|centos-based)
        echo "Paso 1: Instalando Zabbix Agent para $OSFlavor"
        yum -y install zabbix22-agent
        sleep 5  
	
	echo "Paso 2: Respaldando Configuracion Original"
	cd /etc/
	cp zabbix_agentd.conf zabbix_agentd.conf.ORIGINAL
	sleep 5

	echo "Paso 3: Editando Configuracion Predeterminada"
	sed -r -i 's/Server=127.0.0.1/\#Server=127.0.0.1/g' /etc/zabbix_agentd.conf;
	sed -r -i 's/ServerActive=127.0.0.1/\#ServerActive=127.0.0.1/g' /etc/zabbix_agentd.conf;
	sed -r -i 's/Hostname=Zabbix server/\#Hostname=Zabbix server/g' /etc/zabbix_agentd.conf;
	echo "#Parametros de Conexion a Zabbix Server P2P" >> /etc/zabbix_agentd.conf;
	echo "Server=172.16.10.120" >> /etc/zabbix_agentd.conf;
	echo "ServerActive=172.16.10.120" >> /etc/zabbix_agentd.conf;
	
        ;;
debian-based)
	case $release8 in
	1)
		echo "Paso 1: Instalando Zabbix Agent para $OSFlavor Jessie 8"
		aptitude update
		aptitude install -y zabbix-agent
		sleep 5

		cd /etc/zabbix/
		echo "Paso 2: Respaldando Configuracion Original para $OSFlavor Jessie 8"
		cp zabbix_agentd.conf zabbix_agentd.conf.ORIGINAL
		sleep 5	
	
		echo "Paso 3: Editando Configuracion Predeterminada para $OSFlavor Jessie 8"
		sed -r -i 's/Server=127.0.0.1/\#Server=127.0.0.1/g' /etc/zabbix/zabbix_agentd.conf;
		sed -r -i 's/ServerActive=127.0.0.1/\#ServerActive=127.0.0.1/g' /etc/zabbix/zabbix_agentd.conf;
		sed -r -i 's/Hostname=Zabbix server/\#Hostname=Zabbix server/g' /etc/zabbix/zabbix_agentd.conf;
		echo "#Parametros de Conexion a Zabbix Server P2P" >> /etc/zabbix/zabbix_agentd.conf;
		echo "Server=172.16.10.120" >> /etc/zabbix/zabbix_agentd.conf;
		echo "ServerActive=172.16.10.120" >> /etc/zabbix/zabbix_agentd.conf;
		;;
	0)
      		echo "Paso 1:Instalando Zabbix Agent Para $OSFlavor Wheezy 7"
		cd /var/tmp/
		wget http://repo.zabbix.com/zabbix/2.2/debian/pool/main/z/zabbix-release/zabbix-release_2.2-1+wheezy_all.deb
		dpkg -i zabbix-release_2.2-1+wheezy_all.deb
		apt-get update
		aptitude install -y zabbix-agent
        	sleep 5

		cd /etc/zabbix/
		echo "Paso 2: Respaldando Configuracion Original para Debian Wheezy 7"
		cp zabbix_agentd.conf zabbix_agentd.conf.ORIGINAL
		sleep 5

		echo "Paso 3: Editando Configuracion Predeterminada para Debian Wheezy 7"
		sed -r -i 's/Server=127.0.0.1/\#Server=127.0.0.1/g' /etc/zabbix/zabbix_agentd.conf;
		sed -r -i 's/ServerActive=127.0.0.1/\#ServerActive=127.0.0.1/g' /etc/zabbix/zabbix_agentd.conf;
		sed -r -i 's/Hostname=Zabbix server/\#Hostname=Zabbix server/g' /etc/zabbix/zabbix_agentd.conf;
		echo "#Parametros de Conexion a Zabbix Server P2P" >> /etc/zabbix/zabbix_agentd.conf;
		echo "Server=172.16.10.120" >> /etc/zabbix/zabbix_agentd.conf;
		echo "ServerActive=172.16.10.120" >> /etc/zabbix/zabbix_agentd.conf;
		echo > /etc/apt/sources.list.d/zabbix.list
		echo "#Servidor P2P de Zabbix 2.2 para Debian 7" >> /etc/apt/sources.list.d/zabbix.list
		echo "deb http://172.16.15.25/zabbix-apt/2.2/debian wheezy main" >> /etc/apt/sources.list.d/zabbix.list
		apt-get update
        	;;
	esac
	;;
*)
        echo "Houston, tenemos un problema, Sistema No Compatible. Abortando"
        exit 0
        ;;
esac

case $OSFlavor in
redhat-based|centos-based)
	case $release7 in 
	1)
		echo "Paso 4: Iniciando Zabbix Agent para $OSFlavor 7"
      		systemctl start zabbix-agent
		sleep 5
		echo "Paso 5: Anadiendo Zabbix Agent al Arranque de $OSFlavor 7"
		systemctl enable zabbix-agent
        	sleep 5 
		echo "Paso 6: Determinando directorio zabbix_agentd.d en /etc/zabbix/"
		mkdir -p /etc/zabbix/zabbix_agentd.d
		sleep 3
		echo "#Parametro para Determinar Directorio zabbix_agent.d en /etc/zabbix/" >> /etc/zabbix_agentd.conf
		echo "Include=/etc/zabbix/zabbix_agentd.d/" >> /etc/zabbix_agentd.conf
		echo "Paso 7: Mostrando Cat del Log de Zabbix"
		cat /var/log/zabbix/zabbix_agentd.log
		sleep 25
		echo "Paso 8: Reiniciando el servicio zabbix_agent en $OSFlavor 7"
		systemctl restart zabbix-agent
		;;
	0) 
        	echo "Paso 4: Iniciando Zabbix Agent para $OSFlavor 6"
        	/etc/init.d/zabbix-agent start
		sleep 5
		echo "Paso 5: Anadiendo Zabbix Agent al Arranque de $OSFlavor 6"
		chkconfig --add zabbix-agent
		chkconfig zabbix-agent on
       		sleep 5 
		echo "Paso 6: Determinando directorio zabbix_agentd.d en /etc/zabbix/"
		mkdir -p /etc/zabbix/zabbix_agentd.d
		sleep 3
		echo "#Parametro para Determinar Directorio zabbix_agent.d en /etc/zabbix/" >> /etc/zabbix_agentd.conf
		echo "Include=/etc/zabbix/zabbix_agentd.d/" >> /etc/zabbix_agentd.conf
		echo "Paso 7: Mostrando Cat del Log de Zabbix"
		cat /var/log/zabbix/zabbix_agentd.log
		sleep 25
		echo "Paso 8: Reiniciando el servicio zabbix_agent en $OSFlavor 6"
		/etc/init.d/zabbix-agent restart
		;;
	esac
	;;
debian-based)
	case $release8 in 
	1)
		echo "Paso 4: Iniciando Zabbix Agent para $OSFlavor Jessie 8"
      		systemctl restart zabbix-agent
		sleep 5
		echo "Paso 5: Anadiendo Zabbix Agent al Arranque de $OSFlavor Jessie 8"
		systemctl enable zabbix-agent
        	sleep 5 
		echo "Paso 6: Mostrando Cat del Log de Zabbix"
		cat /var/log/zabbix-agent/zabbix_agentd.log
		sleep 25
		;;
	0)
        	echo "Paso 4: Iniciando Zabbix Agent para $OSFlavor Wheezy 7"
		/etc/init.d/zabbix-agent restart
	        sleep 5
		echo "Paso 5: Anadiendo Zabbix Agent al Arranque de $OSFlavor Wheezy 7"
		update-rc.d zabbix-agent defaults
		sleep 5
		echo "Paso 6: Mostrando Cat del Log de Zabbix"
		cat /var/log/zabbix/zabbix_agentd.log
		sleep 25
        	;;
	esac
	;;
*)
        echo "Houston, tenemos un problema, Sistema No Compatible. Abortando"
        exit 0
        ;;
esac

echo "Finalizado el Script Automatizado, gracias por utilizarlo"
sleep 5

