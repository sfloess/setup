#!/bin/bash

allFiles=`find Shorts -type f | tr -s '\n' ':'`

export IFS=':'

mkdir -p Converted/Shorts

for aFile in $allFiles
do
       	echo "[$aFile]"

	ffmpeg -i "${aFile}" -codec copy "Converted/${aFile}"
done


