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

#********************************
# Check the meta structure BEGIN
#********************************
if [ ! -f $temp/meta -o ! -f $temp/includes -o ! -f $temp/menu.cfg -o ! -f $temp/add.cfg ]; then
	print_error 2
fi
#******************************
# Check the meta structure END
#******************************

#**********************
# Load meta data BEGIN
#**********************
name=$(sh readproperty.sh $temp/meta name)
newMD5=$(sh readproperty.sh $temp/meta md5)
url=$(sh readproperty.sh $temp/meta url)
#********************
# Load meta data END
#********************

#************************
# Checks meta data BEGIN
#************************
if [ "$name" != "$1" ]; then
	print_error 2
fi
if [ -f $dir/meta/meta -o -f $dir/meta/includes -o -f $dir/meta/menu.cfg -o -f $dir/meta/add.cfg ]; then
	print_error 1
fi
cp -f $temp/* $dir/meta
#**********************
# Checks meta data END
#**********************

#********************************************
# Downloads or copies the distribution BEGIN
#********************************************
if [ "$2" = "" ]; then
	wget -O"$temp/$name.iso" $url
	echo "Download complete."
else
	cp $2 $temp/$name.iso
fi

sh extractiso.sh "$temp/$name.iso" "$temp" "mnt"
#******************************************
# Downloads or copies the distribution END
#******************************************

#**********************************
# Copies the necessary files BEGIN
#**********************************
dest="NOTSET"
while IFS= read -r line; do
	line=$(echo -n "$line" | sed "s/|/\//g")
	if [ $dest = "NOTSET" ]; then
		source=$line
		dest="SET"
	else
		cp -R $temp/mnt$source $dir$line
		dest="NOTSET"
	fi
done < $temp/includes
line=$(echo -n "$line" | sed "s/|/\//g")
if [ $dest = "SET" ]; then
	cp -R $temp/mnt$source $dir$line
	dest="NOTSET"
fi

sync
rm -rf $temp/mnt
#********************************
# Copies the necessary files END
#********************************
