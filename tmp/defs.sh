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
# Setup variables for install.
# ---------------------------------------------------------------------

MACHINE_TYPE=`uname -m`

# --------------------------------------------------------------
# Hosts definitions.
# --------------------------------------------------------------

declare -A HOSTS

HOSTS["gateway"]="gateway"
HOSTS["admin-ap"]="admin-ap"
HOSTS["cloud-ap"]="cloud-ap"
HOSTS["desktop-ap"]="desktop-ap"
HOSTS["bedroom-ap"]="bedroom-ap"
HOSTS["den-ap"]="den-ap"

HOSTS["nvr"]="nvr"
HOSTS["bluray"]="bluray"
HOSTS["samsung-tv"]="samsung-tv"
HOSTS["bedroom-av"]="bedroom-av"
HOSTS["amy-wireless"]="amy-wireless"
HOSTS["amy"]="amy"
HOSTS["amanda-cell"]="amanda-cell"
HOSTS["sfloess-cell"]="sfloess-cell"
HOSTS["amanda-tablet"]="amanda-tablet"
HOSTS["tablet-01"]="tablet-01"
HOSTS["tablet-02"]="tablet-02"
HOSTS["laptop-01"]="laptop-01"
HOSTS["cloud-server"]="cloud-server"
HOSTS["cloud-host-01"]="cloud-host-01"
HOSTS["cloud-host-02"]="cloud-host-02"

HOSTS["polycom"]="polycom"
HOSTS["redhat-laptop"]="redhat-laptop"
HOSTS["redhat-laptop-wireless"]="redhat-laptop-wireless"

HOSTS["workstation"]="workstation"
HOSTS["pi-01"]="pi-01"
HOSTS["pi-02"]="pi-02"
HOSTS["debian"]="debian"

HOSTS["redhat-server-01"]="redhat-server-01"
HOSTS["redhat-server-02"]="redhat-server-02"
HOSTS["redhat-server-03"]="redhat-server-03"
HOSTS["redhat-server-04"]="redhat-server-04"
HOSTS["redhat-test"]="redhat-test"

HOSTS["jenkins-slave"]="jenkins-slave"
HOSTS["controller"]="controller"

# --------------------------------------------------------------
# Host aliases.
# --------------------------------------------------------------

declare -A HOST_ALIAS

HOST_ALIAS["admin-ap"]="mail/ntp/fileserver/nas/plex"
HOST_ALIAS["cloud-ap"]="dv/elasticsearch/postgres/maria"
HOST_ALIAS["bedroom-ap"]="backup-server"
HOST_ALIAS["den-ap"]="backup-server/www/yum/apt/ipkg"

HOST_ALIAS["cloud-server"]="cobbler/ansible/puppet"

HOST_ALIAS["pi-01"]="logstash"
HOST_ALIAS["pi-02"]="jenkins/archiva/activemq"

HOST_ALIAS["controller"]="kibana/cerebro/jmeter"

# --------------------------------------------------------------
# Host IP addresses
# --------------------------------------------------------------

declare -A HOST_IP

HOST_IP["gateway"]="192.168.0.1"
HOST_IP["admin-ap"]="192.168.168.2"
HOST_IP["cloud-ap"]="192.168.168.3"
HOST_IP["desktop-ap"]="192.168.168.4"
HOST_IP["bedroom-ap"]="192.168.168.5"
HOST_IP["den-ap"]="192.168.168.6"

HOST_IP["nvr"]="192.168.168.8"
HOST_IP["bluray"]="192.168.168.11"
HOST_IP["samsung-tv"]="192.168.168.13"
HOST_IP["bedroom-av"]="192.168.168.14"
HOST_IP["amy-wireless"]="192.168.168.21"
HOST_IP["amy"]="192.168.168.23"
HOST_IP["amanda-cell"]="192.168.168.24"
HOST_IP["sfloess-cell"]="192.168.168.26"
HOST_IP["amanda-tablet"]="192.168.168.27"
HOST_IP["tablet-01"]="192.168.168.28"
HOST_IP["tablet-02"]="192.168.168.29"
HOST_IP["laptop-01"]="192.168.168.31"
HOST_IP["cloud-server"]="192.168.168.32"
HOST_IP["cloud-host-01"]="192.168.168.33"
HOST_IP["cloud-host-02"]="192.168.168.34"

HOST_IP["polycom"]="192.168.168.36"
HOST_IP["redhat-laptop"]="192.168.168.38"
HOST_IP["redhat-laptop-wireless"]="192.168.168.39"

HOST_IP["workstation"]="192.168.168.74"
HOST_IP["pi-01"]="192.168.168.79"
HOST_IP["pi-02"]="192.168.168.80"
HOST_IP["debian"]="192.168.168.84"

HOST_IP["redhat-server-01"]="192.168.168.100"
HOST_IP["redhat-server-02"]="192.168.168.101"
HOST_IP["redhat-server-03"]="192.168.168.102"
HOST_IP["redhat-server-04"]="192.168.168.103"
HOST_IP["redhat-test"]="192.168.168.104"

HOST_IP["jenkins-slave"]="192.168.168.127"
HOST_IP["controller"]="192.168.168.128"

# --------------------------------------------------------------
# Host MAC addresses
# --------------------------------------------------------------

declare -A HOST_MAC

HOST_MAC["gateway"]=""
HOST_MAC["admin-ap"]="x2"
HOST_MAC["cloud-ap"]=""
HOST_MAC["desktop-ap"]=""
HOST_MAC["bedroom-ap"]=""
HOST_MAC["den-ap"]=""

