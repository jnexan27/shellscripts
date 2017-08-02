#!/bin/bash

# Script de actualizacion de asterisk para MPSANP-CANTV
# Creado por el equipo de telefonia:
#	Hector Gonzalez
#	Jonathan Melendez
#	Enrique Fermin
# Fecha: 08 de Mayo de 2015
# 
# Comentarios:
#	Este script remueve la funcionalidad de la cola a traves de screen y coloca los java a traves de servicios
#	Los servicios sdeben ser iniciados a traves de /etc/init.d/callcenter.sh
#
# Observaciones:
#	Este script debe ser ejecutado por un usuario NO ROOT pero debe tener permisologia con SUDO
#	********************************NO EJECUTAR CON ROOT**************************************
#	SE DEBEN BAJAR CON ANTELACION LOS SERVICIOS DE ASTERISK Y LOS SCREEN
#
# Actualizaciones:
#	
#

echo "Bajando Servicios de Asterisk y Screen"
sudo /etc/init.d/asterisk stop
for i in `sudo screen -list | grep .Presence | awk '{print $1}'`; do sudo screen -X -S $i quit;done;
    for i in `sudo screen -list | grep .Billing | awk '{print $1}'`; do sudo screen -X -S $i quit;done;
    for i in `sudo screen -list | grep .AGI | awk '{print $1}'`; do sudo screen -X -S $i quit;done;
echo "Finalizando Stop de Servicios Asterisk y Screen"

echo "Respaldando Carpeta Callcenter"
cd /var/lib/asterisk/agi-bin 
DATE=$(date +%Y-%m-%d)
tar -zcvf callcenter_$DATE.tar.gz callcenter
echo "Respaldo de Carpeta Callcenter Finalizado"

echo "Removiendo Carpeta Callcenter"
rm -rf callcenter
echo "Carpeta Borrada"

echo "Actualizando Repos e Instalando git de ser necesario"
sudo apt-get update
sudo apt-get install git

echo "Haciendo Git Clone del Asterisk Queue"
git clone http://172.16.40.215/telefonia/asterisk-queue.git

echo "Renombrando carpetas"
mv asterisk-queue callcenter

cd callcenter

echo "Ejecutando Compilador"
./compilar.sh






