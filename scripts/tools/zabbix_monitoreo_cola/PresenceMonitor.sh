#!/bin/bash
#
# Script de Verificacion de Servicio PresenceMonitor 
# Creado: 25/06/2015
# Desarrollado por la Coordinacion de Arquitectura Tecnologica
#	Jonathan Melendez - Analista de Servidores
#
# Comentarios: Ejecutar solo en Servidores ACD que corran la Cola.

PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

ps -ef|grep com.gysmo.callcenter.PresenceMonitor|grep -v grep|wc -l
