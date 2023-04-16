#!/bin/bash

# -------------------------------------------------------
# Try to start our server
# -------------------------------------------------------

invokeServer() {
	RESULT=1
	TOTAL=1

	while [ "${RESULT}" != "0" ]
	do
		echo
		echo "           ==============================================================================="
		echo "           Service:   $1"
	        echo "                      ${ACTION} #${TOTAL}"
		echo "           ==============================================================================="
		echo

		$1 ${ACTION}

		RESULT=$?

		TOTAL=`expr ${TOTAL} + 1`
	done
}

# -------------------------------------------------------

if [ $# -lt 1 ]
then
	echo
	echo "Please enter an action:"
	echo "	start"
	echo "	stop"
	echo
	exit 1
else
	ACTION=$1
fi

# -------------------------------------------------------

#FUSION_HOME=/mnt/redhat-laptop/opt/fusion/3.0.1
#ACTIVEMQ_HOME=/mnt/redhat-laptop/opt/apache-activemq-5.11.3

# -------------------------------------------------------

FUSION_HOME=/opt/fusion/3.0.1
ACTIVEMQ_HOME=/opt/apache-activemq-5.11.3

# -------------------------------------------------------

invokeServer ${ACTIVEMQ_HOME}/bin/activemq ${ACTION}
invokeServer ${FUSION_HOME}/bin/fusion ${ACTION}

# -------------------------------------------------------

