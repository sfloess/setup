#/bin/bash

# -----------------------------------------------------------------------------------------

logger Backups starting...

# -----------------------------------------------------------------------------------------

LOG_FILE=/var/log/backups.log

# -----------------------------------------------------------------------------------------

rm -rf ${LOG_FILE}

# -----------------------------------------------------------------------------------------

echo
echo "Start Date:      `date +'%F %a'`"

# -----------------------------------------------------------------------------------------

echo "    cloud-storage:"

mkdir -p /mnt/desktop-ap/exports/backups/remote/host/cloud-storage/

echo "        /etc:                   `date +'%H:%M:%S'`"

rsync -av $1 /etc /mnt/desktop-ap/exports/backups/remote/host/cloud-storage/ --log-file=${LOG_FILE} $* &> /dev/null

mkdir -p /mnt/desktop-ap/exports/backups/remote/host/cloud-storage/exports

echo "        /exports/home:          `date +'%H:%M:%S'`"

rsync -av $1 /exports/home /mnt/desktop-ap/exports/backups/remote/host/cloud-storage/exports --log-file=${LOG_FILE} $* &> /dev/null

echo "    desktop-ap:"

mkdir -p /exports/media

echo "        /exports/media:         `date +'%H:%M:%S'`"

rsync -av $1 /mnt/desktop-ap/exports/media /exports/ --log-file=${LOG_FILE} $* &> /dev/null

# -----------------------------------------------------------------------------------------

echo "End Date:        `date +'%F %a'` `date +'%H:%M:%S'`"

logger Backups complete...

# -----------------------------------------------------------------------------------------