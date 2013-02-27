#!/bin/sh

cd ../..

if [ "$1" = "" ]; then
#***********************************
# Remove all temp directories BEGIN
#***********************************
for d in * ; do
	if [ -d $d -a ! $d = "boot" -a ! $d = "ultilex" -a -d $d/temp ]; then
		rm -rf $d/temp
	fi
done
#*********************************
# Remove all temp directories END
#*********************************
else
	if [ -d $1 -a ! $d = "boot" -a ! $d = "ultilex" -a -d $1/temp ]; then
		rm -rf $1/temp
	fi
fi

cd ultilex/bin
