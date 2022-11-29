#!/usr/bin/bash

# Put some handy variables
IFS=$'\n'
start=0
incategory=0
dontspace=0

text_start='	StaticText "'
text_end='", "white"\n'
h3_end='", "gold"\n'
h2_start='OptionMenu "hdstance_'
h2_end='"\n'
blank='	StaticText " ", "white"\n'

menus=''
result=""
desc=""

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
		if [[ ${incategory} == "1" ]]
		then
			result+='}\n\n'
		fi

		result+=${h2_start}
		result+=${s:3}
		result+=${h2_end}
		result+='{\n'
		result+='	Title "'
		result+=${s:3}
		result+='"\n'

		menus+='	Submenu "'
		menus+=${s:3}
		menus+='", "hdstance_'
		menus+=${s:3}
		menus+='"\n'

		incategory=1
		dontspace=0

	elif [[ ${heading} == '```' ]]
	then
		continue
	else
		if [[ ${incategory} == "0" ]]
		then
			desc+=${text_start}
			desc+=${s}
			desc+=${text_end}
		else
			result+=${text_start}
			result+=${s}
			result+=${text_end}
		fi
		dontspace=0
	fi
done

if [[ ${incategory} == "1" ]]
then
	result+='}\n\n'
fi

result+='OptionMenu "HDSINFO" {\n'
result+='	Title "Stance Indicator Info"\n\n'
result+=${desc}
result+=${blank}
result+=${menus}
result+=${blank}
result+='	SafeCommand "Reset all CVars to default", "hdstance_resetallcvars"\n\n'


# Add the rest
result+='}\n\n'
result+='AddOptionMenu "OptionsMenu" {\n'
result+='	Submenu "Stance Indicator Info", "HDSINFO"\n'
result+='}'
echo -e $result > menudef.txt
echo "All done!"

unset IFS
