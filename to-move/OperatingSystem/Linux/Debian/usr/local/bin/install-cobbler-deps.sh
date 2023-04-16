#!/bin/bash

#apt install -y apache2 python3-dev python3-cheetah python3-sphinx python3-coverage openssl apache2-dev python3-setuptools python3-pip python3-distro python3-netaddr python3-simplejson python3-yaml python3-schema libapache2-mod-wsgi-py3 libapache2-mod-proxy-uwsgi 

a2enmod proxy
a2enmod proxy_http
a2enmod rewrite

