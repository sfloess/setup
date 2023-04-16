#!/bin/bash

# https://cobbler.readthedocs.io/en/release28/2_installation/installing%20from%20source.html
# https://cobbler.readthedocs.io/en/release28/2_installation/prerequisites.html#prerequisites

apt install -y createrepo apache2 genisoimage libapache2-mod-wsgi libapache2-mod-gnutls python-cheetah python-netaddr python-simplejson python-urlgrabber python-yaml rsync isolinux atftpd yum-utils

apt install -y git make python-dev python-setuptools python-cheetah openssl

apt install -y python-pip

pip install -y Django

a2enmod proxy
a2enmod proxy_http
a2enmod rewrite

ln -s /srv/tftp /var/lib/tftpboot

chown www-data /var/lib/cobbler/webui_sessions

