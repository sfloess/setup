#!/bin/sh

log() {
    echo "---------------------------------------" 2>&1 >> /tmp/flossware.log
    echo $@ 2>&1 >> /tmp/flossware.log
    echo "---------------------------------------" 2>&1 >> /tmp/flossware.log
    echo 2>&1 >> /tmp/flossware.log
}

doModProbe() {
    log "Running modprobe..."

    /sbin/modprobe cifs
    /sbin/modprobe isofs
    /sbin/modprobe nfsd
    /sbin/modprobe nfs
    /sbin/modprobe xfs
}

doSwap() {
    log "Enabling swap..."
 
    swapon /tmp/mnt/sda/debian/var/swapfile
}

doMount() {
    log "Mounting dirs..."

    mkdir -p /tmp/mnt/sda

    mount /dev/sda /tmp/mnt/sda
}

doSleep() {
    log "Sleeping 25s..."

    sleep 25s 
}

doBind() {
    log "Binding .ssh dirs..."

    mount /tmp/mnt/sda/debian/root/.ssh /root/.ssh
}

doDebian() {
    log "Starting debian..."

    /tmp/mnt/sda/debian/etc/init.d/debian start
}

startup() {
    doModProbe

    doSleep

    doSwap

    doMount
 
    doBind

    doDebian
}

startup &

