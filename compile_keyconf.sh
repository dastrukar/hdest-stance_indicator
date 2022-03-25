#!/usr/bin/bash

# i am not about to type out a shit ton' of "resetcvar"s just for every new cvar i add

# Good variables
IFS=$'\n'
result='alias hdstance_resetallcvars "'

echo "Compiling keyconf.txt..."

# Get lines
for s in $(cat cvarinfo.txt)
do
	IFS=' ='$'\n'
	count=""
	pass="n"

	# Get words in current line
	for w in ${s}
	do
		# Ignore comments
		if [[ ${w:0:2} == "//" ]]
		then
			break
		fi

		# Add the third word (which is the cvar name)
		if [[ ${count} == "xx" ]]
		then
			result+="resetcvar ${w}; "
			break
		else
			count+="x"
		fi
	done

	# Just in case
	IFS=$'\n'
done

result+='"'

echo ${result} > keyconf.txt
echo "All done!"

unset IFS
