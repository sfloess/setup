#/bin/bash

DIR=`dirname ${BASH_SOURCE[0]}`

ensureMacAddress() {
	if [ "$1" = "" ]
	then
		echo
		echo "ERROR:  No mac address found!"
		echo

		exit 1
	fi
}

. ${DIR}/host-utils.sh

ensureMacAddress "${mac["$1"]}"
wakeonlan ${mac["$1"]}
