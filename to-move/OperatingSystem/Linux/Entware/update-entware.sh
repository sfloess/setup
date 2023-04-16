#!/bin/sh

ssh $* "opkg update ; opkg upgrade"
