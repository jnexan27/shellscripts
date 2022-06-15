#!/bin/bash
read -p "Introduce un numero: " NUM
CONT=1;
while [ $NUM -ne $$ ]; do
	if [ $NUM -gt $$ ]; then
		echo $NUM es MAYOR que el PID
	else
		echo $NUM es MENOR que el PID
	fi
	read -p "Introduce otro numero: " NUM
	CONT=$(($CONT+1))
done
echo "Has necesitado $CONT intentos para adivinar el PID $$"
