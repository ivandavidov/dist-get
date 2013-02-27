#!/bin/sh
set -e

print_error()
{
	sh printerror.sh $1 $2
	exit 1
}

if [ "$1" = "" ]; then
	print_error missing_param $1
elif [ "$1" = "help" ]; then
	cat ../stuff/help.txt | more
elif [ "$1" = "about" ]; then
	cat ../stuff/about.txt | more
elif [ "$1" = "prepare" ]; then
	sh prepare.sh $2 $3
elif [ "$1" = "list" ]; then
	sh list.sh
elif [ "$1" = "install" ]; then
	sh install.sh $2 $3
	sh reorganize.sh
elif [ "$1" = "update" ]; then
	sh prepareupdate.sh $2
	if [ -f temp_eq.tmp ]; then
		rm temp_eq.tmp
		print_error dist_up_to_date $2
	elif [ -f temp_neq.tmp ]; then
		rm temp_neq.tmp
		sh install.sh $2
		sh reorganize.sh
	fi
elif [ "$1" = "remove" ]; then
	sh delete.sh $2
	sh reorganize.sh
elif [ "$1" = "reorganize" ]; then
	sh reorganize.sh
elif [ "$1" = "cleanup" ]; then
	sh cleanup.sh $2
elif [ "$1" = "usbinstall" ]; then
	sh cleanup.sh
	sh bootinst.sh
elif [ "$1" = "makeiso" ]; then
	sh cleanup.sh
	sh make_iso.sh
else
	print_error command_not_found $1
fi
