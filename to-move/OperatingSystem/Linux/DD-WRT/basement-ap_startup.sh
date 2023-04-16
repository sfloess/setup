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
    echo "Mounting local dirs..." >> /tmp/flossware.log

    #mkdir -p /mnt/sdb1
    #mount -t ext2 /dev/sdb2 /mnt/sdb2 2>&1 >> /tmp/flossware.log

    mkdir -p /opt/mnt/sdb1
    mount --rbind /tmp/mnt/sdb1 /opt/mnt/sdb1  2>&1 >> /tmp/flossware.log

    mkdir -p /opt/debian/mnt/sdb1
    mount --rbind /tmp/mnt/sdb1 /opt/debian/mnt/sdb1  2>&1 >> /tmp/flossware.log
}

doRemoteMount() {
    log "Mount remote dirs..."

 #   mkdir -p /opt/debian/mnt/admin-ap/exports
 #   mkdir -p /opt/debian/mnt/desktop-ap/exports
  
 #   mount.cifs -o guest,nodfs,sec=ntlm //admin-ap/exports   /opt/debian/mnt/admin-ap/exports   2>&1 >> /tmp/flossware.log
 #   mount.cifs -o guest,nodfs,sec=ntlm //desktop-ap/exports /opt/debian/mnt/desktop-ap/exports 2>&1 >> /tmp/flossware.log
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

start() {
    doModProbe

    doSleep

    doMount
 
    doEntware

    doBind

    doUnbind

    doMotd
}

start