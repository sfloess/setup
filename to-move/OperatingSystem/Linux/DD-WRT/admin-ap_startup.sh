log() {
    echo "---------------------------------------" 2>&1 >> /tmp/flossware.log
    echo $@ 2>&1 >> /tmp/flossware.log
    echo "---------------------------------------" 2>&1 >> /tmp/flossware.log
    echo 2>&1 >> /tmp/flossware.log
}

doModProbe() {
    log "Running modprobe..."
    /sbin/modprobe cifs  2>&1 >> /tmp/flossware.log
    /sbin/modprobe isofs 2>&1 >> /tmp/flossware.log
    /sbin/modprobe nfsd  2>&1 >> /tmp/flossware.log
    /sbin/modprobe nfs   2>&1 >> /tmp/flossware.log
    /sbin/modprobe xfs   2>&1 >> /tmp/flossware.log
}

doLocalMount() {
    # Figure out which is the HDD
    df -h | grep sda | grep 931

    if [ $? -eq 0 ]
    then
        export OPT_PARTITION=/dev/sdb1
        export EXPORTS_PARTITION=/dev/sda1
    else
        export OPT_PARTITION=/dev/sda1
        export EXPORTS_PARTITION=/dev/sdb1
    fi

    log "Partition for exports:  [${EXPORTS_PARTITION}]"
    log "Mounting dirs..."

     mkdir -p /opt/exports
     mount ${EXPORTS_PARTITION} /opt/exports 2>&1 >> /tmp/flossware.log

     mkdir -p /opt/debian/exports
     mount ${EXPORTS_PARTITION} /opt/debian/exports 2>&1 >> /tmp/flossware.log
 }

 doRemoteMount() {
     log "Mount remote dirs..."

     #mkdir -p /opt/mnt/amy/exports
     #/bin/mount.cifs //192.168.168.61/exports /opt/mnt/amy/exports -o user='',pass='',vers=2.0 2>&1 >> /tmp/flossware.log

     #mkdir -p /opt/debian/mnt/amy/exports
     #/bin/mount.cifs //192.168.168.61/exports /opt/debian/mnt/amy/exports -o user='',pass='',vers=2.0 2>&1 >> /tmp/flossware.log
}

doMount() {
    doLocalMount
    doRemoteMount
}

doSleep() {
    log "Sleeping 25s..."

    sleep 25s 
}

doEntware() {
    log "Starting Entware..."

    /opt/etc/init.d/rc.unslung start 2>&1 >> /tmp/flossware.log
}

doBind() {
    log "Binding .ssh dirs..." 2>&1 >> /tmp/flossware.log

    mkdir -p /opt/debian/root/.ssh
    mount --rbind /opt/debian/root/.ssh /opt/root/.ssh  2>&1 >> /tmp/flossware.log
    
    mkdir -p /opt/root/.ssh
    mount --rbind /opt/root/.ssh /tmp/root/.ssh         2>&1 >> /tmp/flossware.log

    mkdir -p /opt/exports
    mount --rbind /opt/debian/exports /opt/exports      2>&1 >> /tmp/flossware.log
}

doUnbind() {
    umount /opt/debian/opt
}

doMotd() {
   mount -rbind /opt/debian/exports/FlossWare/public/Common/etc/motd/ddwrt_admin-ap /etc/motd

   ln -s /opt/debian/exports/FlossWare/public/Common/etc/motd/entware_admin-ap /opt/etc/motd
}

startup() {
    doModProbe

    doSleep

    doMount
 
    doEntware

    doBind

    doUnbind

    doMotd
}

startup &