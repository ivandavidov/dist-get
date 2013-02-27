#!/bin/sh

print_error()
{
	sh printerror.sh $1 $2
	exit 1
}

if [ "$1" = "" ]; then
	print_error missing_param
fi

temp=../../$1/temp
dir=../../$1

#********************************
# Check the meta structure BEGIN
#********************************
if [ ! -f $temp/meta -o ! -f $temp/includes -o ! -f $temp/menu.cfg -o ! -f $temp/add.cfg ]; then
	print_error corrupted_old_meta_data $1
fi

if [ ! -f $dir/meta/meta -o ! -f $dir/meta/includes -o ! -f $dir/meta/menu.cfg -o ! -f $dir/meta/add.cfg ]; then
	print_error corrupted_new_meta_data $1
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


