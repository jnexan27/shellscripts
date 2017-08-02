#!/bin/bash

serviciosstart=(
'neutron-server neutron-dhcp-agent neutron-metadata-server'
'nova-server nova-api nova-compute'
'keystone-server'
'glance-api glance-scheduller'
)

serviciosstop=(
'neutron-metadata-server neutron-dhcp-agent neutron-server'
'nova-compute nova-api nova-server'
'keystone-server'
'glance-scheduller glance-api'
)

#
# Con esto modificamos la lista de servicios para casos como compute, etc.
#
if [ ! -z $3 ]
then
	if [ $3 == "compute" ]
	then
        	serviciosstart[1]='nova-compute'
        	serviciosstop[1]='nova-compute'
	fi
fi


moduleliststart='0 1 2 3'
moduleliststop='3 2 1 0'

#
# En este caso, si usamos $2 para especificar un servicio, modicamos las variables
# moduleliststart y moduleliststop
case $2 in
neutron)
	moduleliststart='0'
	moduleliststop='0'
	;;
nova)
        moduleliststart='1'
        moduleliststop='1'
	;;
glance)
        moduleliststart='2'
        moduleliststop='2'
	;;
keystone)
        moduleliststart='3'
        moduleliststop='3'
	;;
esac

start(){
	for module in $moduleliststart
	do
		for i in ${serviciosstart[$module]}
		do
			echo "Starting Servicio $i"
		done
	done
}

stop(){
        for module in $moduleliststop
        do
                for i in ${serviciosstop[$module]}
                do
                        echo "Stopping Servicio $i"
                done
        done	
}

case $1 in
start)
	start
	;;
stop)
	stop
	;;
restart)
	stop
	start
	;;
esac
