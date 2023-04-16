#!/bin/bash

# -----------------------------------------------------------------------------------------

if [ $# -lt 1 ]
then
    echo
    echo "Please provide all hosts to backup to as params"
    echo
    
    exit 1
fi

# -----------------------------------------------------------------------------------------

logger Backups starting...

# -----------------------------------------------------------------------------------------

LOG_FILE=/var/log/push_server.log

# -----------------------------------------------------------------------------------------

rm -rf ${LOG_FILE}

# -----------------------------------------------------------------------------------------

echo
echo "Start Date:      `date +'%F %a'` `date +'%H:%M:%S'`"
echo

# -----------------------------------------------------------------------------------------

echo "Pushing to:  [$*]"

while [ $# -gt 0 ]
do
    echo "    $1"

    rsync -av --delete --exclude Downloads --exclude dwhelper --exclude media --exclude exports/host/pi-02 /exports $1:/exports/backups/desktop-ap/ --log-file=${LOG_FILE} &> /dev/null

    shift
done

# -----------------------------------------------------------------------------------------

echo
echo "End Date:        `date +'%F %a'` `date +'%H:%M:%S'`"

logger Backups complete...

# -----------------------------------------------------------------------------------------

