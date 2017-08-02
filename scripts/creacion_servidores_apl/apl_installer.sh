#!/bin/bash
# Script Para la Instalacion de Servicios de APL GYSMO 1.8 
# Creado por Infraestructura TI:
#
#	Jonathan Melendez 	- Analista de Servidores.
#
# Fecha de Inicio: 27 de Julio de 2015
#
# Fecha de Entrega: 
#
# Build: 2701201600
# Actualizaciones:
#	
#
#
#Comienzo del Script:
##############################################################

PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

# Limpio la pantalla
clear
# Declaro Variables
build="2701201602"
DATE=$(date +%Y-%m-%d)
install_directory=`pwd`
internalip=$(hostname -I)
opensslishere=`which openssl|wc -l`

if [ $opensslishere == 0 ]
then
	aptitude -y update
	aptitude -y install openssl
fi

if [ $(id -u) -eq 0 ]; then

	if [ -f ./configs/main-config.rc ]
	then
		source ./configs/main-config.rc
	else
		echo "No puedo acceder a mi archivo de configuración"
		echo "Revise que esté ejecutando el instalador en su directorio"
		echo "Abortando !!!!."
		echo ""
		exit 0
	fi

	echo ""
	echo "INSTALADOR DE SERVICIOS PARA SERVIDOR APL GYSMO 1.8"
	echo "Realizado por Jonathan Melendez"
	echo "E-Mail: jmelendez@gysmo.co"
	echo "Versión 0.1.1 | Build $build"
	echo ""
	echo "Se verificaran los prerequisitos"
	echo "Si no cumples algun prerequisito, aborta la instalacion."
	echo ""
	echo "Prerequisitos:"
	echo "- OS: Debian 7 Wheezy"
	echo "- El usuario que ejecuta este script debe ser root"
	echo "- Todos los repositorios deben estar disponibles para instalar los paquetes via apt"
	echo "- Debes especificar todos los parametros en el main-config.rc"
	echo "- El servidor debe tener todas las actualizaciones al día"
	echo "- Se requiere que el servidor tenga acceso sin restricciones a la QNAP o NAS en la cual se guardaran sus recursos"
	echo "- Repito, TIENE QUE SER ROOT el que ejecute el script."
	echo ""
	echo "IMPORTANTE: Esta instalacion NO INCLUYE el Balanceo via haproxy o Capa 4 ni despliegue en la NAS - QNAP"
	echo ""
	echo "Si cumples todo esto pulsa Y para continuar y que la fuerza este contigo"

