#!/bin/bash 
# Script para cambio de claves en Todos los Servidores de la Nube
# Creado por la Coordinacion de Arquitectura Tecnologica:
#
#	Jonathan Melendez - Analista de Servidores
#
# Fecha: 17 de Julio de 2015
# 
# Comentarios:
#	Este script cambia las claves de root en todos los servidores de la Nube OpenStack y Servidores Fisicos 
#
# Orden de Ejecucion:
#
# Paso 1: Copia el script que ejecuta el cambio de clave a la ruta /var/tmp en todos los servidores
# Paso 2: Ejecuta el script cambiador de clave en todos los servidores 
# Paso 3: Fin del Script.
# Paso 4: Enjoy!-
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

echo "Paso 1: Copiando Script Cambiador de Clave a los Servidores" 
for dest in $(<servidores.txt); do
	scp change_pass_server.sh ${dest}:/var/tmp
done

echo "Paso 2: Ejecutando Comando Cambiador de Clave en Servidor"
for dest in $(<servidores.txt); do
	sshpass -p 478V6S6436T8 ssh -o StrictHostKeyChecking=no ${dest} '/var/tmp/change_pass_server.sh'
done

echo "FIN Del Script"
