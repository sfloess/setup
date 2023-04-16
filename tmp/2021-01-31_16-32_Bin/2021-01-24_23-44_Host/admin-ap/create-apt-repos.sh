#!/bin/bash

cd /opt/shared/repo/apt

echo

for arch in i386 amd64 mips armel armhf
do	
	printf "%-10s" "${arch}:"
	dpkg-scanpackages -m -a ${arch} pool | gzip > dists/buster/main/binary-${arch}/Packages.gz
done

echo
