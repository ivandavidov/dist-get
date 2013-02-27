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

if [ "$1" = "" ]; then
	print_error 1
fi

temp=../../$1/temp
dir=../../$1

#********************************
# Check the meta structure BEGIN
#********************************
if [ ! -f $temp/meta -o ! -f $temp/includes -o ! -f $temp/menu.cfg -o ! -f $temp/add.cfg ]; then
	print_error 2
fi
#******************************
# Check the meta structure END
#******************************

counter=0
oldMeta=../../$1/meta
newMeta=../../$1/temp

oldMD5=$(sh readproperty.sh $oldMeta/meta md5)
newMD5=$(sh readproperty.sh $newMeta/meta md5)

if [ $newMD5 = $oldMD5 ]; then
	echo 0 > temp_eq.tmp
else
	echo 1 > temp_neq.tmp
	cd ../../$1
	for d in * ; do
		if [ ! $d = "temp" ]; then
			rm -rf $d
		fi
	done
	cd ultilex/bin
fi


