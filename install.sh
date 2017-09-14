#!/bin/bash

# SSCPI HOME
SSCPI=$(cd `dirname $0`;pwd)

# Source function library
. ${SSCPI}/functions.sh

# Source configuration
. ${SSCPI}/config

# Get available packages
pkgs_supported=($(cd ${SSCPI}/scripts/;ls *.sh | awk '{sub(/.sh$/,"",$1);print $1}'))
echo "Packages are supported by SSCPI:"
echo -e "  ${pkgs_supported[@]}\n"

# Create destination directory
[ ! -e $SSCPI_DEST ] && mkdir $SSCPI_DEST

# Create tmp directory
[ ! -e $SSCPI_TMP ] && mkdir $SSCPI_TMP

# Create custom profile
[ ! -e $SSCPI_ENVVARS ] && touch $SSCPI_ENVVARS && echo "# SSCPI system wide environment configuration" > $SSCPI_ENVVARS

# Install updates and build tools
echo "Installing updates and build tools"
#apt-get -y update > /dev/null && apt-get -y dist-upgrade > /dev/null
apt-get -y install gcc g++ make build-essential > /dev/null
apt-get -y install wget > /dev/null

# Installation BEGIN
if [[ -z $1 ]]; then

  # Get and check packages already installed in directory SSCPI_DEST
  for i in ${pkgs_supported[@]}; do
    [ -e $SSCPI_DEST/$i ] && exist=($exist $i)
  done
  if [[ ${#exist[@]} -ne 0 ]]; then
    # If there are any packages installed, exit
    echo "WARNING: Directories below already exist in $SSCPI_DEST:"
    echo "  ${exist[@]}"
    echo -e "You must remove or rename them or change SSCPI installation destination.If not, SSCPI can't proceed.\n"
    exit 1
  else
    # If no one is installed, install all packages
    for s in $SSCPI/scripts/*.sh; do
      if [[ -x $s ]]; then
        . $s
      fi
    done
  fi

else

  # Check if SSCPI supports the specific package
  for p in ${pkgs_supported[@]}; do
    [ $p = $1 ] && support="true"
  done
  if [[ $support = "true" ]]; then
    # Check if the specific package is installed
    if [[ -e $SSCPI_DEST/$1 ]]; then
      echo "WARNING: $SSCPI_DEST/$1 already exists."
      echo -e "You must remove or rename it or change SSCPI installation destination.If not, SSCPI can't proceed.\n"
      exit 1
    else
      . $SSCPI/scripts/$1.sh
    fi
  else
    echo -e "The specific package '"$1"' is not support by SSCPI.\n"
    exit
  fi
fi

echo "END"
