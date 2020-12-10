#!/bin/bash

# simple manual function
manual(){
    echo "This program checks if any ip's in the passed log file match the passed countries."
    echo "For each match found, its traceroute is printed to a log file and added to a csv file."
    echo "To run the program:"
    echo "$ ${0} <NAME OF LOG FILE> <COUNTRY NAME ...>"
    exit 1
}

# function for errors, suggests manual
errorExit(){
    local error=${1}
    echo "Error: ${1}"
    echo "To see the manual:"
    echo "$ ${0} manual"
    echo "Program closing..."
    exit 1
}

# function for if a match is found in the logfile
matchFound(){
    local ip=${1}
    local country=${2}
    local csv=${3}
    local tempTRACE=${country}"."$(date +%Y-%H-%M-%S)".txt"
    traceroute ${ip} > ${tempTRACE}
    echo "${ip},${country},${tempTRACE}" >> ${csv}
}

# checks if valid number of args
# or if user wants to see the manual
if [[ ${#} -lt 2 ]]
then
    if [[ ${1} == "manual" ]]
    then
        manual
    else
        errorExit "Incorrect number of args"
    fi
fi

# assigns logfile to variable and shifts it out
LOGFILE=${1}
shift

# checks if logfile passed exists
if [[ -f ./${LOGFILE} ]]
then 
    echo "Logfile ${LOGFILE} found"
else
    errorExit "Logfile ${LOGFILE} not found"
fi

CSVFILE="ip."$(date +%Y-%H-%M-%S)".csv"

# checks if csv logfile exists, else makes one
if [[ -f ./${CSVFILE} ]]
then
    echo "CSV logfile ${CSVFILE} found"
else
    echo "CSV logfile not found"
    echo "IP,Country,TracerouteFile" > ${CSVFILE}
    echo "${CSVFILE} created"
fi

# awk prints the first column into a while loop
echo "Working..."
awk '{print $1}' ${LOGFILE} | while read line
do
    # looks up current ip and prints assigns last word
    locTEMP=$(geoiplookup ${line} | awk '{ print $NF }')

    #iterates through args
    for var in ${@}
    do
        if [[ ${locTEMP} == ${var} ]]
        then
            matchFound ${line} ${var} ${CSVFILE}
        fi
    done
done

echo "Done!"
exit 0
