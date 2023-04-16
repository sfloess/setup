#!/bin/bash

set-crond-permissions() {
	chmod 0444 /etc/logrotate.conf 	/etc/logrotate.d/*  	&>/dev/null
	chmod 0444 /etc/cron.d       	/etc/cron.d/*		&>/dev/null
	chmod 0444 /etc/cron.daily   	/etc/cron.daily/*	&>/dev/null
	chmod 0444 /etc/cron.hourly  	/etc/cron.hourly/*	&>/dev/null
	chmod 0444 /etc/cron.monthly 	/etc/cron.monthly/*	&>/dev/null
	chmod 0444 /etc/cron.weekly  	/etc/cron.weekly/*	&>/dev/null
}

set-crond-permissions

