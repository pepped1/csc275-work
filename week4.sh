#!/bin/bash

if [[ "${#}" -lt 4 ]]
then
 echo "Guide: ${0} DIRECTORY_NAME SUBFOLDER_PREFIX SUBFOLDER_NUM FILE..."
 exit 1
fi

DIRNAME=${1}
PREFIX=${2}
SUBCOUNT=${3}

shift && shift && shift

if [[ ! -d "./${DIRNAME}" ]]
then
 mkdir ${DIRNAME}
fi
cd ${DIRNAME}

i=1
while [ ${i} -le ${SUBCOUNT} ]
do
 TEMPNAME="${PREFIX}"_"${i}"
 mkdir ${TEMPNAME}
 cd ${TEMPNAME}
 for TEMPFILES in "${@}"
 do
  touch ${TEMPFILES}
 done
 cd ..
 (( i++ ))
done
