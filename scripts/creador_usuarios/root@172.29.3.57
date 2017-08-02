#!/bin/bash
# Script Para Creacion de Usuarios y diferenciacion de Roles en Grupos. 
# Creado por el Departamento de Infraestructura de Tecnologias de Informacion
#
#	Jonathan Alexander Melendez Duran - Analista de Servidores | GYSMO Corp.
#
#
# Fecha de Inicio: 29 de Febrero de 2016
#
# Fecha de Entrega: 21 de Julio de 2015
#Comienzo del Script:

PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

clear
if [ $(id -u) -eq 0 ]; then
tput cup 1 18 ; echo -n "*********************************************"
tput cup 2 18 ; echo -n "*INSTALADOR DE DEPENDENCIAS PARA ESTE SCRIPT*"
tput cup 3 18 ; echo -n "*********************************************"
# Determinando el Sistema Operativo de este Servidor
OSFlavor='unknown'

if [ -f /etc/redhat-release ]
then
        OSFlavor='redhat-based'
fi

if [ -f /etc/centos-release ]
then
	OSFlavor='centos-based'
fi

if [ -f /etc/debian_version ]
then
        OSFlavor='debian-based'
fi
echo -e "\n"
echo "El Sistema Operativo de este Servidor es: $OSFlavor"

if [ $OSFlavor == "unknown" ]
then 
	echo "Sistema Operativo NO SOPORTADO. Abortando el script"
	exit 0
fi

#Validando segun el S.O para realizar la instalacion de los paquetes.

sudoishere=`which sudo|wc -l`
opensslishere=`which openssl|wc -l`

case $OSFlavor in

	redhat-based|centos-based)
		echo -e "\n"
		echo "Instalando Dependencias Requeridas para Centos/RHEL"
		if [ $sudoishere == 0 ]
		then
		yum -y install sudo
		fi
		if [ $opensslishere == 0 ]
		then
		yum -y install openssl
		fi
	;;
	debian-based)
		echo -e "\n"
		echo "Instalando Dependencias Requeridas para Debian"
		# aptitude update
		# aptitude install sudo openssl
		if [ $sudoishere == 0 ]
		then
			aptitude -y update
			aptitude -y install sudo
		fi
		if [ $opensslishere == 0 ]
		then
			aptitude -y update
			aptitude -y install openssl
		fi
	;;
esac
# Limpio la pantalla
clear
tput cup 1 18 ; echo -n "************************************************************"
tput cup 2 18 ; echo -n "*MENU DE CREACION DE USUARIOS | INFRAESTRUCTURA TECNOLOGICA*"
tput cup 3 18 ; echo -n "************************************************************"

#Funcion que verifica los grupos, de no existir los crea.
function verGrupo(){
     grupo=$2
     username=$1
     existe=0
     var=`getent group | grep $grupo | cut -d: -f1`
     for i in $var
     do
         if [ "$i" = "$grupo" ]; then
             existe=1
         else
             existe=0
         fi
     done
     if [ "$existe" -eq 0 ]
     then
         groupadd $grupo
         usermod -a -G $grupo $username
         echo "Se crea el grupo $grupo y se le agrega a el usuario $username"
     else
        echo "El grupo $grupo ya existe, añadiendo a $username"
	usermod -a -G $grupo $username
     fi
}
#Fin de la Funcion que verifica los grupos

echo -e "\n"
echo "Ingrese el Nombre de Usuario: " 
read username
	if [ "$username" = ""  ]
  		then
       	echo "El usuario no puede ser vacio"
       	exit 0
		fi

listgroup=`getent group | egrep '1[0-9][0-9][0-9]' | cut -d: -f1 | sort`
echo "Grupos disponibles en este servidor:"
echo "$listgroup"
echo ""
echo "Ingrese el nombre del grupo donde deseas crear el usuario (si no existe, lo creara):"
read grupo
	if [ "$grupo" = ""  ]
	then
 		echo "El nombre de grupo no puede ser vacio"
	exit 0
	fi

