#!/bin/bash

#
# This file is part of the Scot P. Floess family of personal 
# open source software.
#
# This is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 3
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA
#

# ---------------------------------------------------------------------

. `dirname ${BASH_SOURCE[0]}`/defs.sh

# --------------------------------------------------------------
# Denote all the embedded machines we have that should not have
# Entware installed on.
# --------------------------------------------------------------

declare -a DEBIAN_EXCLUDES

DEBIAN_EXCLUDES["den-ap"]="den-ap"

# --------------------------------------------------------------
# If we are found in the excludes array, we are done (aka exit)
# --------------------------------------------------------------

if ["${DEBIAN_EXCLUDES[`hostname`]}" != ""]
then
	echo
	echo "WARNING:  Host excluded per DEBIAN_EXCLUDES"
	echo

	exit 0
fi

# ---------------------------------------------------------------------
# Setup variables for install
# ---------------------------------------------------------------------

DEBIAN_DIR="${HOST_DIR[`hostname`]}/debian"

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

    rm -rf ${DEBIAN_DIR}

    tar xvf /mnt/smbshare/nas/backups/OperatingSystem/debian-10_$HOST_HARDWARE[`hostname`].tar

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

    #mkdir -p ${DEBIAN_DIR}/lib/arm-linux-gnueabi
                                                                        
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

installDebian

# --------------------------------------------------------------

