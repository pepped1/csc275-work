#!/bin/bash

if [[ "${#}" -lt 2 ]]
then
	echo "Incorrect number of args"
	echo "Should be: $ ${0} (BACKUP_FOLDER_NAME) (FILE_TO_BE_BACKED_UP)..."
fi

FOLDERNAME=${1}
if [[ ! -d "./${FOLDERNAME}" ]]
then
	mkdir ${FOLDERNAME}
fi
cd ${FOLDERNAME}

shift
#FILENUM=${#}

while [ ${#} -gt 0 ]
do
	TEMPTIME=$(date +%F-%T)
	TEMPNAME="${1}"."${TEMPTIME}"
	touch "${TEMPNAME}"
shift
done
