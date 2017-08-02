#!/bin/bash 
# Script para cambio de claves en Todos los Servidores de la Nube
# Creado por Infraestructura TI:
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
# Paso 1: Ejecuta via ssh con el identify file SSH openstack-infra el cambio de clave en el listado de servidores
# Paso 2: Enjoy!-
#
# Observaciones:
#	Este script NO depende de root para funcionar
#Se debe ejecutar unicamente en los workstation NUNCA EN LOS SERVIDORES DIRECTAMENTE
#*******************NO NECESITA ROOT******************************
#*******EJECUTALO DESDE EL WORKSTATION DE INFRAESTRUCTURA NUNCA DESDE UN SERVIDOR*************
#
#
# Actualizaciones:
#	
#	
#	02/02/2016= Reduccion de lineas de codigo y optimizacion de parametros
#
#Comienzo del Script

echo "Ejecutando sentencias en Servidores..." 
for dest in $(<servidores.txt); do
	ssh -i /home/jmelendez/.ssh/openstack/openstack-infra -o StrictHostKeyChecking=no root@${dest} "echo "root:478V6S6436T8" | chpasswd"
	ssh -i /home/jmelendez/.ssh/openstack/openstack-infra -o StrictHostKeyChecking=no root@${dest} "history -c"
	echo "Termine con el Servidor $dest"
done

echo "FIN Del Script"
