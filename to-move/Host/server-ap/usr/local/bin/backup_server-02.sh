#/bin/bash

# -----------------------------------------------------------------------------------------

logger Backups starting...

# -----------------------------------------------------------------------------------------

LOG_FILE=/var/log/backup_server-02.log

# -----------------------------------------------------------------------------------------

rm -rf ${LOG_FILE}

# -----------------------------------------------------------------------------------------

echo
echo "Start Date:           `date +'%F %a %H:%M:%S'`"

# -----------------------------------------------------------------------------------------

mkdir -p /exports/Backups/remote/host/server-02/etc

echo "    server-02 -> server-ap:"
echo "        /etc:                        `date +'%H:%M:%S'`"
rsync -av $1 server-02:/etc /exports/Backups/remote/host/server-02/ --log-file=${LOG_FILE} $* &> /dev/null

mkdir -p /exports/Backups/remote/host/server-02/home

echo "        /home:                       `date +'%H:%M:%S'`"
rsync -av $1 --exclude .m2 --exclude Tools --exclude Downloads --exclude dwhelper --exclude .cache server-02:/home/* /exports/Backups/remote/host/server-02/home/ --log-file=${LOG_FILE} $* &> /dev/null

# -----------------------------------------------------------------------------------------

echo

# -----------------------------------------------------------------------------------------

echo "    server-02 -> storage:          `date +'%H:%M:%S'`"

rsync -av $1 /exports/Backups/remote/host/server-02/etc storage:/exports/Backups/host/server-02 --log-file=${LOG_FILE} $* &> /dev/null

rsync -av $1 /exports/Backups/remote/host/server-02/home/sfloess storage:/exports/home/ --log-file=${LOG_FILE} $* &> /dev/null

# -----------------------------------------------------------------------------------------

echo "End Date:             `date +'%F %a %H:%M:%S'`"

logger Backups complete...

# -----------------------------------------------------------------------------------------
