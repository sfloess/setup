#!/bin/bash

cd /root

sync && echo 3 > /proc/sys/vm/drop_caches

echo "testing writes..."
dd if=/dev/zero of=./largefile bs=1M count=1024

sync && echo 3 > /proc/sys/vm/drop_caches

echo "testing reads..."
dd if=./largefile of=/dev/null bs=4k

rm ./largefile
