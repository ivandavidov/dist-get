#!/bin/sh

if [ "$1" = "" ]; then
	rm -rf ../temp
else
	if [ -d ../temp/$1 ]; then
		rm -rf ../temp/$1
	fi
fi

