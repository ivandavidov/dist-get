#!/bin/bash

meta=../temp/$1

if [ ! -f $meta/meta -o ! -f $meta/includes.win -o ! -f $meta/includes.linux -o ! -f $meta/menu.cfg -o ! -f $meta/add.cfg ]; then
	echo ";("
fi

counter=0
error=0

while IFS= read -r line; do
	if [ "$counter" = "0" ]; then
		name=$line
	elif [ "$counter" = "1" ]; then
		ddir=../../$line
		if [ -d $ddir ]; then
			error=1
			break
		fi
		mkdir $ddir
		mkdir $ddir/meta
		cp -f $meta/* $ddir/meta
	elif [ "$counter" = "2" ]; then
		md5=$line
	elif [ "$counter" = "3" ]; then
		if [ "$2" = "" ]; then
			url=$line
			wget -O"../temp/$name.iso" $url
			echo "Download complete."
		else
			cp $2 ../temp/$name.iso
		fi

		mkdir ../temp/mnt
		mount -o loop ../temp/$name.iso ../temp/mnt
	fi
	counter=$(( counter + 1 ))
done < $meta/meta

if [ "$error" = "1" ]; then
	echo
	echo "ERROR: You have already installed '$1'."
	echo
elif [ "$error" = "2" ]; then
	echo
	echo "ERROR: Required parameter is missing. Use 'dist-get help' for more information."
	echo
elif [ "$error" = "3" ]; then
	echo
	echo "ERROR: Metadata is missing or corrupted. Use 'dist-get cleanup $1' and then 'dist-get prepare'."
	echo
fi

