#!/bin/bash

apt install -y apache2 python3-dev python3-cheetah python3-sphinx python3-coverage openssl apache2-dev python3-setuptools python3-pip python3-distro python3-netaddr python3-simplejson python3-yaml python3-schema python3-django libapache2-mod-wsgi-py3 libapache2-mod-proxy-uwsgi libosinfo-bin python3-magic python3-dns python3-future python3-netifaces

a2enmod proxy
a2enmod proxy_http
a2enmod rewrite

cd /usr/share/cobbler
ln -s /usr/local/share/cobbler/web
 
