#!/bin/sh

if [ "$1" = "" ]; then
	echo
	echo ERROR: Required parameter is missing. Use 'dist-get help' to get more information.
	echo
else
	if [ -d ../../$1 ]; then
		rm -rf ../../$1
	fi
fi

