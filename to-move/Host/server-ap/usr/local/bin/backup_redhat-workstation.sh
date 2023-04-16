#/bin/bash

# -----------------------------------------------------------------------------------------

logger Backups starting...

# -----------------------------------------------------------------------------------------

LOG_FILE=/var/log/backup_redhat-workstation.log

# -----------------------------------------------------------------------------------------

rm -rf ${LOG_FILE}

# -----------------------------------------------------------------------------------------

echo
echo "Start Date:           `date +'%F %a %H:%M:%S'`"

# -----------------------------------------------------------------------------------------

mkdir -p /exports/Backups/remote/host/redhat-workstation/

echo "    redhat-workstation -> server-ap:"
echo "        /etc:                        `date +'%H:%M:%S'`"
rsync -av $1 redhat-workstation:/etc /exports/Backups/remote/host/redhat-workstation/ --log-file=${LOG_FILE} $* &> /dev/null

mkdir -p /exports/Backups/local/host/redhat-workstation/

echo "        /home:                       `date +'%H:%M:%S'`"
rsync -av $1 --exclude .m2 --exclude Tools --exclude .cache --exclude Install --exclude tmp redhat-workstation:/home /exports/Backups/local/host/redhat-workstation/ --log-file=${LOG_FILE} $* &> /dev/null

# -----------------------------------------------------------------------------------------

echo

# -----------------------------------------------------------------------------------------

echo "    server-ap -> storage:"
rsync -av $1 /exports/Backups/remote/host/redhat-workstation/etc storage:/exports/Backups/host/redhat-workstation/ --log-file=${LOG_FILE} $* &> /dev/null
rsync -av $1 /exports/Backups/local/host/redhat-workstation/home storage:/exports/Backups/host/redhat-workstation/ --log-file=${LOG_FILE} $* &> /dev/null

# -----------------------------------------------------------------------------------------

echo "End Date:             `date +'%F %a %H:%M:%S'`"

logger Backups complete...

# -----------------------------------------------------------------------------------------
