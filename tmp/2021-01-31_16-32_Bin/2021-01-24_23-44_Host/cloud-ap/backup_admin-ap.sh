#!/bin/bash

# -----------------------------------------------------------------------------------------

logger Backups starting...

# -----------------------------------------------------------------------------------------

BACKUP_HOME_DIR=/opt/backups/admin-ap
LOG_FILE=/var/log/backups.log

# -----------------------------------------------------------------------------------------

rm -rf ${LOG_FILE}
mkdir -p "${BACKUP_HOME_DIR}"

# -----------------------------------------------------------------------------------------

echo
echo "Start Date:                      `date`"

# -----------------------------------------------------------------------------------------

echo "    admin-ap:/opt/backups/host:  `date`"
rsync -av admin-ap:/opt/backups/host ${BACKUP_HOME_DIR}/ --log-file=${LOG_FILE} $* &> /dev/null

echo "    admin-ap:/etc:               `date`"
rsync -av admin-ap:/etc              ${BACKUP_HOME_DIR}/ --log-file=${LOG_FILE} $* &> /dev/null

echo "    admin-ap:/home:              `date`"
rsync -av admin-ap:/home             ${BACKUP_HOME_DIR}/ --log-file=${LOG_FILE} $* &> /dev/null

echo "    admin-ap:/root:              `date`"
rsync -av admin-ap:/root             ${BACKUP_HOME_DIR}/ --log-file=${LOG_FILE} $* &> /dev/null

# -----------------------------------------------------------------------------------------

echo "End Date:                        `date`"

logger Backups complete...

# -----------------------------------------------------------------------------------------

