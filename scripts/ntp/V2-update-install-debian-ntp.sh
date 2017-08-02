#!/bin/bash

# Script de Actualizacion/Instalacion de NTP para Servidores Fisicos y Cloud
# Creado por Arquitectura de Tecnologias:
#
#	Jonathan Melendez - Analista de Servidores
#
# Fecha: 12 de Junio de 2015
# 
# Comentarios:
#	Este script instala los paquetes
#	-ntp
#	-ntpdate
#	-git
#	Para ser ejecutado en sistemas Debian etc...
#
# Orden de Ejecucion:
#
# Paso 1: Instala ntp y ntp-date
# Paso 2: Instala Git
# Paso 3: Realiza Git Clone del proyecto arquitectura
# Paso 4: Respalda antiguo ntp.conf y lo borra
# Paso 5: Mueve el ntp.conf de la carpeta en git arquitectura a /etc/
# Paso 6: Stop al servicio ntp
# Paso 7: Sincronizacion con Server NTP Central P2P
# Paso 8: Start al servicio ntp
# Paso 9: Muestra por pantalla el resultado
# Paso 10: Borra la carpeta del proyecto arquitectura git
# Paso 11: FIN & Enjoy!-
#
# Observaciones:
#	Este script debe ser ejecutado como ROOT
#	********************************EJECUTAR CON ROOT**************************************
#
#
# Actualizaciones:
#	Fecha: 15-06-2015
#	V2.0.0 = Eliminados Pasos 2-3-4-5-10, se implementa expresion regular sed y echo para escribir archivos.
#

#Comienzo del Script:

echo "Paso 1: Instalando Servicios NTP y NTP-DATE"
aptitude update
aptitude install -y ntp ntpdate
sleep 5

echo "Paso 2: Editando Archivos NTP-Config"
cd /etc/
cp ntp.conf ntp.conf.COPIA
sed -r -i 's/server/\#server/g' /etc/ntp.conf;
echo "#Server NTP P2P" >> /etc/ntp.conf
echo "server 172.16.15.25" >> /etc/ntp.conf

sleep 5

echo "Paso 3: Deteniendo servicio NTP"
/etc/init.d/ntp stop
sleep 5

echo "Paso 4: Sincronizando con server NTP P2P"
ntpdate-debian
sleep 5

echo "Paso 5: Iniciando Servicio NTP"
/etc/init.d/ntp start
sleep 5

echo "Paso 6: Mostrando resultado por Pantalla"
ntpq -np
sleep 15

echo "Finalizado el Script Automatizado, gracias por utilizarlo"
sleep 5

