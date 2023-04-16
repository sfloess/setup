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

doSleep() {
    log "Sleeping 25s..."
                                                                                                                                                                   
    sleep 25s 
}

doMount() {
    log "Mounting dirs..."

     mkdir -p /tmp/mnt/sda1
     mount -t xfs /dev/sda1 /tmp/mnt/sda1 2>&1 >> /tmp/flossware.log

     mkdir -p /tmp/mnt/sdb1
     mount -t xfs /dev/sdb1 /tmp/mnt/sdb1 2>&1 >> /tmp/flossware.log                                                                                                                                                                                         
}

doBind() {
    log "Binding dirs..."

    mount --rbind /tmp/mnt/sda1/debian/root/.ssh /tmp/root/.ssh  2>&1 >> /tmp/flossware.log

    mkdir -p /tmp/mnt/sda1/debian/desktop-ap/sda
    mount --rbind /tmp/mnt/sda1 /tmp/mnt/sda/debian/desktop-ap/sda 2>&1 >> /tmp/flossware.log

    mkdir -p /tmp/mnt/sda1/debian/mnt/desktop-ap/sdb
    mount --rbind /tmp/mnt/sda1 /tmp/mnt/sda/debian/desktop-ap/sdb 2>&1 >> /tmp/flossware.log
}

doMount1() {
    log "Mounting dirs..."

     mkdir -p /tmp/mnt/sda1
     mount -t xfs /dev/sda1 /tmp/mnt/sda1 2>&1 >> /tmp/flossware.log

     mkdir -p /tmp/mnt/sdb1
     mount -t xfs /dev/sdb1 /tmp/mnt/sdb1 2>&1 >> /tmp/flossware.log

     mkdir -p /tmp/mnt/sda1/debian/desktop-ap/sda
     mount -t xfs /dev/sda1 /tmp/mnt/sda/debian/mnt/desktop-ap/sda 2>&1 >> /tmp/flossware.log

     mkdir -p /tmp/mnt/sda1/debian/mnt/desktop-ap/sdb
     mount -t xfs /dev/sdb1 /tmp/mnt/sda/debian/mnt/desktop-ap/sdb 2>&1 >> /tmp/flossware.log                                                                                                                                                                                             
}

doBind1() {
    log "Binding dirs..."

#    mkdir -p /opt
#    mount --rbind /tmp/mnt/sda /opt   2>&1 >> /tmp/flossware.log

#    mount --rbind /opt/debian/root/.ssh /opt/root/.ssh  2>&1 >> /tmp/flossware.log
    mount --rbind /tmp/mnt/sda1/debian/root/.ssh /tmp/root/.ssh  2>&1 >> /tmp/flossware.log

#    mount --rbind /opt/debian/exports /opt/exports      2>&1 >> /tmp/flossware.log

#   mkdir -p /opt/debian/mnt/desktop-ap/sda
#    mount --rbind /tmp/mnt/sda /opt/debian/desktop-ap/mnt/desktop-ap/sda   2>&1 >> /tmp/flossware.log

#    mkdir -p /opt/debian/mnt/desktop-ap/sdb
#    mount --rbind /tmp/mnt/sdb /opt/debian/mnt/desktop-ap/sdb   2>&1 >> /tmp/flossware.log
}

doEntware() {
    log "Starting Entware..."

    /opt/etc/init.d/rc.unslung start 2>&1 >> /tmp/flossware.log
}

start() {
    doModProbe

    doSleep

    doMount

    doBind

#    doEntware
}

start &

# -------------------------------------------------------------------------
# This was in the debian startup script

        #mkdir -p ${CHROOT_DIR}/exports
        #mount -o bind /tmp/mnt/sda1/exports ${CHROOT_DIR}/exports

        #mkdir -p /root/.ssh
        #mount -o bind ${CHROOT_DIR}/root/.ssh /root/.ssh

# -------------------------------------------------------------------------
