#!/bin/sh

if [ "$1" = "" ]; then
	echo "Error"
fi

counter=0
oldMeta=../../$1/meta
newMeta=../temp/$1

while IFS= read -r line; do
	if [ "$counter" = "2" ]; then
		oldMD5=$line
	fi
	counter=$(( counter + 1 ))
done < $oldMeta/meta

counter=0

while IFS= read -r line; do
	if [ "$counter" = "2" ]; then
		newMD5=$line
	fi
	counter=$(( counter + 1 ))
done < $newMeta/meta

if [ $newMD5 = $oldMD5 ]; then
	echo 0 > temp_eq.tmp
else
	echo 1 > temp_neq.tmp
fi


