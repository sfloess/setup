#!/bin/bash

ssh admin-ap mkdir -p /exports/FlossWare

rsync -av --delete --exclude .git `dirname ${BASH_SOURCE[0]}`/* admin-ap:/exports/FlossWare/public
#rsync -av --delete /exports/FlossWare/private admin-ap:/exports/FlossWare

rsync -av --delete --exclude .git `dirname ${BASH_SOURCE[0]}`/* server-ap:/exports/FlossWare/public
rsync -av --delete /exports/FlossWare/private server-ap:/exports/FlossWare

