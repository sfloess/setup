#!/bin/sh

# ---------------------------------------------------------------------

ENTWARE_DIR=/mnt/sda1/entware
DEBIAN_DIR=/mnt/sda1/debian_armel

NFS_DIRS='root home opt/backups opt/media opt/nas opt/shared'

# ---------------------------------------------------------------------

mountEntwareDirs() {
    modprobe fuse
    insmod   fuse

    for nfsDir in ${NFS_DIRS}
    do
	MOUNT_DIR=${DEBIAN_DIR}/mnt/admin-ap/`basename ${nfsDir}`

	mkdir -p ${MOUNT_DIR}

        /opt/bin/nfusr nfs://admin-ap/${nfsDir} ${MOUNT_DIR}
    done
}

startEntwareApps() {
    if [ -e `dirname $0`/`hostname`/start-entware.sh ]
    then
        `dirname $0`/`hostname`/start-entware.sh >> /tmp/flossware.log 2>&1
    else
	echo "No entware script for host:  `dirname $0`/`hostname`/start-entware.sh" >> /tmp/flossware.log 2>&1
    fi
}

startEntware() {
    mount -o bind ${ENTWARE_DIR} /opt

    /opt/etc/init.d/rc.unslung start

    mountEntwareDirs

    startEntwareApps
}

# ---------------------------------------------------------------------

mountDebianDirs() {
    mount -o bind   /dev  ${DEBIAN_DIR}/dev
    mount -o bind   /proc ${DEBIAN_DIR}/proc
    mount -o bind   /sys  ${DEBIAN_DIR}/sys
    mount -o bind   /tmp  ${DEBIAN_DIR}/tmp

    mount -t devpts none  ${DEBIAN_DIR}/dev/pts

    mkdir -p ${DEBIAN_DIR}/mnt/`hostname`
    mount -o bind / ${DEBIAN_DIR}/mnt/`hostname`
}

copyDebianFiles() {
    cp /etc/mtab ${DEBIAN_DIR}/etc/mtab
    cp /etc/mtab ${DEBIAN_DIR}/etc/fstab

    rm -rf ${DEBIAN_DIR}/lib/modules/*                                        
    cp -rf /lib/modules/`uname -r` ${DEBIAN_DIR}/lib/modules/  
}

startDebianApps() {
    if [ -e ${DEBIAN_DIR}/mnt/admin-ap/root/Development/github/sfloess/dd-wrt/`hostname`/start-debian.sh ]
    then
        /usr/sbin/chroot ${DEBIAN_DIR} /mnt/admin-ap/root/Development/github/sfloess/dd-wrt/`hostname`/start-debian.sh >> /tmp/flossware.log 2>&1
    else
	echo "No debian script for host:  ${DEBIAN_DIR}/mnt/admin-ap/root/Development/github/sfloess/dd-wrt/`hostname`/start-debian.sh" >> /tmp/flossware.log
    fi
}

startDebian() {
    mountDebianDirs
    copyDebianFiles

    startDebianApps
}

# --------------------------------------------------------------

echo "`dirname $0`/`hostname`/start-entware.sh" >> /tmp/flossware.log
echo "${DEBIAN_DIR}/mnt/admin-ap/root/Development/github/sfloess/dd-wrt/`hostname`/start-debian.sh" >> /tmp/flossware.log

mount /dev/sda1 /mnt/sda1 >> /tmp/flossware.log 2>&1

startEntware >> /tmp/flossware.log 2>&1
startDebian  >> /tmp/flossware.log 2>&1

# --------------------------------------------------------------

