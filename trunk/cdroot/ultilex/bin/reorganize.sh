#!/bin/sh

cd ../..

menus="ultilex/cfg/menus.cfg"
additionals="ultilex/cfg/adds.cfg"

echo "" > $menus
echo "" > $additionals

for d in * ; do
	if [ ! $d = "boot" -o ! $d = "ultilex" ]; then
		if [ -f $d/meta/menu.cfg ]; then
			echo "INCLUDE /$d/meta/menu.cfg" >> $menus
		fi
		if [ -f $d/meta/add.cfg ]; then
			echo "INCLUDE /$d/meta/add.cfg" >> $additionals
		fi
	fi
done

cd ultilex/bin
