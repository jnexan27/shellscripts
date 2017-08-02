#!/bin/bash

listgroup=`getent group | egrep '1[0-9][0-9][0-9]' | cut -d: -f1 | sort`

for grupos in $listgroup 
do
	echo "1) Grupo Disponible: $grupos"
done

