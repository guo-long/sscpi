# -*-Shell-script-*-
#
# functions    This file contains functions to be used by shell scripts
#              in the sscpi/scripts directory.
#

# Set up a default search path
#PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

decompress() {
  unset EXTRACT_DIR
  case $1 in
    *.zip)
      EXTRACT_PATH=`unzip $1 -d `dirname $1` | sed -n '2p' | awk'{print $2}'`
      ;;
    *)
      EXTRACT_PATH=$(dirname $1)/$(tar -axvf $1 -C `dirname $1` | sed -n '1p')
  esac
}
