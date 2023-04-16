#!/bin/bash

apt-get install -y apt-transport-https
#echo “deb https://artifacts.elastic.co/packages/5.x/apt stable main” | sudo tee -a /etc/apt/sources.list.d/elastic-5.x.list
apt-get install -y ruby
apt-get -y update
#apt-get -y install logstash
apt-get -y install /mnt/admin-ap/backups/software/deb/logstash-6.5.4.deb
systemctl start logstash
