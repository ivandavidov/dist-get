#!/bin/bash

if [ "$1" = "" ]; then
	echo
	echo "ERROR: Required parameter is missing. Use 'dist-get help' to get more information."
	echo
else
	if [ ! -d ./../temp ]; then
		mkdir ../temp
	fi

	if [ "$2" = "local" ]; then
		cp $1 ../temp/dist.zip
	else
		wget -O"../temp/dist.zip" $1
	fi

	unzip ../temp/dist.zip -d ../temp/dist
	read -r name < ../temp/dist/meta
	namee = ${name//[[:space:]]}
echo $namee
	mv ../temp/dist ../temp/$name
	rm ../temp/dist.zip
fi
