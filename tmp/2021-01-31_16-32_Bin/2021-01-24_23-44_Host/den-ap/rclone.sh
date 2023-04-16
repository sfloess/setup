#!/bin/bash

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
mkdir -p /mnt/OpenDrive
mkdir -p /mnt/Koofr
mkdir -p /mnt/Yandex
mkdir -p /mnt/pCloud
mkdir -p /mnt/Microsoft
mkdir -p /mnt/Jottacloud
mkdir -p /mnt/Dropbox

#chmod 755 /mnt/*

rclone mount --allow-other --vfs-cache-mode full --daemon Box:/FlossWare        /mnt/Box
rclone mount --allow-other --vfs-cache-mode full --daemon OpenDrive:/FlossWare  /mnt/OpenDrive
rclone mount --allow-other --vfs-cache-mode full --daemon Koofr:/FlossWare      /mnt/Koofr
rclone mount --allow-other --vfs-cache-mode full --daemon Yandex:/FlossWare     /mnt/Yandex
rclone mount --allow-other --vfs-cache-mode full --daemon pCloud:/FlossWare     /mnt/pCloud
rclone mount --allow-other --vfs-cache-mode full --daemon Microsoft:/FlossWare  /mnt/Microsoft
rclone mount --allow-other --vfs-cache-mode full --daemon Jottacloud:/FlossWare /mnt/Jottacloud
rclone mount --allow-other --vfs-cache-mode full --daemon Dropbox:/FlossWare    /mnt/Dropbox

# ----------------------------------------------------
# Combine individual drives into one...

mkdir /mnt/Cloud

mergerfs /mnt/Box:/mnt/OpenDrive:/mnt/Koofr:/mnt/Yandex:/mnt/pCloud:/mnt/Microsoft:/mnt/Jottacloud:/mnt/Dropbox /mnt/Cloud

# ----------------------------------------------------

