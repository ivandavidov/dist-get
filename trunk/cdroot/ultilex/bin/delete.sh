#!/bin/sh

print_error()
{
	sh printerror.sh $1 $2
	exit 1
}

if [ "$1" = "" ]; then
	print_error missing_param $1
else
	if [ -d ../../$1 ]; then
		rm -rf ../../$1
	fi
fi

