#!/bin/sh

# ---------------------------------------------------------------------

insmod /lib/modules/3.18.140/fuse.ko
insmod fuse

# ---------------------------------------------------------------------

mkdir -p /tmp/mnt/nfs/bedroom-ap/Cloud

fusermount -u /tmp/mnt/nfs/bedroom-ap/Cloud

/opt/bin/nfusr nfs://bedroom-ap/tmp/mnt/sda1/debian_armel/mnt/Cloud /tmp/mnt/nfs/bedroom-ap/Cloud

# ---------------------------------------------------------------------

