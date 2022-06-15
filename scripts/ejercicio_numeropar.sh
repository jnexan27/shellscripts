#!/bin/bash
read -p "Introduce un numero:" NUM
RESTO=$(($NUM%2))
if [ $RESTO -eq 0 ]; then
	echo "el numero es par"
else
	echo "el numero es impar"
fi
