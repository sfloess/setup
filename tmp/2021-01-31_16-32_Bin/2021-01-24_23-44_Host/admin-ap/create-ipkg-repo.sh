#!/bin/bash

cd /opt/shared/repo/ipkg

opkg-make-index -a -v -p Packages .
