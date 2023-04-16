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

declare -A ENTWARE_EXCLUDES

ENTWARE_EXCLUDES["admin-ap"]="admin-ap"
ENTWARE_EXCLUDES["cloud-ap"]="cloud-ap"
ENTWARE_EXCLUDES["cloud-server"]="cloud-server"

# --------------------------------------------------------------
# If we are found in the excludes array, we are done (aka exit)
# --------------------------------------------------------------

if ["${ENTWARE_EXCLUDES[`hostname`]}" != ""]
then
	echo
	echo "WARNING:  Host excluded per ENTWARE_EXCLUDES"
	echo

	exit 0
fi

# ---------------------------------------------------------------------
# Setup variables for install
# ---------------------------------------------------------------------

ENTWARE_DIR="${HOST_DIR[`hostname`]}/entware"

# --------------------------------------------------------------
# Used to compute download location of Entware install script.
#     https://wiki.dd-wrt.com/wiki/index.php/Installing_Entware
# --------------------------------------------------------------
declare -A ENTWARE_SUB_URL

ENTWARE_SUB_URL["mips"]="mipssf-k3.4"
ENTWARE_SUB_URL["armv7l"]="armv7sf-k3.2"

ENTWARE_INSTALL_SCRIPT="http://bin.entware.net${ENTWARE_SUB_URL[${MACHINE_TYPE}]}/generic.sh"

# --------------------------------------------------------------
# Install Entware as decribed here:
#     https://wiki.dd-wrt.com/wiki/index.php/Installing_Entware
# --------------------------------------------------------------
installEntware() {
    umount /opt

    rm -rf ${ENTWARE_DIR}

    mkdir -p ${ENTWARE_DIR}

    mount -o bind ${ENTWARE_DIR} /opt

    cd ${ENTWARE_DIR}

    wget ${ENTWARE_INSTALL_SCRIPT}
   
    sh ./generic.sh

    opkg update
    opkg upgrade

    opkg install nfusr
}

# --------------------------------------------------------------

installEntware

# --------------------------------------------------------------

