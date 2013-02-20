#!/bin/sh

print_error()
{
	if [ "$1" = "1" ]; then
		echo
		echo "ERROR: You have already installed '$1'."
		echo
	elif [ "$1" = "2" ]; then
		echo
		echo "ERROR: Required parameter is missing. Use 'dist-get help' for more information."
		echo
	elif [ "$1" = "3" ]; then
		echo
		echo "ERROR: Metadata is missing or corrupted. Use 'dist-get cleanup $1' and then 'dist-get prepare'."
		echo
	fi
	exit 1
}

temp=../../$1/temp
dir=../../$1

if [ ! -f $temp/meta -o
     ! -f $temp/includes.win -o
     ! -f $temp/includes.linux -o
     ! -f $temp/menu.cfg -o
     ! -f $temp/add.cfg ]; then
	print_error 2
fi

counter=0

while IFS= read -r line; do
	if [ "$counter" = "0" ]; then
		name=$line
	elif [ "$counter" = "1" ]; then
		ddir=../../$line
		if [ -d $ddir ]; then
			print_error 1
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
	fi
	counter=$(( counter + 1 ))
done < $meta/meta


mkdir ../temp/mnt
mount -o loop ../temp/$name.iso ../temp/mnt

dest="NOTSET"
while IFS= read -r line; do
	if [ $dest = "NOTSET" ]; then
		source=$line
		dest="SET"
	else
		cp -R ../temp/mnt$source $ddir$line
		dest="NOTSET"
	fi
done < $meta/includes.linux
if [ $dest = "SET" ]; then
	echo "../temp/mnt$source $ddir$line"
	cp -R ../temp/mnt$source $ddir$line
	dest="NOTSET"
fi

sync
umount ../temp/mnt
rmdir ../temp/mnt

