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
#	Para ser ejecutado en sistemas RHEL-Centos-Fedora etc...
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
#	V1.0.1= Se corrigen Pasos 6-7-8-9 adaptando a sistemas Centos, Fedora y RHEL

#Comienzo del Script:

echo "Paso 1: Instalando Servicios NTP y NTP-DATE"
yum -y install ntpd ntpdate
sleep 5

echo "Paso 2: Instalando Git"
yum -y install git
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
cd /var/tmp/arquitectura/ntp/etc-centos
mv ntp.conf /etc/
sleep 5

echo "Paso 6: Deteniendo servicio NTP"
service ntpd stop
sleep 5

echo "Paso 7: Sincronizando con server NTP P2P"
ntpdate 172.16.15.25
sleep 5

echo "Paso 8: Iniciando Servicio NTP"
service ntpd start
chkconfig ntpd on
sleep 5

echo "Paso 9: Mostrando resultado por Pantalla"
ntpq -p
sleep 15

echo "Paso 10: Borrando Archivos no necesarios"
cd /var/tmp
rm -Rf arquitectura
sleep 5

echo "Finalizado el Script Automatizado, gracias por utilizarlo"
sleep 5
