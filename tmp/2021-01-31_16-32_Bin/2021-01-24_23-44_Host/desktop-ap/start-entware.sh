#!/bin/sh

# ---------------------------------------------------------------------

mkdir -p /tmp/mnt/sda1/debian_armel/mnt/bedroom-ap/shared

/opt/bin/nfusr nfs://bedroom-ap/tmp/mnt/sda1/debian_armel/mnt/shared  /tmp/mnt/sda1/debian_armel/mnt/bedroom-ap/shared

# ---------------------------------------------------------------------

