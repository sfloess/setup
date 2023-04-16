#!/bin/sh

# Based on the script from https://github.com/DontBeAPadavan/chroot-debian
# umount (3 times with different flags) is from Qdebian.qpkd (qnapclub)

# Debian folder
CHROOT_DIR=`readlink -f /tmp/mnt/sda1/debian`

CHROOT_SERVICES_LIST=/tmp/mnt/sda1/dd-wrt/chroot-services.list

CHROOT_BIN=`which chroot`

MountedDirCount="$(/bin/mount | grep $CHROOT_DIR | wc -l)"

start() {
	if [ -f /etc/hosts ]; then
		cp /etc/hosts $CHROOT_DIR/etc/hosts
	fi
	
	if [ -f /etc/resolve.conf ]; then
		cp /etc/resolve.conf $CHROOT_DIR/etc/resolve.conf
	fi

	echo 'Starting Debian services...'
	for dir in dev dev/pts proc sys; do
		/bin/mount -o bind /$dir $CHROOT_DIR/$dir
		sleep 2
	done
	
	#mkdir -p /root/.ssh 
	#mount -o bind ${CHROOT_DIR}/root/.ssh /root/.ssh
	
	if [ ! -e "$CHROOT_SERVICES_LIST" ]; then
		echo 'WARNING: No Debian services defined.'
		echo "Please, define Debian services to start in $CHROOT_SERVICES_LIST file!"
		echo 'One service per line. Hint: these are script names from Debian /etc/init.d/'
	else
		for item in $(cat $CHROOT_SERVICES_LIST); do
			PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
			LC_ALL=C \
			LANGUAGE=C \
			LANG=C \
			$CHROOT_BIN $CHROOT_DIR /etc/init.d/$item start
		done
	fi
}

stop() {
	if [ -e "$CHROOT_SERVICES_LIST" ]; then
		echo 'Stopping Debian services...'
		for item in $(cat $CHROOT_SERVICES_LIST); do
			PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
			LC_ALL=C \
			LANGUAGE=C \
			LANG=C \
			$CHROOT_BIN $CHROOT_DIR /etc/init.d/$item stop
		done
	fi
	
	# device can be unstable in case we do not unmount properly
	#so we try to umount 3 times
	sleep 1
	for dir in dev/pts dev proc sys; do
		/bin/umount $CHROOT_DIR/$dir 2>/dev/null
		sleep 2
	done
	
#	umount /root/.ssh
#	umount ${CHROOT_DIR}/exports/sda1
	
	for dir in dev/pts dev proc sys; do
		/bin/umount -lf $CHROOT_DIR/$dir 2>/dev/null
		sleep 2
	done
	
	for dir in dev/pts dev proc sys; do
		/bin/umount -l $CHROOT_DIR/$dir 2>/dev/null
		sleep 2
	done
}

status() {
	if [ $MountedDirCount -gt 0 ]; then
		echo 'Debian services are running'
	else
		echo 'Debian services are stopped'
	fi
}

case "$1" in
	start)
		start
	;;
	stop)
		stop
	;;
	restart)
		stop
		sleep 5
		start
	;;
	status)
		status
	;;
	*)
		echo "Usage: $0 (start|stop|restart|status)"
		exit 1
		;;
esac
