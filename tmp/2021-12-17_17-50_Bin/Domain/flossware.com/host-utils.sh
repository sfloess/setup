#!/bin/bash

# ------------------------------------------------

declare -A mac

mac["bluray"]=54:53:ED:D7:FC:B8
mac["amh"]=24:FD:52:B8:A7:84
mac["admin-clouc"]=08:00:27:9B:DF:13
mac["amy-wireless"]=F8:0F:41:8D:A7:5B
mac["amamda-cell"]=5C:0A:5B:B4:31:6E
mac["sfloess-cell"]=5C:0A:5B:84:D3:A7
mac["amanda-tablet"]=D8:71:57:09:10:5D
mac["dev-tablet"]=D8:71:57:09:0F:4B
mac["reading-tablet"]=D8:71:57:09:12:A4
mac["dev-tablet"]=14:D6:4D:4A:AA:B0
mac["cloud-server"]=14:D6:4D:4A:AA:B0
mac["laptop-01"]=00:8c:fa:2d:45:05
mac["cloud-host-01"]=00:19:B9:1F:34:B6
mac["cloud-host-02"]=00:21:9B:32:5F:78
mac["polycom"]=00:04:F2:AF:53:BB
mac["redhat-laptop"]=c8:5b:76:b5:43:f9
mac["redhat-laptop-wireless"]=f4:8c:50:0a:81:97
mac["fedora-workstation"]=52:54:00:62:d7:a8
mac["fefora-workstation-xen"]=00:16:3e:4f:0c:d1
mac["cobbler-xen"]=00:16:3e:45:41:11
mac["pi-01"]=b8:27:eb:14:fc:7d
mac["pi-02"]=b8:27:eb:b6:a5:b0
mac["debian"]=52:54:00:93:9b:f7
mac["redhat-activemq"]=00:16:3e:2f:f2:94

# ------------------------------------------------

declare -A ip

ip["bluray"]=192.168.168.11
ip["amh"]=192.168.168.21
ip["admin-clouc"]=192.168.168.22
ip["amy-wireless"]=192.168.168.23
ip["amamda-cell"]=192.168.168.24
ip["sfloess-cell"]=192.168.168.26
ip["amanda-tablet"]=192.168.168.27
ip["dev-tablet"]=192.168.168.28
ip["reading-tablet"]=192.168.168.29
ip["dev-tablet"]=192.168.168.31
ip["cloud-server"]=192.168.168.31
ip["laptop-01"]=192.168.168.32
ip["cloud-host-01"]=192.168.168.33
ip["cloud-host-02"]=192.168.168.34
ip["polycom"]=192.168.168.36
ip["redhat-laptop"]=192.168.168.38
ip["redhat-laptop-wireless"]=192.168.168.39
ip["fedora-workstation"]=192.168.168.74
ip["fefora-workstation-xen"]=192.168.168.75
ip["cobbler-xen"]=192.168.168.76
ip["pi-01"]=192.168.168.79
ip["pi-02"]=192.168.168.80
ip["debian"]=192.168.168.84
ip["redhat-activemq"]=192.168.168.100

# ------------------------------------------------

declare -A aka

aka["admin-ap"]="mail ntp fileserver nas plex"
aka["cloud-server"]="cobbler yum apt ansible puppet"
aka["pi-02"]="dev-server jenkins archiva"

# ------------------------------------------------

#echo "${mac[@]}"
#echo "${!mac[@]}"

# ------------------------------------------------

