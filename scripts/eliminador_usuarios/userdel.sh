#!/bin/bash
#
#

for dest in $(<usuarios.txt); do
	userdel -r ${dest} 
done
