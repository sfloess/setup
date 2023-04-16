#!/bin/bash

apt-get autoremove --purge -y

#apt-get --allow-unauthenticated update  -y
#apt-get --allow-unauthenticated upgrade -y

apt-get -o Acquire::AllowInsecureRepositories=true -o Acquire::AllowDowngradeToInsecureRepositories=true update  -y --allow-unauthenticated
apt-get -o Acquire::AllowInsecureRepositories=true -o Acquire::AllowDowngradeToInsecureRepositories=true upgrade -y --allow-unauthenticated

apt-get clean
