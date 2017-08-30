#!/bin/bash

# SSCPI HOME
SSCPI=$(cd `dirname $0`;pwd)
export SSCPI

# Source function library
. $SSCPI/functions.sh

# Source configuration
. $SSCPI/config

if [[ -z $1 ]]; then
  # check all packages to know if there are installed packages
  # if there are packages installed, exit
  # if not any installed,then install all packages
else
  # check if this package is installed
  if [[ -e $SSCPI_DEST/$1 ]]; then
    echo "WARNING: $SSCPI_DEST/$1 already exists."
    exit 1
  else
    $SSCPI/scripts/$1.sh
  fi
fi
