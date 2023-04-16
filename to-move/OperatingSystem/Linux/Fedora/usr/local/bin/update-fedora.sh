#!/bin/bash

ssh $* "dnf check-update ; dnf update -y --nogpgcheck ; dnf upgrade --nogpgcheck  ; dnf clean all"
