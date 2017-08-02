#!/bin/bash
#
# Script de Verificacion de transfer.sh en /mnt/asterisk01/llamadas/
# Creado: 03/09/2015
# Desarrollado por la Coordinacion de Arquitectura Tecnologica
#	Jonathan Melendez - Analista de Servidores
#
# Comentarios: Ejecutar solo en Servidores ACD JAZZTEL

PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

grep -c 1 /tmp/jazztel_transferencia.log
