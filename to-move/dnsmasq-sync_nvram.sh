#!/bin/bash

ssh -p 2222 admin-ap nvram get dnsmasq_options | dos2unix > Common/etc/dnsmasq.conf

