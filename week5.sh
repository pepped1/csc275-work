#!/bin/bash

manual(){
  local msg=${1}
  echo ${msg}
  echo "To run the program:"
  echo "$ ${0} [Directory Folder Name] [Subfolder Name Prefix] [Number of Subfolders] [Subfolder Files]..."
  echo "To see an example:"
  echo "$ ${0} example" 
  exit 1
}

exFunc(){
  local program=${1}
  echo "$ ${program} Downloads sub_fold 3 file1.txt file2.txt file3.txt"
  exit 1
}

case "${1}" in
  help) manual "This program creates a parent folder, subfolders in the parent folder, and files in each subfolder."
  ;;

  example) exFunc ${0}
  ;;

  hi) echo "hiiiii"
  exit 1
  ;;
   
  *)
  if [[ "${#}" -lt 4 ]]
  then
    manual "Incorrect number of arguments"
  fi
  ;;

esac

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
echo "Done!"
