#!/bin/sh

if [ "$1" = "" ]; then
	echo
	echo "ERROR: Required parameter is missing. Use 'dist-get help' to get more information."
	echo
else
	name= echo -n "$1" | sed "s/.*\///g" | sed "s/\..*//"
	
	if [ ! -d ../../$name ]; then
		mkdir ../../$name
		mkdir ../../$name/meta
		mkdir ../../$name/temp
	else
		if [ ! -d ../../$name/temp ]; then
			mkdir ../../$name/temp
		fi
		if [ ! -d ../../$name/meta ]; then
			mkdir ../../$name/meta
		fi
	fi

	if [ "$2" = "local" ]; then
		cp $1 ../../$name/temp/dist.zip
	else
		wget -O"../../$name/temp/dist.zip" $1
	fi

	unzip ../../$name/temp/dist.zip -d ../../$name/temp
	rm ../../$name/temp/dist.zip
fi
