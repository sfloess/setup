test -x /usr/sbin/anacron || ( cd / && run-parts --report -v /etc/cron.daily )
