#/bin/bash

# -----------------------------------------------------------------------------------------

logger Backups starting...

# -----------------------------------------------------------------------------------------

LOG_FILE=/var/log/backup_media.log

# -----------------------------------------------------------------------------------------

rm -rf ${LOG_FILE}

# -----------------------------------------------------------------------------------------

echo
echo "Start Date:      `date +'%F %a'`"

# -----------------------------------------------------------------------------------------

echo "    admin-ap -> storage-ap:"

ssh storage mkdir -p /exports/backups/host/admin-ap/exports/media

echo "        /exports/media:         `date +'%H:%M:%S'`"

rsync -av $1 --exclude 'Deletable Movies' /exports/media/Videos storage:/exports/backups/host/admin-ap/exports/media --log-file=${LOG_FILE} $* &> /dev/null

# -----------------------------------------------------------------------------------------

echo "End Date:        `date +'%F %a'` `date +'%H:%M:%S'`"

logger Backups complete...

# -----------------------------------------------------------------------------------------
