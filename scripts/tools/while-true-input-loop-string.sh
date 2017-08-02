#!/bin/bash
#

# The variable is expected to be answered with an specific string... so we must
# preload the answer variable with anything diferent to the string or strings we expect:
var="ninguno"

#
# Our expected strings can be (in lowercase or capital): medio, bajo and full
# Meanwhile we don't put in the input read the proper string, we are jailed to the loop
#
while [ $var != "FULL" ]&&[ $var != "MEDIO" ]&&[ $var != "BAJO" ]&&[ $var != "full" ]&&[ $var != "medio" ]&&[ $var != "bajo" ]
do
	echo -n "Please answer with \"FULL\",  \"MEDIO\" or \"BAJO\": "
	# here we read our input
	read var
	# if the user used an space, we can break our loop so we use cut to filter out any possible space
	var=`echo $var|cut -d" " -f1`
	# also, if our dear user pressed just an enter, we verify our string, and if empty, we fill it
	# with anything different to our expected input "full, medio, etc."
	if [ -z $var ]
	then
		var="ninguno"
	fi
	echo ""
done
#
# Anytime you answer the right expected string the loop ends and
# the variable gets filled with what yoy had choosen

echo "Your answer was: $var"
