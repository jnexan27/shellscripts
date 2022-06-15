#! /bin/bash
read -p "Introduce tu año de nacimiento: " YEAR
read -p "Introduce tu mes de nacimiento: " MES
read -p "Introduce tu dia de nacimiento: " DIA
EDAD=$(($(date +%Y)-$YEAR))
if [ $(date +%m) -lt $MES ]; then
	EDAD=$(($EDAD-1))
elif [ $(date +%m) -eq $MES -a $(date +%d) -lt $DIA ]; then
	EDAD=$(($EDAD-1))
fi
echo tienes $EDAD años


