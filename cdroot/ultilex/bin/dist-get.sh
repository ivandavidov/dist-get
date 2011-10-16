#!/bin/sh
set -e

if [ "$1" = "" ]; then
	echo
	echo "ERROR: Required parameter is missing. Use 'dist-get help' to get more information."
	echo
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
	sh checkupdate.sh $2
	if [ -f temp_eq.tmp ]; then
		rm temp_eq.tmp
		echo
		echo "The distribution '$2' is already up to date"
		echo
	elif [ -f temp_neq.tmp ]; then
		rm temp_neq.tmp
		sh delete.sh $2
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
	echo
	echo "ERROR: Parameter '$1' is not recognized by 'dist-get'."
	echo
fi
