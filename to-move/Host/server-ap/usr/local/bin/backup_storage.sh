#/bin/bash

# -----------------------------------------------------------------------------------------

logger Backups starting...

# -----------------------------------------------------------------------------------------

LOG_FILE=/var/log/backup_storage.log

# -----------------------------------------------------------------------------------------

rm -rf ${LOG_FILE}

# -----------------------------------------------------------------------------------------

echo
echo "Start Date:      `date +'%F %a'`"

# -----------------------------------------------------------------------------------------

echo "    storage -> server-ap:"

mkdir -p /exports/Backups/remote/host/storage/

echo "        /etc:                   `date +'%H:%M:%S'`"

rsync -av $1 storage:/etc /exports/Backups/remote/host/storage/ --log-file=${LOG_FILE} $* &> /dev/null

mkdir -p /exports/Backups/remote/host/storage/exports

echo "        /exports/home:          `date +'%H:%M:%S'`"

rsync -av $1 storage:/exports/home /exports/Backups/remote/host/storage/exports --log-file=${LOG_FILE} $* &> /dev/null

# -----------------------------------------------------------------------------------------

echo "End Date:        `date +'%F %a'` `date +'%H:%M:%S'`"

logger Backups complete...

# -----------------------------------------------------------------------------------------

