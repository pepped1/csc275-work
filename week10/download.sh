#!/bin/bash

# This script will download a dataset and prepare it for use.

# Check that the user enters at least one argument
# ${#} means number of arguments and -lt means less than
if [[ "${#}" -lt 1 ]]
then
      echo "Guide: ${0} URL"
        exit 1
    fi

    URL=${1}

    # Download the file
    wget -O ./data.zip ${URL} &> /dev/null

    # Make sure the download was succesful
    if [[ "${?}" -ne 0 ]]
    then
          echo 'Download Failed!'
            exit 1
        fi

        # Unzip the file
        unzip ./data.zip &> /dev/null

        # Remove the zip file
        rm ./data.zip

        # Remove the readme file
        rm readme

        # Output a success message
        echo "success!"

        exit 0
