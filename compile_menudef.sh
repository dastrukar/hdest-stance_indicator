#!/usr/bin/bash

# Put some handy variables
IFS=$'\n'
start=0
dontspace=0

text_start='	StaticText "'
text_end='", "white"\n'
h3_end='", "gold"\n'
h2_start='	StaticText "= '
h2_end=' =", "cyan"\n'
blank='	StaticText " ", "white"\n'

result=""
result+='OptionMenu "HDSINFO" {\n'
result+='	Title "Stance Indicator Info"\n\n'
result+='	SafeCommand "Reset all CVars to default", "hdstance_resetallcvars"\n\n'
result+=${blank}

echo "Compiling menudef.txt..."
# Read the contents of readme.md
for s in $(cat ./readme.md)
do
	# Only start parsing after ---
	if [[ ${start} == "0" ]]
	then
		if [[ ${s} == "---" ]]
		then
			start=1
		fi
		continue
	fi

	# Get the heading
	heading=${s:0:3}
	if [[ ${heading} == "###" ]]
	then
		if [[ ${dontspace} == "0" ]]
		then
			result+=${blank}
		fi

		result+=${text_start}
		result+=${s:4}
		result+=${h3_end}
		dontspace=1
	elif [[ ${heading} == "## " ]]
	then
		result+=${blank}
		result+=${h2_start}
		result+=${s:3}
		result+=${h2_end}
		dontspace=0
	elif [[ ${heading} == '```' ]]
	then
		continue
	else
		result+=${text_start}
		result+=${s}
		result+=${text_end}
		dontspace=0
	fi
done

# Add the rest
result+='}\n\n'
result+='AddOptionMenu "OptionsMenu" {\n'
result+='	Submenu "Stance Indicator Info", "HDSINFO"\n'
result+='}'
echo -e $result > menudef.txt
echo "All done!"

unset IFS
