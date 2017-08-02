#!/bin/bash
# Instalador de Servicio de Rotation Survey y Calculate Survey GYSMO 1.8 
# Creado por Infraestructura TI | Noviembre 2015
# 
# Credits: 
# Created by Jonathan Melendez el 05/11/2015
#
#
PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

	echo "Desplegando demonios..."
	mkdir -p /var/log/gysmo-sincro/
	cp src/rotation_survey /etc/init.d
	cp src/calculate_survey /etc/init.d
	chmod +x /etc/init.d/calculate_survey
	chmod +x /etc/init.d/rotation_survey

	echo "Activando Demonios en el Arranque del S.O"
	update-rc.d rotation_survey defaults
	update-rc.d rotation_survey enable
	update-rc.d calculate_survey defaults
	update-rc.d calculate_survey enable

	echo "Activando Servicio de Rotation Survey"
	/etc/init.d/rotation_survey start
	/etc/init.d/calculate_survey start
	sleep 2
	echo "Mostrando Estatus..."
	/etc/init.d/rotation_survey status
	/etc/init.d/calculate_survey status
	sleep 5
	echo "Instalacion Finalizada con Exito, gracias por usar el instalador automatizado"
