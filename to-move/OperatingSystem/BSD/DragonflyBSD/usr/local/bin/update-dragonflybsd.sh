#!/bin/bash

ssh $* "pkg update ;  pkg upgrade -y ; pkg clean -a -y"
