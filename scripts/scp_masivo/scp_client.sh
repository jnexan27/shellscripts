#!/bin/bash 
# Script para copia de archivos de forma masiva usando SCP
# Creado por la Coordinacion de Arquitectura Tecnologica:
#
#	Jonathan Melendez - Analista de Servidores
#
# Fecha: 28 de Julio de 2015
# 
# Comentarios:
#	Este script realiza un copiado masivo de archivos via SCP
#
# Orden de Ejecucion:
#
# Paso 0: El Script listara los archivos disponibles en el directorio de ejecucion
# Paso 1: El Script solicitara el nombre del archivo que deseas copiar
# Paso 2: Luego se debe especificr la ruta destino en los servidores.
# Paso 3: El Script copia el archivo en la ruta especificada.
# Paso 4: FIN del Script.
#
# Observaciones:
#	Este script NO depende de root para funcionar
#Se debe ejecutar unicamente en los workstation NUNCA EN LOS SERVIDORES DIRECTAMENTE
#*******************NO NECESITA ROOT******************************
#*******EJECUTALO DESDE EL WORKSTATION DE ARQUITECTURA NUNCA DESDE UN SERVIDOR*************
#
#
# Actualizaciones:
#	
#	
#
#
#Comienzo del Script

clear
tput cup 1 18 ; echo -n "*******************************************"
tput cup 2 18 ; echo -n "	   SCP MASIVO DE ARCHIVOS           "
tput cup 3 18 ; echo -n "*******************************************"
echo ""
echo ""
echo "Listando Archivos en este directorio" 
listadodir=`ls -la . | awk '{print $9}'`
echo "$listadodir"
sleep 3
echo ""
echo "Ingrese el nombre del archivo (debe estar en la misma ruta que este script): "
read archivoserver

echo "Por favor indique la ruta donde desea copiar el archivo (ejemplo /var/tmp/): "
read rutadest

echo "Copiando Script a los Servidores..." 
for dest in $(<servidores.txt); do
	scp $archivoserver root@${dest}:$rutadest
done

echo "FIN Del Script. Gracias por utilizarlo."
