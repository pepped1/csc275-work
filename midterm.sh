#!/bin/bash

manual(){
  local msg=${1}
  echo ${msg}
  echo "The following commands are available:"
  echo "guide, create, delete, backup"
  echo "To run the program:"
  echo "$ ${0} (COMMAND) (DIRECTORY_NAME) (FILE)..."
  exit 1
}

createFun(){
  local file=${1}
  if [[ ! -f "./${file}" ]]
  then
    touch "${file}"
    echo "Success: ${file} created"
  else
    echo "Failure: ${file} already exists"
  fi
}

deleteFun(){
  local file=${1}
  if [[ -f "./${file}" ]]
  then
    rm "${file}"
    echo "Success: ${file} removed"
  else
    echo "Failure: ${file} does not exist"
  fi
}

backupFun(){
  local file=${1}
  local temptime=$(date +%F-%T)
  local tempname="${file}"."${temptime}"
  if [[ -f "./${file}" ]]
  then
    cp "${file}" "${tempname}"
    echo "Success: ${file} backed up into ${tempname}"
  else
    echo "Failure: ${file} does not exist"
  fi
}

case "${1}" in
  guide) manual "${0} Guide:"
  ;;

  create) MODE=1
  ;;

  delete) MODE=2
  ;;

  backup) MODE=3
  ;;

  *) manual "Command not recognized"
  ;;

esac

if [[ "${#}" -lt 3 ]]
then
  manual "Incorrect number of arguments"
fi

shift

DIRNAME=${1}
if [[ ! -d "./${DIRNAME}" ]]
then
  echo "Folder ${DIRNAME} was not found"
  exit 1
fi

cd ${DIRNAME}

shift

while [ ${#} -gt 0 ]
do
  if [[ "${MODE}" -eq 1 ]]
  then
    createFun ${1}
  fi
  if [[ "${MODE}" -eq 2 ]]
  then
    deleteFun ${1}
  fi
  if [[ "${MODE}" -eq 3 ]]
  then
    backupFun ${1}
  fi	
shift
done
