#!/bin/bash

echo
echo

START_TIME=`date`

echo "`date` admin-ap..."

echo "--------"  > /var/log/flossware_backups.log
echo "admin-ap `date`" >> /var/log/flossware_backups.log
echo "--------" >> /var/log/flossware_backups.log

ssh admin-ap "rsync -av --exclude opt $1 /etc /exports rsync://storage/exports/backups/host/admin-ap/" >> /var/log/flossware_backups.log

echo "`date` workstation..."

echo >> /var/log/flossware_backups.log
echo "-----------" >> /var/log/flossware_backups.log
echo "workstation `date`" >> /var/log/flossware_backups.log
echo "-----------" >> /var/log/flossware_backups.log

ssh workstation "rsync -av $1 /etc /exports /home rsync://storage/exports/backups/host/workstation/" >> /var/log/flossware_backups.log

echo "`date` redhat-workstation..."

echo >> /var/log/flossware_backups.log
echo "------------------" >> /var/log/flossware_backups.log
echo "redhat-workstation `date`" >> /var/log/flossware_backups.log
echo "------------------" >> /var/log/flossware_backups.log
ssh redhat-workstation "rsync -av $1 /etc /exports /home rsync://storage/exports/backups/host/redhat-workstation/" >> /var/log/flossware_backups.log

echo >> /var/log/flossware_backups.log
echo `date` >> /var/log/flossware_backups.log

echo
echo ${START_TIME}
echo `date`
echo
