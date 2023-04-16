#!/bin/bash

BACKUP_DIR=/mnt/admin-ap/backups/host/`hostname`

mkdir -p ${BACKUP_DIR}

rsync -av /etc ${BACKUP_DIR} $@
