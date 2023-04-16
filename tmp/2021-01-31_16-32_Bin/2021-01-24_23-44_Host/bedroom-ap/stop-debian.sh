#!/bin/bash

/bin/fusermount -u /mnt/cloud/Box
/bin/fusermount -u /mnt/cloud/Dropbox
/bin/fusermount -u /mnt/cloud/Google
/bin/fusermount -u /mnt/cloud/Jottacloud
/bin/fusermount -u /mnt/cloud/Microsoft
/bin/fusermount -u /mnt/cloud/OpenDrive
/bin/fusermount -u /mnt/cloud/Yandex
/bin/fusermount -u /mnt/cloud/pCloud

/etc/init.d/ssh        stop
/etc/init.d/nis        stop
/etc/init.d/postfix    stop
/etc/init.d/rpcbind    stop
/etc/init.d/cron       stop
/etc/init.d/ntp        stop
/etc/init.d/rsyslog    stop

