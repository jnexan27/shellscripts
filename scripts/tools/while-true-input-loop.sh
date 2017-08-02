#!/bin/bash
#

# The variable is expected to be answered with "y" or "no"... so we must
# preload the answer variable with anything diferent to y or no:
var="j"

# Main loop
# Until you choose "y" or "no", you will be unable to exit the input loop
#
while [ $var != "y" ]&&[ $var != "n" ]
do
	echo -n "Please answer with \"y\" or \"n\": "
	read -n 1 var
	if [ -z $var ]
	then
		var="j"
	fi
	echo ""
done
#
# Anytime you answer the right expected string (y or no) the loop ends and
# the variable gets filled with what yoy had choosen

echo "Your answer was: $var"
