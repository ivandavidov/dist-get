#!/bin/bash

if [ "$1" = "" ]; then
	echo
	echo "ERROR: Required parameter is missing. Use 'dist-get help' to get more information."
	echo
elif [ "$1" = "help" ]; then
	echo "*** dist-get help page ***"
	echo
	echo "Available options: "
	echo 
	echo "help                            Displays the current screen."
	echo
	echo "about                           Displays information about the authors of"
	echo "                                this project."
	echo
	echo "prepare URL_META_FILE [local]   Downloads and prepares a meta data bundle for"
	echo "                                certain distribution. The URL_META_FILE can"
	echo "                                be HTTP/HTTPS location or a local file."
	echo "                                If it is a local file, you need to use the"
	echo "                                'local' parameter at the end of the command."
	echo
	echo "list                            Displays a list of all prepared and installed"
	echo "                                distributions."
	echo                                
	echo "install DISTRO_NAME [ISO_FILE]  Installs the DISTRO_NAME distribution. This"
	echo "                                requires active internet connection unless"
	echo "                                you provide a previously downloaded ISO file"
	echo "                                as additional parameter."
	echo
	echo "update DISTRO_NAME              Updates the DISTRO_NAME distribution. Please"
	echo "                                note that you have to retrieve the new meta"
	echo "                                data fisrt by executing 'dist-get prepare'."
	echo
	echo "remove DISTRO_NAME              Removes the DISTRO_NAME distribution."
	echo
	echo "reorganize                      Builds the boot menu. This command is executed"
	echo "                                automatically after install, update and remove."
	echo
	echo "cleanup [DISTRO_NAME]           Removes all temporary meta data. You can remove"
	echo "                                meta data for DISTRO_NAME by providing it as"
	echo "                                additional parameter. This command is executed"
	echo "                                automatically before usbinstall or makeiso."
	echo
	echo "usbinstall                      Makes the current USB device to be bootable."
	echo
	echo "makeiso                         Creates a single CD ISO image which contains"
	echo "                                all installed distributions."
	echo
elif [ "$1" = "about" ]; then
	echo
	echo "*** ULTILEX powered by 'dist-get' ***"
	echo
	echo "List of all contributors (in alphabet order):"
	echo
	echo "Ivan Davidov, Sofia, Bulgaria (ivan.bgzin.com)"
	echo
	echo "Peter Chakalov, Sliven, Bulgaria (peter.chakalov@gmail.com)"
	echo
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
