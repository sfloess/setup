#!/bin/bash

# ----------------------------------------------------

# Needed for Mega cloud backups
export LD_LIBRARY_PATH=/usr/local/lib/
export PATH=/usr/local/bin:${PATH}

mkdir -p /mnt/Box

mkdir -p /mnt/Cloud

#chmod 755 /mnt/cloud/*

/usr/bin/sudo /root/gopath/bin/rclone mount --allow-other --vfs-cache-mode full --daemon Box:/FlossWare  /mnt/Cloud

# ----------------------------------------------------

