#/bin/bash

# -----------------------------------------------------------------------------------------

logger Backups starting...

# -----------------------------------------------------------------------------------------

LOG_FILE=/var/log/backup_neon-workstation.log

# -----------------------------------------------------------------------------------------

rm -rf ${LOG_FILE}

# -----------------------------------------------------------------------------------------

echo
echo "Start Date:           `date +'%F %a %H:%M:%S'`"

# -----------------------------------------------------------------------------------------

mkdir -p /exports/Backups/remote/host/neon-workstation/etc

echo "    neon-workstation -> server-ap:"
echo "        /etc:                        `date +'%H:%M:%S'`"
rsync -av $1 neon-workstation:/etc /exports/Backups/remote/host/neon-workstation/ --log-file=${LOG_FILE} $* &> /dev/null

mkdir -p /exports/Backups/remote/host/neon-workstation/home

echo "        /home:                       `date +'%H:%M:%S'`"
rsync -av $1 --exclude .m2 --exclude Tools --exclude Downloads --exclude dwhelper --exclude .cache neon-workstation:/home/* /exports/Backups/remote/host/neon-workstation/home/ --log-file=${LOG_FILE} $* &> /dev/null

# -----------------------------------------------------------------------------------------

echo

# -----------------------------------------------------------------------------------------

echo "    neon-workstation -> storage:     `date +'%H:%M:%S'`"

ssh storage mkdir -p /exports/Backups/host/neon-workstation

rsync -av $1 /exports/Backups/remote/host/neon-workstation/etc storage:/exports/Backups/host/neon-workstation --log-file=${LOG_FILE} $* &> /dev/null

rsync -av $1 /exports/Backups/remote/host/neon-workstation/home/sfloess storage:/exports/home/ --log-file=${LOG_FILE} $* &> /dev/null

# -----------------------------------------------------------------------------------------

echo "End Date:             `date +'%F %a %H:%M:%S'`"

logger Backups complete...

# -----------------------------------------------------------------------------------------
