#/bin/bash

# -----------------------------------------------------------------------------------------

logger Backups starting...

# -----------------------------------------------------------------------------------------

LOG_FILE=/var/log/backup_admin-ap.log

# -----------------------------------------------------------------------------------------

rm -rf ${LOG_FILE}

# -----------------------------------------------------------------------------------------

echo
echo "Start Date:                             `date +'%F %a'` `date +'%H:%M:%S'`"

# -----------------------------------------------------------------------------------------

echo "    admin-ap -> server-ap:"

mkdir -p /exports/Backups/remote/host/admin-ap/

echo "        /etc:                                          `date +'%H:%M:%S'`"

rsync -av $1 admin-ap:/etc /exports/Backups/remote/host/admin-ap/ --log-file=${LOG_FILE} $* &> /dev/null

echo "        /exports/media:                                `date +'%H:%M:%S'`"

mkdir -p /exports/Backups/local/host/admin-ap/exports/media

rsync -av admin-ap:/exports/media/Audio admin-ap:/exports/media/Books admin-ap:/exports/media/'Cheat Sheets' admin-ap:/exports/media/Manuals admin-ap:/exports/media/Music admin-ap:/exports/media/Whitepapers /exports/Backups/local/host/admin-ap/exports/media/ --log-file=${LOG_FILE} $* &> /dev/null

mkdir -p /exports/Backups/local/host/admin-ap/exports/media/Videos

#rsync -av admin-ap:/exports/media/Videos/Movies admin-ap:/exports/media/Videos/Effed\ Up\ Movies admin-ap:/exports/media/Videos/Morbid /exports/Backups/local/host/admin-ap/exports/media/Videos --log-file=${LOG_FILE} $* &> /dev/null
rsync -av admin-ap:/exports/media/Videos/Movies /exports/Backups/local/host/admin-ap/exports/media/Videos --log-file=${LOG_FILE} $* &> /dev/null

echo
echo "    server-ap -> storage:"

echo "        /exports/Backups/local/host/admin-ap/exports:  `date +'%H:%M:%S'`"

rsync -av /exports/Backups/local/host/admin-ap/exports/etc storage:/exports/Backups/host/admin-ap/ --log-file=${LOG_FILE} $* &> /dev/null

echo "        /exports/Backups/remote/host/admin-ap/exports: `date +'%H:%M:%S'`"

rsync -av /exports/Backups/remote/host/admin-ap/exports/media storage:/exports/Backups/host/admin-ap/ --log-file=${LOG_FILE} $* &> /dev/null

# -----------------------------------------------------------------------------------------

echo "End Date:                               `date +'%F %a'` `date +'%H:%M:%S'`"

logger Backups complete...

# -----------------------------------------------------------------------------------------

