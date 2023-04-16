#!/bin/bash

vi /etc/default/grub
grub2-mkconfig -o /boot/grub2/grub.cfg
grep "^menuentry" /boot/grub2/grub.cfg | cut -d "'" -f2
grub2-set-default 'CentOS Linux, with Xen hypervisor'

