#!/bin/bash
#
#
#
#
#

echo -e "\n"
	echo "Ingrese el Nombre de Usuario: " 
	read username
		if [ "$username" = ""  ]
     		then
         	echo "El usuario no puede ser vacio"
			exit 0
		fi
	echo "Creando el Usuario..."
	useradd -m $username -s/bin/bash
	#Generando Password encripatada. 
	passwordf=`openssl rand -hex 10`
	echo "Asignando Clave Aleatoria..."
	echo "$username:$passwordf" | chpasswd
	echo "Clave Asignada con ¡Exito!..."
	#Se solicitara cambio de clave en el primer inicio
	passwd -e $username
	#Captando IP del Servidor
	internalip=$(hostname -I)
	#Forza el cambio de contraseña a los 15 dias
	passwd -x 15 $username
	echo "El usuario $username fue creado con exito"

	# Limpio la pantalla
	clear
	# Hago un resumen de los datos ingresados
	echo "Tu cuenta fue creada con EXITO."
	echo "Los datos son los siguientes (OJO-LEER):"
	echo "***********************************************"
	echo -e "\n"
	echo "IP del Servidor: $internalip"
	echo "Nombre del usuario: $username"
	echo "Contraseña (COPIALA): $passwordf"
	echo -e "\n"
	echo "El Password es Aleatorio te pedira cambiarlo"
	echo "una vez hagas el primer login"
	echo "-----------------------------------------------"
	echo "Dale enter para continuar.......... "
	echo "OJO REPITO: Copia la contraseña (no la veras mas)."
	echo "-----------------------------------------------"
	echo "Pulsa enter y seras enviado al Menu de Permisos de Grupos."

read


