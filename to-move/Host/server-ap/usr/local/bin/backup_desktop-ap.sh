#/bin/bash

# -----------------------------------------------------------------------------------------

logger Backups starting...

# -----------------------------------------------------------------------------------------

LOG_FILE=/var/log/backup_desktop-ap.log

# -----------------------------------------------------------------------------------------

rm -rf ${LOG_FILE}

# -----------------------------------------------------------------------------------------

echo
echo "Start Date:      `date +'%F %a'`"

# -----------------------------------------------------------------------------------------

echo "    desktop-ap -> storage-ap:"

mkdir -p /exports/backups/remote/host/desktop-ap

echo "        /etc:                   `date +'%H:%M:%S'`"
rsync -av $1 desktop-ap:/etc /exports/backups/remote/host/desktop-ap/ --log-file=${LOG_FILE} $* &> /dev/null

mkdir -p /exports/backups/local/host/desktop-ap/exports

echo "        /exports/media:         `date +'%H:%M:%S'`"

rsync -av $1 --exclude Videos desktop-ap:/exports/media /exports/backups/local/host/desktop-ap/exports --log-file=${LOG_FILE} $* &> /dev/null

# -----------------------------------------------------------------------------------------

echo "End Date:        `date +'%F %a'` `date +'%H:%M:%S'`"

logger Backups complete...

# -----------------------------------------------------------------------------------------