echo -n "Desea continuar ? [y/n]:"
read -n 1 answer
echo ""
		case $answer in
		y|Y)
			echo ""
			echo "Iniciando el Despliegue"
			tput cup 1 18 ; echo -n "*******************************************"
			tput cup 2 18 ; echo -n "INSTALADOR DE DEPENDENCIAS PARA ESTE SCRIPT"
			tput cup 3 18 ; echo -n "*******************************************"
			echo ""
			aptitude update
			aptitude install -y apache2 php5 php5-ldap php5-mysql php5-pgsql
			sleep 5
			echo "#########################################################################"
			echo "#Instalacion de dependencias finalizada con exito... por favor espere...#"
			echo "#########################################################################"
			sleep 5
			echo ""
			tput cup 1 18 ; echo -n "***********************************"
			tput cup 2 18 ; echo -n "INSTALADOR DE NODEJS VERSION 0.12.0"
			tput cup 3 18 ; echo -n "***********************************"
			sleep 5
			echo ""
			cd /usr/src/
			git clone ssh://git@172.16.10.121/infraestructura/node-install/node-js-install.git
			cd node-js-install/
			./install_node.sh
			sleep 5
			echo "###################################################################"
			echo "#Instalacion de nodejs finalizada con exito... por favor espere...#"
			echo "###################################################################"
			sleep 5
			echo ""
			tput cup 1 18 ; echo -n "************************************"
			tput cup 2 18 ; echo -n "INICIANDO DESPLIEGUE DE CARPETAS NFS"
			tput cup 3 18 ; echo -n "************************************"
			sleep 5
			echo ""
			cd /
			mkdir -p /mnt/campaign-$servicio
			mkdir -p /mnt/telefonia-$servicio
			echo "Montando recurso NFS"
			echo "#Punto de Montura para Servidor APL" >> /etc/fstab
			echo "$IPNFSCAMPAING:$RUTANFSCAMPAING	/mnt/campaign-$servicio	nfs	rw,hard,intr,timeo=90,bg,vers=3,proto=tcp,rsize=32768,wsize=32768       0 0" >> /etc/fstab
			echo "#Punto de Montura para de Telefonia" >> /etc/fstab
			echo "$IPNFSTELEFONIA:$RUTANFSTELEFONIA	/mnt/telefonia-$servicio nfs	rw,hard,intr,timeo=90,bg,vers=3,proto=tcp,rsize=32768,wsize=32768       0 0" >> /etc/fstab
			mount -a
			echo "Mostrando File System por 10 segundos..."
			df -h
			sleep 10
			echo "########################################################################"
			echo "#Despliegue de Carpetas NFS finalizado con exito... por favor espere...#"
			echo "########################################################################"
			sleep 5
			echo ""
			tput cup 1 18 ; echo -n "****************************************************"
			tput cup 2 18 ; echo -n "INICIANDO DESPLIEGUE DE CRONTABS PARA SINCRONIZACION"
			tput cup 3 18 ; echo -n "****************************************************"
			echo ""
			mkdir -p /var/log/gysmo-sincro
			echo "SHELL=/bin/bash" >> /etc/cron.d/sincro-gysmoapl-crontab
			echo "PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin" >> /etc/cron.d/sincro-gysmoapl-crontab
			echo "#Crontab implementado por: Infraestructura TI" >> /etc/cron.d/sincro-gysmoapl-crontab
			echo "#Generado el $DATE automaticamente por APL Installer of Infraestructure Build: $build" >> /etc/cron.d/sincro-gysmoapl-crontab
			echo "$servicio Servicios" >> /etc/cron.d/sincro-gysmoapl-crontab
			echo "" >> /etc/cron.d/sincro-gysmoapl-crontab
			echo "00 6 * * *  root        /usr/bin/php -f /var/www/$servicio/script/insert16.php $servicio > /var/log/gysmo-sincro/sincro-insert-$servicio-lastresult.log 2>&1" >> /etc/cron.d/sincro-gysmoapl-crontab
			echo "00 6 * * *  root        /usr/bin/php -f /var/www/$servicio/script/update16.php $servicio > /var/log/gysmo-sincro/sincro-update-$servicio-lastresult.log 2>&1" >> /etc/cron.d/sincro-gysmoapl-crontab
			echo "00 18 * * * root        /usr/bin/php -f /var/www/$servicio/script/insert16.php $servicio > /var/log/gysmo-sincro/sincro-insert-$servicio-lastresult.log 2>&1" >> /etc/cron.d/sincro-gysmoapl-crontab
			echo "00 18 * * * root        /usr/bin/php -f /var/www/$servicio/script/update16.php $servicio > /var/log/gysmo-sincro/sincro-update-$servicio-lastresult.log 2>&1" >> /etc/cron.d/sincro-gysmoapl-crontab
			echo "30 23 * * * root        /usr/bin/php -f /var/www/$servicio/script/calculate_survey_cron.php $servicio > /var/log/gysmo-sincro/calculate_survey-$servicio-lastresult.log 2>&1" >> /etc/cron.d/sincro-gysmoapl-crontab
			echo "*/30 * * * * root       /usr/bin/php -f /var/www/$servicio/script/rotation_survey_hour.php $servicio > /var/log/gysmo-sincro/rotation _survey-$servicio-lastresult.log 2>&1" >> /etc/cron.d/sincro-gysmoapl-crontab
			sleep 5
			echo "####################################################################################"
			echo "#Despliegue de CRON para sincronizacion finalizado con exito... por favor espere...#"
			echo "####################################################################################"
			sleep 5
			tput cup 1 18 ; echo -n "*******************************************"
			tput cup 2 18 ; echo -n "INSTALANDO SERVICIO DOWNLOAD_FILES PARA APL"
			tput cup 3 18 ; echo -n "*******************************************"
			echo ""
			sleep 5
			cd $install_directory
			cp src/download_files /etc/init.d/
			chmod +x /etc/init.d/download_files
			update-rc.d download_files defaults
			update-rc.d download_files enable
			echo "OJO: El script se instalo, recuerda al momento de ejecutarlo sea de la siguiente manera:"
			echo ""
			echo "/etc/init.d/download_files start|stop|status|restart $servicio"
			sleep 5
			echo "#####################################################################################"
			echo "#Instalacion del Servicio Download_Files finalizada con exito... por favor espere...#"
			echo "#####################################################################################"
			sleep 5
			tput cup 1 18 ; echo -n "**********************************************"
			tput cup 2 18 ; echo -n "CREANDO USUARIO DESARROLLO PARA GESTION DE APL"
			tput cup 3 18 ; echo -n "**********************************************"
			echo ""
			sleep 5
			echo "Creando el Usuario..."
			useradd -m desarrollo -s/bin/bash
			passwordf=`openssl rand -hex 10`
			echo "desarrollo:$passwordf" | chpasswd
			history -c
			passwd -e desarrollo
			passwd -x 45 desarrollo
			echo "Creando el Grupo..."
			groupadd desarrollo
			usermod -a -G desarrollo desarrollo
			echo "Tu cuenta fue creada con EXITO."
			echo "Los datos son los siguientes (OJO-LEER):"
			echo "***********************************************"
			echo -e "\n"
			echo "IP del Servidor: $internalip"
			echo "Nombre del usuario: desarrollo"
			echo "Grupo Seleccionado: desarrollo"
			echo "Contraseña: $passwordf"
			echo -e "\n"
			echo "El Password es Aleatorio te pedira cambiarlo"
			echo "durante el primer login"
			echo "-----------------------------------------------"
			echo "Dale enter para continuar.......... "
			echo "OJO REPITO: Copia la contraseña (no la veras mas)."
			echo "-----------------------------------------------"
			echo "Pulsa enter para continuar...."
			read
			tput cup 1 18 ; echo -n "********************************************"
			tput cup 2 18 ; echo -n "ASIGNANDO PERMISOLOGIAS A USUARIO DESARROLLO"
			tput cup 3 18 ; echo -n "********************************************"
			sleep 5
			echo "Cmnd_Alias      DESA =  /bin/ls /var/log/httpd/*, /bin/less /var/log/httpd/*, /bin/ls /var/log/*, /bin/less /var/log/maillog*, /usr/bin/git*, /usr/bin/less /var/log/apache2/*, /usr/bin/tail -* /var/log/apache2/*, /bin/rm -*, /bin/mv /var/www/* /var/www/*, /bin/sh /etc/gysmo_update_prod/*, /etc/init.d/node-cti*, /bin/ln -*, /bin/less /var/log/gysmo-sincro/*, /etc/init.d/node-chat *, /etc/init.d/node-cti *, /bin/ls /var/log/node-gysmo/*, /bin/less /var/log/node-gysmo/*, /usr/bin/tail -* /var/log/node-gysmo/*" >> /etc/sudoers.d/desarrollo
			echo "%desarrollo       ALL=(ALL)       NOPASSWD: DESA" >> /etc/sudoers.d/desarrollo
			chmod 0440 /etc/sudoers.d/desarrollo
			service sudo restart
			sleep 5
			echo "####################################################################"
			echo "#Usuario y Permisologias asignadas con exito... por favor espere...#"
			echo "####################################################################"
			sleep 5

			;;
		*)
			echo ""
			echo "Abortando a petición del usuario/admin !!!"
			echo ""
			exit 0
			;;
		esac
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
