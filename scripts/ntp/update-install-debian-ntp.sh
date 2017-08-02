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
#	
#

#Comienzo del Script:

echo "Paso 1: Instalando Servicios NTP y NTP-DATE"
aptitude update
aptitude install -y ntp ntpdate
sleep 5

echo "Paso 2: Instalando Git"
aptitude install -y git
sleep 5

echo "Paso 3: Bajando Proyecto Arquitectura de git"
cd /var/tmp
git clone http://172.16.40.215/servidores/arquitectura.git
sleep 5

echo "Paso 4: Respaldando ntp viejo y borrandolo"
cd /etc/
cp ntp.conf ntp.conf.COPIA
rm -f ntp.conf
sleep 3

echo "Paso 5: Moviendo Parametros de Configuracion"
cd /var/tmp/arquitectura/ntp/etc/
mv ntp.conf /etc/
sleep 5

echo "Paso 6: Deteniendo servicio NTP"
/etc/init.d/ntp stop
sleep 5

echo "Paso 7: Sincronizando con server NTP P2P"
ntpdate-debian
sleep 5

echo "Paso 8: Iniciando Servicio NTP"
/etc/init.d/ntp start
sleep 5

echo "Paso 9: Mostrando resultado por Pantalla"
ntpq -np
sleep 15

echo "Paso 10: Borrando archivos no necesarios"
cd /var/tmp
rm -Rf arquitectura
sleep 5

echo "Finalizado el Script Automatizado, gracias por utilizarlo"
sleep 5





