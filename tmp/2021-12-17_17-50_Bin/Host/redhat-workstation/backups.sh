#/bin/bash

# -----------------------------------------------------------------------------------------

logger Backups starting...

# -----------------------------------------------------------------------------------------

LOG_FILE=/var/log/backups.log

# -----------------------------------------------------------------------------------------

rm -rf ${LOG_FILE}

# -----------------------------------------------------------------------------------------

echo
echo "Start Date:           `date +'%F %a'`"

# -----------------------------------------------------------------------------------------

mkdir -p /mnt/desktop-ap/exports/backups/remote/host/redhat-workstation/

echo "    desktop-ap:"
echo "        /etc:                        `date +'%H:%M:%S'`"
rsync -av $1 /etc /mnt/desktop-ap/exports/backups/remote/host/redhat-workstation/ --log-file=${LOG_FILE} $* &> /dev/null

mkdir -p /mnt/desktop-ap/exports/backups/local/host/redhat-workstation/

echo "        /home:                       `date +'%H:%M:%S'`"
rsync -av $1 /home /mnt/desktop-ap/exports/backups/local/host/redhat-workstation/ --log-file=${LOG_FILE} $* &> /dev/null

# -----------------------------------------------------------------------------------------

echo "End Date:             `date +'%F %a %H:%M:%S'`"

logger Backups complete...

# -----------------------------------------------------------------------------------------