#!/bin/sh
#
#
# Parte del Script de Gestion de Los Servicios ASR 
# Creado por Infraestructura TI
#
#
# Credits by: Jonathan Melendez - Analista de Servidores
# Noviembre 2015

PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

alerta="0"

while : 
do
statustelefonia=`ps -ef|grep asterisk|grep -v grep|head -n 1|wc -l`
statusmarcador=`ps -ef|grep predictivo|grep -v grep|head -n 1|wc -l`
if [ $statustelefonia -eq 1 ] && [ $statusmarcador -eq 1 ] 
then
	alerta="1"
	echo $alerta > /var/www/status_services/asterisk.log	
else
	alerta="0"
	echo $alerta > /var/www/status_services/asterisk.log
fi
sleep 1
done
