#!/bin/bash
#
# Script de Instalacion de Los Servicios Marcadores para APL
# Creado por la Unidad de Infraestructura TI y Backend
##
# Create by: Jonathan Melendez & Julio Guzman
# 
# Created Date= 07/07/2016
#
#
# Updates:
#
#
# Start Installer
PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

# Limpio la pantalla
clear

#Validacion de root
if [ $(id -u) -eq 0 ]; then


echo "Indique el ambiente en donde se va a instalar (desarrollo/calidad/produccion)?"
read ambiente
if [ "$ambiente" == "" ]; then 
	clear
	echo "El ambiente no puede estar vacio, intenta de nuevo!!!"
	echo -e "\n"
	exit 1
fi

case $ambiente  in

"desarrollo" )
	cantv_route="/dcantv"	
;;
"calidad" )
	cantv_route="/tcantv"
;;
"produccion")
	cantv_route="/pcantv"
;;
*)
	echo "Debe Especificar un ambiente valido (desarrollo/calidad/produccion), el instalador se cerrara"
	exit 2
;;
esac

tput cup 1 18 ; echo -n "***********************************************"
tput cup 2 18 ; echo -n "INSTALANDO SERVICIO FILES_DISTRIBUTOR PARA APL"
tput cup 3 18 ; echo -n "***********************************************"
echo ""
sleep 5
mkdir -p $cantv_route/logs/marcadores/
cp src/file_distributor /etc/init.d/
cp src/file_distributorlogrotate /etc/logrotate.d/file_distributor
chmod +x /etc/init.d/file_distributor
sed -r -i -e '54s/CANTVRUTA/'$cantv_route'/g' /etc/init.d/file_distributor
sed -r -i -e '1s/CANTVRUTA/'$cantv_route'/g' /etc/logrotate.d/file_distributor
logrotate -vf /etc/logrotate.conf
update-rc.d file_distributor defaults
update-rc.d file_distributor enable
else 
	echo "La instalacion de este script debe ser realizada unicamente por root"
	exit 2
fi

echo "Instalacion finalizada con EXITO, gracias utilizar el script"
