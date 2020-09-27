#!/bin/bash

if [[ "$(id -un)" != "sysadmin" ]]
then
 echo "Error: Only accessible to sysadmin."
 exit 1
fi

if [[ "${#}" -ne 2 ]]
then
 echo "incorrect amount of arguments"
 echo "please only enter the folder name and file name"
 exit 1
fi

mkdir ${1}
cd ${1}
echo >> ${2}
cd ..
zip -r "${1}.zip" ${1}

echo "Success: ${1}.zip created with ${2} inside"
exit 0
