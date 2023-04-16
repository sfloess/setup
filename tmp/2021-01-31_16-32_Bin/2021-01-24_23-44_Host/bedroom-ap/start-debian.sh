#!/bin/bash

# ----------------------------------------------------

# Needed for Mega cloud backups
export LD_LIBRARY_PATH=/usr/local/lib/
export PATH=/usr/local/bin:${PATH}

echo 65535 > /proc/sys/fs/inotify/max_user_watches

# ----------------------------------------------------

chmod -R 700 /root/.ssh
chmod 777 /run/screen

chmod u+s /usr/bin/sudo
chmod g+s /usr/bin/sudo

# ----------------------------------------------------

/usr/sbin/ntpdate-debian

chmod 700 -R /etc/ssh /var/run/sshd

# ----------------------------------------------------

/etc/init.d/rsyslog    start
/etc/init.d/ntp        start
/etc/init.d/cron       start
/etc/init.d/rpcbind    start
/etc/init.d/postfix    start
/etc/init.d/nis        start
/etc/init.d/ssh        start

# ----------------------------------------------------

#     Free Storage
# Name         Storage
# --------------------
# Box          50 GB *
# Dropbox      02 GB
# Google       15 GB
# Jottacloud   05 GB
# Mega         50 GB    Main backups are used here, excluding from rclone
# Microsoft    05 GB
# OpenDrive    50 GB *
# Yandex       10 GB
# pCloud       07 GB

# Box              50 GB 
# OpenDrive        50 GB 
# Koofr            10 GB
# Yandex           10 GB
# pCloud           07 GB
# Microsoft        05 GB
# Jottacloud       05 GB
# Dropbox          02 GB

mkdir -p /mnt/Box
mkdir -p /mnt/Box-sfloess
mkdir -p /mnt/OpenDrive
mkdir -p /mnt/Koofr
mkdir -p /mnt/Yandex
mkdir -p /mnt/pCloud
mkdir -p /mnt/Microsoft
mkdir -p /mnt/Jottacloud
mkdir -p /mnt/Dropbox

#chmod 755 /mnt/cloud/*

#/usr/bin/sudo /root/gopath/bin/rclone mount --allow-other --vfs-cache-mode full --daemon Box:/FlossWare         /mnt/Box
#/usr/bin/sudo /root/gopath/bin/rclone mount --allow-other --vfs-cache-mode full --daemon Box-sfloess:/FlossWare /mnt/Box-sfloess
#/usr/bin/sudo /root/gopath/bin/rclone mount --allow-other --vfs-cache-mode full --daemon OpenDrive:/FlossWare   /mnt/OpenDrive
#/usr/bin/sudo /root/gopath/bin/rclone mount --allow-other --vfs-cache-mode full --daemon Koofr:/FlossWare       /mnt/Koofr
#/usr/bin/sudo /root/gopath/bin/rclone mount --allow-other --vfs-cache-mode full --daemon Yandex:/FlossWare      /mnt/Yandex
#/usr/bin/sudo /root/gopath/bin/rclone mount --allow-other --vfs-cache-mode full --daemon pCloud:/FlossWare      /mnt/pCloud
#/usr/bin/sudo /root/gopath/bin/rclone mount --allow-other --vfs-cache-mode full --daemon Microsoft:/FlossWare   /mnt/Microsoft
#/usr/bin/sudo /root/gopath/bin/rclone mount --allow-other --vfs-cache-mode full --daemon Jottacloud:/FlossWare  /mnt/Jottacloud
#/usr/bin/sudo /root/gopath/bin/rclone mount --allow-other --vfs-cache-mode full --daemon Dropbox:/FlossWare     /mnt/Dropbox

#mkdir -p /mnt/cloud/Google
#mkdir -p /mnt/cloud/Mega

#/usr/bin/sudo /root/gopath/bin/rclone mount --allow-other --vfs-cache-mode full --daemon Google:/FlossWare     /mnt/cloud/Google
#/usr/bin/sudo /root/gopath/bin/rclone mount --allow-other --vfs-cache-mode full --daemon Mega:/FlossWare       /mnt/cloud/Mega

# ----------------------------------------------------
# Combine individual drives into one...

mkdir -p /mnt/Cloud 

#mergerfs /mnt/Box:/mnt/Box-sfloess:/mnt/OpenDrive:/mnt/Box:/mnt/OpenDrive:/mnt/Koofr:/mnt/Yandex:/mnt/pCloud:/mnt/Microsoft:/mnt/Jottacloud:/mnt/Dropbox /mnt/Cloud

#mhddfs /mnt/cloud/Box /mnt/cloud/OpenDrive /mnt/cloud/Box /mnt/cloud/OpenDrive /mnt/cloud/Koofr /mnt/cloud/Yandex /mnt/cloud/pCloud /mnt/cloud/Microsoft /mnt/cloud/Jottacloud /mnt/cloud/Dropbox /mnt/shared

# ----------------------------------------------------

nohup /usr/local/bin/mega-cmd-server &
#nohup /usr/local/bin/mega-ls &

# ----------------------------------------------------

