#!/bin/bash

echo "Installing git..."

# # Install dependency
# apt-get -y install libcurl4-gnutls-dev libexpat1-dev gettext libz-dev libssl-dev asciidoc xmlto docbook2x > /dev/null
#
# # Download
# wget -P $SSCPI_TMP $git_url > /dev/null
#
# # Extract
# decompress $SSCPI_TMP/$(basename $git_url)
#
# cd $EXTRACT_PATH
#
# # Build and install
# ./configure --prefix=${SSCPI_DEST}/git
# make
# make install
#
# cd $SSCPI
#
# ${SSCPI_DEST}/git/bin/git version

echo -e "\n# Git" >> $SSCPI_ENVVARS
echo 'export PATH="$PATH":${SSCPI_DEST}/git/bin' >> $SSCPI_ENVVARS

echo -e "Git is installed to ${SSCPI_DEST}/git\n"

echo "Installing gitolite"
