#/bin/bash

# -----------------------------------------------------------------------------------------

logger Backups starting...

# -----------------------------------------------------------------------------------------

LOG_FILE=/var/log/backups.log

# -----------------------------------------------------------------------------------------

rm -rf ${LOG_FILE}

# -----------------------------------------------------------------------------------------

echo
echo "Start Date:                        `date +'%F %a'`"

# -----------------------------------------------------------------------------------------

echo "    cloud-ap -> desktop-ap:"
echo "        /exports/backups/remote:                  `date +'%H:%M:%S'`"
rsync -av $1 /exports/backups/remote /mnt/desktop-ap/exports/backups --log-file=${LOG_FILE} $* &> /dev/null

echo "        /exports/backups/local:                   `date +'%H:%M:%S'`"
rsync -av $1 /exports/backups/local /mnt/desktop-ap/exports/backups --log-file=${LOG_FILE} $* &> /dev/null

# -----------------------------------------------------------------------------------------

echo "End Date:                          `date +'%F %a %H:%M:%S'`"

logger Backups complete...

# -----------------------------------------------------------------------------------------

