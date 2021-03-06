#!/bin/sh
# script from http://korenofer.blogspot.com/2008/08/how-to-extract-iso-file-with-bash-shell.html

# Now, Some global defines
ISO_FILE="$1"
ISO_INFO="isoinfo"
OUT_DIR="$2/$3"
TMP_FILES="$2/files.tmp"
DIR_PREFIX="Directory listing of "

# Save all the files tree in tmp log file
${ISO_INFO} -R -l -i ${ISO_FILE} > ${TMP_FILES}

# If the output dir already exist, remove it
if [ -e ${OUT_DIR} ]; then
	rm -rf ${OUT_DIR}
fi

# Read the file tree line by line
exec< ${TMP_FILES} 
while read node
do
	# If line not empty
 	if [ -n "$node" ]; then
		# If line starts with "Directory listing of", Its a directory, see output sample above
		line=$( echo -n "$node" | grep "^${DIR_PREFIX}.*" )
     		if [ "" != "$line" ]; then
   			# Remove the "Directory listing of " prefix
   			dir=`echo "$node" | sed s/"${DIR_PREFIX}"//g`
			# And create the directory under the OUT_DIR directory
			# mkdir -p  = make parent directories as needed (from the man page)
			mkdir -p ${OUT_DIR}$dir
		else
			# As you can see in the output sample above, both files and directories are listed together,
			# the directories can be identified by the first letter in its attribute columns "d", So I will ignore 
			# them since we handled directories in the previous case
			line=$( echo -n "$node" | grep "^d.*" )
			if [ "" = "$line" ]; then
				# File
				file=`echo $node | cut -d" " -f12`
				# Actually, I don't need to recheck again the "." and ".." directory, But, Just in case
				if [ $file != "." -a $file != ".." ]; then
					# Create full file path
					filepath=$dir$file
					# Create the file
					touch ${OUT_DIR}${filepath}
					# Extract the file to its location
					${ISO_INFO} -R -i ${ISO_FILE} -x ${filepath} > ${OUT_DIR}${filepath}
				fi
			fi
		fi
	fi
done

# If exist, remove the temporary files list
if [ -f ${TMP_FILES} ]; then
	\rm -rf ${TMP_FILES}
fi