#Generando Clave Hexadecimal con openssl y mostrando IP del servidor
passwordf=`openssl rand -hex 10`
internalip=$(hostname -I)
clear
	echo "A continuacion se muestra como quedara tu cuenta"
	echo "Los datos son los siguientes:"
	echo "***********************************************"
	echo -e "\n"
	echo "IP del Servidor: $internalip"
	echo "Nombre del usuario: $username"
	echo "Grupo Seleccionado: $grupo"
	echo "Contraseña: $passwordf"
	echo -e "\n"
	echo "El Password es Aleatorio te pedira cambiarlo"
	echo "una vez hagas el primer login"
	echo "-----------------------------------------------"
	echo "Dale enter para continuar.......... "
	echo "OJO REPITO: Copia la contraseña (no la veras mas)."
	echo "-----------------------------------------------"
	echo "Pulsa enter si estas de acuerdo para crear tu cuenta."
read
#Creacion de Cuenta
useradd -m $username -s/bin/bash
echo "$username:$passwordf" | chpasswd
history -c
passwd -e $username
passwd -x 45 $username
verGrupo $username $grupo
echo "Cuenta Creada con EXITO"
sleep 3
echo "Validando permisos del usuario..."
sleep 5

GroupExist='unknown1'
listadogrupos='full medio bajo'

for g in $listadogrupos
do
	if [ -f /etc/sudoers.d/$g  ]
	then
		GroupHere=`grep -c "^%$grupo" /etc/sudoers.d/$g`
		if [ $GroupHere == 1 ]
		then
			GroupExist=`cat /etc/sudoers.d/$g | grep $grupo | awk '{print $1}' | cut -d'%' -f2`
		fi
	fi
done

if [[ $grupo == $GroupExist ]]
then 
	echo "El Grupo $grupo ya existia (antes de crear al usuario $username)."
	echo "Adicionalmente este grupo ya cuenta con su respectiva persologia asignada."
	echo "Saliendo del Script en 5 segs... Gracias por utilizarlo."
	sleep 5
	exit 0
fi
clear
tput cup 1 18 ; echo -n "*********************************************************************"
tput cup 2 18 ; echo -n "*MENU DE GESTION DE PERMISOS DE GRUPOS | INFRAESTRUCTURA TECNOLOGICA*"
tput cup 3 18 ; echo -n "*********************************************************************"

