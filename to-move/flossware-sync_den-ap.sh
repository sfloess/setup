#!/bin/bash

if [ "`hostname`" = "admin-ap" ]
then
    RESULT_DIR=/exports/FlossWare/public
else
    RESULT_DIR=/opt/exports/FlossWare/public
fi

mkdir -p ${RESULT_DIR}

rsync -av --delete --exclude .git `dirname ${BASH_SOURCE[0]}`/* ${RESULT_DIR}/

