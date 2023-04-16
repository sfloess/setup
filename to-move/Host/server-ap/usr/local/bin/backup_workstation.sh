#/bin/bash

# -----------------------------------------------------------------------------------------

logger Backups starting...

# -----------------------------------------------------------------------------------------

LOG_FILE=/var/log/backup_workstation.log

# -----------------------------------------------------------------------------------------

rm -rf ${LOG_FILE}

# -----------------------------------------------------------------------------------------

echo
echo "Start Date:           `date +'%F %a %H:%M:%S'`"

# -----------------------------------------------------------------------------------------

mkdir -p /exports/Backups/remote/host/workstation/etc

echo "    workstation -> server-ap:"
echo "        /etc:                        `date +'%H:%M:%S'`"
rsync -av $1 workstation:/etc /exports/Backups/remote/host/workstation/ --log-file=${LOG_FILE} $* &> /dev/null

mkdir -p /exports/Backups/remote/host/workstation/home

echo "        /home:                       `date +'%H:%M:%S'`"
rsync -av $1 --exclude .m2 --exclude Tools --exclude Downloads --exclude dwhelper --exclude .cache workstation:/home/* /exports/Backups/remote/host/workstation/home/ --log-file=${LOG_FILE} $* &> /dev/null

# -----------------------------------------------------------------------------------------

echo

# -----------------------------------------------------------------------------------------

echo "    workstation -> storage:          `date +'%H:%M:%S'`"

rsync -av $1 /exports/Backups/remote/host/workstation/etc storage:/exports/Backups/host/workstation --log-file=${LOG_FILE} $* &> /dev/null

rsync -av $1 /exports/Backups/remote/host/workstation/home/sfloess storage:/exports/home/ --log-file=${LOG_FILE} $* &> /dev/null

# -----------------------------------------------------------------------------------------

echo "End Date:             `date +'%F %a %H:%M:%S'`"

logger Backups complete...

# -----------------------------------------------------------------------------------------
