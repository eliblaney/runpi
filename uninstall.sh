#!/bin/bash

# Determine installation directory (directory containing this script)
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
INSTALLDIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"

echo "Your Raspberry Pi installation will be permanently deleted."
echo "Everything in the $INSTALLDIR directory will be removed."
read -p "Are you sure (type y or n)? " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    sudo unlink /usr/local/bin/raspi
	sudo rm -rf "$INSTALLDIR"
	echo "Raspberry Pi emulator has been uninstalled"
	exit 0
else
	echo "Cancelled."
	exit 1
fi
