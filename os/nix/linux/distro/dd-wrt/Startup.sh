# ----------------------------------------------------------------
# Sample "base" startup script for dd-wrt devices
# ----------------------------------------------------------------

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
    log "Mounting local dirs..."
}

doRemoteMount() {
     log "Mounting remote dirs..."
}

doMount() {
    doLocalMount
    doRemoteMount
}

doSleep() {
    log "Sleeping 25s..."

    sleep 25s 
}

doBind() {
    log "Binding..."
}

doSwap() {
    log "Enabling swap..."
}

doEntware() {
    log "Starting Entware..."
}

doDebian() {
    log "Starting Debian..."
}

startup() {
    doModProbe

    doMount

    doSleep

    doBind

    doSwap

    doEntware

    doDebian
}

startup &