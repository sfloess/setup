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

doSwap() {
    log "Enabling swap..."

    /opt/sbin/swapon /opt/var/swapfile
}

doLocalMount() {
    log "Mounting local dirs..."
}

doRemoteMount() {
     log "Mounting remote dirs..."
}

doMount() {
    #doSwap
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
    log "Binding..."
}

startup() {
    doModProbe

    doMount

    doSleep

    doBind

    doSwap

    doEntware
}

startup &
