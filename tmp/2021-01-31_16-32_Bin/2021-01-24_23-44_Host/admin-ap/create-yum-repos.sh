#!/bin/bash

export REPO_HOME='/opt/shared/repo/yum'

for aDir in ${REPO_HOME}/*
do
	echo $aDir
	cd $aDir
	createrepo .
	echo
done
