#!/bin/sh

echo
echo "Available meta data:"
echo

if [ ! -d ../temp ]; then
	echo "--nothing--"
else
	cd ../temp

	counter=0

	for d in * ; do
		if [ -d $d ]; then
			echo $d
			counter=$(( counter + 1 ))
		fi
	done

	if [ $counter = 0 ]; then
		echo "--nothing--"
	fi

	cd ../bin
fi

cd ../../

echo
echo "Installed distributions:"
echo

counter=0

for d in * ; do
	if [ -d $d -a ! $d = "boot" -a ! $d = "ultilex" ]; then
		echo $d
		counter=$(( counter + 1 ))
	fi
done

if [ $counter = 0 ]; then
	echo "--nothing--"
fi

echo

cd ultilex/bin
