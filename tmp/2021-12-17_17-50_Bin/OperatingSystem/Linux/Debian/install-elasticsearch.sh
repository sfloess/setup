#!/bin/bash

mkdir -p /usr/share/elasticsearch
cd /usr/share/elasticsearch
wget https://packages.elastic.co/GPG-KEY-elasticsearch
apt-get install elasticsearch
# This retrieves the latest ElasticSearch package for our use and installs it
 
vi /etc/elasticsearch/elasticsearch.yml
