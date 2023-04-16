#!/bin/bash

if [ $# -lt 1 ]
then
	echo "Must provide a key"
	echo
	exit 1
fi

while [ $# -gt 0 ]
do
	apt-key adv --keyserver keyserver.ubuntu.com --recv-keys $1
	shift
done


