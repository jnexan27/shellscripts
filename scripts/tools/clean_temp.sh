#!/bin/bash

# Script de Limpieza de Temporales 
# Creado por Infraestructura TI
#
#	Jonathan Melendez - Analista de Servidores
#
# Fecha: 19 de Noviembre de 2015
# 
# Comentarios:
#	Este script elimina todo el contenido de la carpeta /tmp/ a las 11:30 pm
#
#Comienzo del Script:
PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin


cd /tmp/
rm -rf *.wav
rm -rf *.xls


