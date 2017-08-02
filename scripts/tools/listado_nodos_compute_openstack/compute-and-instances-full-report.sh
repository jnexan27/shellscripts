#!/bin/bash
#
# Lista los Hypervisors disponibles y sus instancias
#

PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

mykeystonefile="/root/keystonerc_admin"

#
# Primero hacemos source del environment file de OpenStack para poder
# conectarnos a Nova:
#

source $mykeystonefile

# hypervisorlist=`nova hypervisor-list|grep cloud0|awk '{print $4}'|cut -d. -f1`
hypervisorlist=`nova hypervisor-list|grep \||grep -v ID|awk '{print $4}'|cut -d. -f1`

for compute in $hypervisorlist
do
	echo ""
	echo ""
	echo "NODO DE COMPUTE: $compute"
	echo ""
	nova list --host $compute
	echo ""
done