HOST_MAC["nvr"]="9c:a3:a9:d9:a5:fa"
HOST_MAC["bluray"]="54:53:ED:D7:FC:B8"
HOST_MAC["samsung-tv"]=""
HOST_MAC["bedroom-av"]=""
HOST_MAC["amy-wireless"]=""
HOST_MAC["amy"]="24:FD:52:B8:A7:84"
HOST_MAC["amanda-cell"]="5C:0A:5B:B4:31:6E"
HOST_MAC["sfloess-cell"]="5C:0A:5B:84:D3:A7"
HOST_MAC["amanda-tablet"]="D8:71:57:09:10:5D"
HOST_MAC["tablet-01"]="D8:71:57:09:0F:4B"
HOST_MAC["tablet-02"]="D8:71:57:09:12:A4"
HOST_MAC["laptop-01"]="00:8c:fa:2d:45:05"
HOST_MAC["cloud-server"]="14:D6:4D:4A:AA:B0"
HOST_MAC["cloud-host-01"]="00:19:B9:1F:34:B6"
HOST_MAC["cloud-host-02"]="00:21:9B:32:5F:78"

HOST_MAC["polycom"]="00:04:F2:AF:53:BB"
HOST_MAC["redhat-laptop"]="c8:5b:76:b5:43:f9"
HOST_MAC["redhat-laptop-wireless"]="f4:8c:50:0a:81:97"

HOST_MAC["workstation"]="52:54:00:62:d7:a8"
HOST_MAC["pi-01"]="b8:27:eb:14:fc:7d"
HOST_MAC["pi-02"]="b8:27:eb:b6:a5:b0"
HOST_MAC["debian"]="52:54:00:2e:d0:38"

HOST_MAC["redhat-server-01"]="00:16:3e:15:ec:a7"
HOST_MAC["redhat-server-02"]="00:16:3e:77:a9:ca"
HOST_MAC["redhat-server-03"]="00:16:3e:01:9a:3e"
HOST_MAC["redhat-server-04"]="00:16:3e:01:0c:a2"
HOST_MAC["redhat-test"]="00:16:3e:21:01:37"

HOST_MAC["jenkins-slave"]="00:16:3e:6f:bf:04"
HOST_MAC["controller"]="00:16:3e:7c:d0:70"

# --------------------------------------------------------------
# Various servers
# --------------------------------------------------------------

GATEWAY_IP=${HOST_IP["admin-ap"]}
NTP_IP=${HOST_IP["admin-ap"]}
TFP_IP=${HOST_IP["cloud-server"]}
TFP_HOST=${HOST["cloud-server"]}

DOMAIN_NAME="flossware.com"

# --------------------------------------------------------------
# DHCP options
# --------------------------------------------------------------

DHCP_OPTION_GATEWAY=3
DHCP_OPTION_DOMAIM=40
DHCP_OPTION_NTP=42
DHCP_OPTION_TFP=66

declare -A DHCP_OPTION

DHCP_OPTION[${DHCP_OPTION_GATEWAY}]=${GATEWAY_IP}
DHCP_OPTION[${DHCP_OPTION_DOMAIN}]=${DOMAIN_NAME}
DHCP_OPTION[${DHCP_OPTION_NTP}]=${NTP_IP}
DHCP_OPTION[${DHCP_OPTION_TFP}]=${TFTP_IP}

# --------------------------------------------------------------
# DHCP items
# --------------------------------------------------------------

declare -A DHCP_ITEM

DHCP_ITEM["dhcp-range"]="192.168.168.150,192.168.168.253,255.255.255.0,3600s"
DHCP_ITEM["dhcp-boot"]="pxelinux.0,${TFTP_HOST},${TFTP_IP}"
DHCP_ITEM["dhcp-authoritative"]=""
DHCP_ITEM["expand-hosts"]=""
DHCP_ITEM["log-queries"]=""
DHCP_ITEM["log-dhcp"]=""

# --------------------------------------------------------------
# Host dir where things are run and installed to/from.
# --------------------------------------------------------------

ALT_F_DIR="/mnt/mda0"
DD_WRT_DIR="/tmp/mnt/sda0"
OPEN_WRT_DIR="/tmp/mnt/sda1"

declare -A HOST_DIR

HOST_DIR["admin-ap"]="${OPEN_WRT_DIR}"
HOST_DIR["cloud-ap"]="${OPEN_WRT_DIR}"
HOST_DIR["desktop-ap"]="${DD_WRT_DIR}"
HOST_DIR["bedroom-ap"]="${DD_WRT_DIR}"
HOST_DIR["den-ap"]="${DD_WRT_DIR}"
HOST_DIR["cloud-server"]="${ALT_F_DIR}"

# --------------------------------------------------------------
# Host dir where things are run and installed to/from.
# --------------------------------------------------------------

ARMEL_HOST="armel"
ARMHF_HOST="armhf"
AMRV5_TEL_HOST="armv5tel"

declare -A HOST_HARDWARE

HOST_HARDWARE["admin-ap"]="${ARMHF_HOST}"
HOST_HARDWARE["cloud-ap"]="${ARMHF_HOST}"
HOST_HARDWARE["desktop-ap"]="${ARMEL_HOST}"
HOST_HARDWARE["bedroom-ap"]="${ARMEL_HOST}"
HOST_HARDWARE["cloud-server"]="${AMRV5_TEL_HOST}"

# --------------------------------------------------------------
# The /etc/init.d startup/shutdown scripts
# --------------------------------------------------------------

declare -A HOST_INIT

HOST_INIT["bedroom-ap"]="rsyslog ntp cron rpcbind postfix nis ssh"

# --------------------------------------------------------------

