#!/bin/bash
# Instalador de Servicio de Monitoreo para ASR Servers 
# Creado por Infraestructura TI | Noviembre 2015
# 
# Credits: 
# Created by Jonathan Melendez el 05/11/2015
#
#
PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

apacheishere=`which apache2|wc -l`

echo "Detectando Apache2"
if [ $apacheishere == 1 ]
then
	echo "Apache Detectado con Exito, continuando la instalacion..."
	sleep 5
	echo "Creando Directorios Necesarios..."
	mkdir -p /var/www/status_services
	echo "Desplegando demonios..."
	cp src/asr_services /etc/init.d
	chmod +x /etc/init.d/asr_services
	cp src/status_process.sh /usr/local/bin
	chmod +x /usr/local/bin/status_process.sh 

	echo "Activando Demonios en el Arranque del S.O"
	update-rc.d asr_services defaults
	update-rc.d asr_services enable

	echo "Activando Servicio de Monitoreo para ASR"
	/etc/init.d/asr_services start
	sleep 2
	echo "Mostrando Estatus..."
	/etc/init.d/asr_services status
	sleep 5
	echo "Instalacion Finalizada con Exito, gracias por usar el instalador automatizado"
	echo "En el webrowser coloca /status_services y veras los logs" 

else
	echo "Apache2 no esta instalado, instalalo primero."
	exit 1

fi
