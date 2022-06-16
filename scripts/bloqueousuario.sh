#!/bin/bash
for USER in $(cut -d":" -f1 /etc/passwd); do
	DIR=$(grep ^$USER: /etc/passwd | cut -d":" -f5)
	if [ -d "$DIR" ]; then
		TAM=$(du -sm $DIR 2> /dev/null | cut -f1 )
		echo $DIR ocupa $TAM
	fi
done