echo -e "\n"
echo "ATENCION:"
echo "****************************************************************************"
echo "En este menu podras asignar los permisos que requieras para el grupo $grupo."
echo "****************************************************************************"
permissionlevel="sindato"
	while [ $permissionlevel != "1" ]&&[ $permissionlevel != "2" ]&&[ $permissionlevel != "3" ]&&[ $permissionlevel != "4" ]
	do
			read -r -p "Indique el Nivel de Permisologia que estableceras al grupo $grupo siendo: 1) ADMINISTRADORES, 2) FULLSTACK, 3) CALIDAD: " permissionlevel
				case $permissionlevel in

				1)
					echo "Usted Selecciono el nivel de Permisologia FULL"
					echo "%$grupo       ALL=(ALL)       NOPASSWD:ALL, !/usr/bin/passwd, !/usr/bin/su" >> /etc/sudoers.d/full
					chmod 0440 /etc/sudoers.d/full
					echo "Acceso FULL Otorgado satisfactoriamente al grupo $grupo, saliendo del script en 5 segs..."
					sleep 5
					exit 0	
				;;
				2)	
					echo "***************************************************"
					echo "Usted Selecciono el nivel de Permisologia FULLSTACK"
					echo "***************************************************"
					roles="notdata"
						while [ $roles != "1" ]&&[ $roles != "2" ]&&[ $roles != "3" ]&&[ $roles != "4" ]
						do
							read -r -p "Indique el nivel de permisos que desea para el grupo $grupo siendo 1) DESARROLLO, 2) TELEFONIA, 3) BASE DE DATOS 4) SOPORTE: " roles
								case $roles in
								
								1)
									echo "Cmnd_Alias DESA = /etc/init.d/apache2*, /bin/sh, /usr/bin/tail*, /var/log/cron*, /bin/nano, /usr/bin/vi, /usr/bin/aptitude*, /usr/bin/apt-get*, /usr/bin/pip, /usr/bin/python, /usr/bin/easy_install, /usr/sbin/sendmail" >> /etc/sudoers.d/medio
									echo "%$grupo       ALL=(ALL)       NOPASSWD: DESA" >> /etc/sudoers.d/medio
									chmod 0440 /etc/sudoers.d/medio
									echo "Acceso MEDIO con nivel DESARROLLO Otorgado satisfactoriamente al grupo $grupo, saliendo del script en 5 segs..."
									sleep 5
									exit 0
								;;
								2)
									echo "Cmnd_Alias TELF = /etc/init.d/mysqld*, /bin/sh, /usr/bin/tail*, /var/log/messages*, /var/log/cron*, /bin/nano, /bin/vi, /usr/bin/aptitude*, /usr/bin/apt-get*, /usr/bin/make*, /bin/chown*, /bin/chmod*, /etc/init.d/asterisk*, /etc/init.d/snmpd*, /bin/cp*, /bin/mv*, /bin/ln*, /bin/rm*, /usr/sbin/update-alternatives*, /bin/mkdir*, /usr/bin/touch *, /etc/init.d/monit *" >> /etc/sudoers.d/medio
									echo "%$grupo       ALL=(ALL)       NOPASSWD: TELF" >> /etc/sudoers.d/medio
									chmod 0440 /etc/sudoers.d/medio
									echo "Acceso MEDIO con nivel TELEFONIA Otorgado satisfactoriamente al grupo $grupo, saliendo del script en 5 segs..."
									sleep 5
									exit 0
								;;
								3)
									echo "Cmnd_Alias DBA = /etc/init.d/mysqld*, /bin/sh, /usr/bin/tail*, /var/log/messages*, /var/log/cron*, /bin/nano, /bin/vi" >> /etc/sudoers.d/medio
									echo "%$grupo	ALL=(ALL) 	NOPASSWD: DBA" >> /etc/sudoers.d/medio
									chmod 0440 /etc/sudoers.d/medio
									echo "Acceso MEDIO con nivel BASE DE DATOS Otorgado satisfactoriamente al grupo $grupo, saliendo del script en 5 segs..."
									sleep 5
									exit 0
								;;
								4)
									echo "Usted Selecciono el nivel de Permisologia FULL"
									echo "%$grupo       ALL=(ALL)       NOPASSWD:ALL, !/usr/bin/passwd, !/usr/bin/su" >> /etc/sudoers.d/soporte
									chmod 0440 /etc/sudoers.d/soporte
									echo "Acceso FULL Otorgado satisfactoriamente al grupo $grupo, saliendo del script en 5 segs..."
									sleep 5
									exit 0	
								esac
							roles=`echo $roles|cut -d" " -f1`
							if [ -z $roles ]
							then 
								roles="notdata"
							fi
							echo ""
						done
				;;
				3)
					echo "Usted Selecciono el nivel de Permisologia BAJO"
					echo "Cmnd_Alias      BAJO =  /bin/ls /var/log/httpd/*, /bin/less /var/log/httpd/*, /bin/ls /var/log/*, /bin/less /var/log/maillog*, /usr/bin/less /var/log/*" >> /etc/sudoers.d/bajo
					echo "%$grupo       ALL=(ALL)       NOPASSWD: BAJO" >> /etc/sudoers.d/bajo
					chmod 0440 /etc/sudoers.d/bajo
					echo "Acceso BAJO Otorgado satisfactoriamente al grupo $grupo, saliendo del script en 5 segs..."
					sleep 5
					exit 0
				;;
			esac
		permissionlevel=`echo $permissionlevel|cut -d" " -f1`
		if [ -z $permissionlevel ]
		then
			permissionlevel="sindato"
		fi
		echo ""
	done

else
	clear
	echo -e "\n"
tput cup 1 18 ; echo -n "*************************************************************************************"
tput cup 2 18 ; echo -n "HOUSTON TENEMOS UN PROBLEMA, EL SCRIPT SE EJECUTA UNICAMENTE COMO ROOT (NO USAR SUDO)"
tput cup 3 18 ; echo -n "*************************************************************************************"
	echo -e "\n"
	echo -e "\n"
	exit 2
fi