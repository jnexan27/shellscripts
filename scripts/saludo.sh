#!/bin/bash
###################################################################################
# Copyright  2005-2015 Sergio González Durán (sergio.gonzalez.duran@gmail.com)
# Se concede permiso para copiar, distribuir y/o modificar este programa siempre 
# y cuando se cite al autor y la fuente de linuxtotal.com.mx y según los términos 
# de la GNU General Public License, Versión 3 o cualquiera
# posterior publicada por la Free Software Foundation.
####################################################################################

# archivos de figuras de cowsay en un arreglo
vacas=(`ls /usr/share/cowsay/cows/`)

# total de figuras encontradas (elementos en el arreglo)
TVACAS=${#vacas[*]}

# selecciona un numero al azar entre 0 y TVACAS
NVACA=$((RANDOM%$TVACAS))

# nombre del archivo cowsay a utilizar
vaca=${vacas[$NVACA]}

# forma el saludo con fortune y cowsay
fortune | cowsay -f $vaca
