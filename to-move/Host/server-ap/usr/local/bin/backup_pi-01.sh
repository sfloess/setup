#/bin/bash

# -----------------------------------------------------------------------------------------

logger Backups starting...

# -----------------------------------------------------------------------------------------

LOG_FILE=/var/log/backup_pi-01.log

# -----------------------------------------------------------------------------------------

rm -rf ${LOG_FILE}

# -----------------------------------------------------------------------------------------

echo
echo "Start Date:                  `date +'%F %a'` `date +'%H:%M:%S'`"

# -----------------------------------------------------------------------------------------

echo "    pi-01 -> server-ap:"

mkdir -p /exports/Backups/remote/host/pi-01/

echo "        /etc:                               `date +'%H:%M:%S'`"

rsync -av $1 pi-01:/etc /exports/Backups/remote/host/pi-01/ --log-file=${LOG_FILE} $* &> /dev/null

mkdir -p /exports/Backups/remote/host/pi-01/usr/local

echo "        /usr/local/etc:                     `date +'%H:%M:%S'`"

rsync -av $1 pi-01:/usr/local/etc /exports/Backups/remote/host/pi-01/usr/local/ --log-file=${LOG_FILE} $* &> /dev/null

echo
echo "    server-ap -> storage:"

echo "        /exports/Backups/local/host/pi-01:  `date +'%H:%M:%S'`"

rsync -av /exports/Backups/local/host/pi-01 storage:/exports/Backups/host/ --log-file=${LOG_FILE} $* &> /dev/null

# -----------------------------------------------------------------------------------------

echo "End Date:                    `date +'%F %a'` `date +'%H:%M:%S'`"

logger Backups complete...

# -----------------------------------------------------------------------------------------

