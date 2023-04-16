#!/bin/sh

# ---------------------------------------------------------------------
# Setup variables for install
# ---------------------------------------------------------------------

MACHINE=`uname -m`

DEBIAN_DIR=/mnt/sda1/debian_${MACHINE}
ENTWARE_DIR=/mnt/sda1/entware

# --------------------------------------------------------------
# Install Entware as define here:
# https://wiki.dd-wrt.com/wiki/index.php/Installing_Entware
# --------------------------------------------------------------
installEntware() {
    umount /opt

    rm -rf ${ENTWARE_DIR}

    mkdir -p ${ENTWARE_DIR}

    mount -o bind ${ENTWARE_DIR} /opt

    cd ${ENTWARE_DIR}

    wget http://bin.entware.net/armv7sf-k3.2/installer/generic.sh
    #wget wget http://bin.entware.net/mipssf-k3.4/installer/generic.sh
   
    sh ./generic.sh

    opkg update
    opkg upgrade

    opkg install nfusr busybox
}

# --------------------------------------------------------------
# Install Debian from our prebuilt root filesystem...
# --------------------------------------------------------------
installDebian() {
    umount ${DEBIAN_DIR}/dev/pts

    umount ${DEBIAN_DIR}/dev
    umount ${DEBIAN_DIR}/proc
    umount ${DEBIAN_DIR}/sys
    umount ${DEBIAN_DIR}/tmp

    # ---------------------------------------------------------------------

    cd /mnt/sda1

    rm -rf debian_armel
    #rm -rf debian_mips

    tar xvf /mnt/smbshare/nas/backups/OperatingSystem/debian-10_armel.tar
    #tar xvf /mnt/smbshare/nas/backups/OperatingSystem/debian-10_mips.tar

    # ---------------------------------------------------------------------

    mkdir -p ${DEBIAN_DIR}/proc ${DEBIAN_DIR}/sys ${DEBIAN_DIR}/dev ${DEBIAN_DIR}/dev/pts ${DEBIAN_DIR}/tmp ${DEBIAN_DIR}/lib/modules/`uname -r`

    # ---------------------------------------------------------------------

    mount -o bind   /dev  ${DEBIAN_DIR}/dev
    mount -o bind   /proc ${DEBIAN_DIR}/proc
    mount -o bind   /sys  ${DEBIAN_DIR}/sys
    mount -o bind   /tmp  ${DEBIAN_DIR}/tmp

    mount -t devpts none  ${DEBIAN_DIR}/dev/pts

    # ---------------------------------------------------------------------

    cp /etc/mtab ${DEBIAN_DIR}/etc/mtab
    cp /etc/mtab ${DEBIAN_DIR}/etc/fstab

    # ---------------------------------------------------------------------

    rm -rf ${DEBIAN_DIR}/lib/modules/*                                        
    cp -rf /lib/modules/`uname -r` ${DEBIAN_DIR}/lib/modules/  

    # ---------------------------------------------------------------------

    mkdir -p ${DEBIAN_DIR}/lib/arm-linux-gnueabi
                                                                        
    # ---------------------------------------------------------------------

    # When chroot'ing in, we don't want the DD-WRT value, so unsetting...
    unset LD_LIBRARY_PATH

    chroot ${DEBIAN_DIR} apt-get update -y
    chroot ${DEBIAN_DIR} apt-get upgrade -y
    chroot ${DEBIAN_DIR} apt-get dist-upgrade -y
    
    # ---------------------------------------------------------------------

    chroot ${DEBIAN_DIR} apt-get install -y htop lsb-release ntpdate rsync screen sudo vim rsyslog ntp cron rpcbind postfix nis ssh

    cp -rf /mnt/smbshare/Development/github/sfloess/dd-wrt/config/etc     ${DEBIAN_DIR}
    cp -rf /mnt/smbshare/Development/github/sfloess/dd-wrt/`hostname`/etc ${DEBIAN_DIR}

    cat  /mnt/smbshare/Development/github/sfloess/dd-wrt/config/crontab | crontab -

    # ---------------------------------------------------------------------

    rm -rf ${DEBIAN_DIR}/root/.ssh ${DEBIAN_DIR}/root/.bashrc ${DEBIAN_DIR}/home

    ln -s /mnt/admin-ap/root/Development ${DEBIAN_DIR}/root/Development
    ln -s /mnt/admin-ap/root/.screenrc   ${DEBIAN_DIR}/root/.screenrc
    ln -s /mnt/admin-ap/root/.ssh        ${DEBIAN_DIR}/root/.ssh
    ln -s /mnt/admin-ap/root/.bashrc     ${DEBIAN_DIR}/root/.bashrc
    ln -s /mnt/admin-ap/home             ${DEBIAN_DIR}/home

    # ---------------------------------------------------------------------

    umount ${DEBIAN_DIR}/dev/pts
    umount ${DEBIAN_DIR}/dev
    umount ${DEBIAN_DIR}/proc
    umount ${DEBIAN_DIR}/sys
    umount ${DEBIAN_DIR}/tmp
}

# --------------------------------------------------------------

installEntware
installDebian

# --------------------------------------------------------------

