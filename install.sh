#!/bin/bash

echo "> Raspberry Pi QEMU emulator installer by Eli Blaney"

OPTIND=1
INSTALLDIR="~/.raspberrypi"

while getopts "h?p:" opt; do
    case "$opt" in
    h|\?)
        echo "Usage: ./install.sh [-h] [-p INSTALLDIR]"
		echo "-h -- Show this help"
		echo "-p INSTALLDIR -- Change installation directory [default = ~/.raspberrypi]"
        exit 0
        ;;
    p)  INSTALLDIR=$OPTARG
        ;;
    esac
done

shift $((OPTIND-1))

[ "${1:-}" = "--" ] && shift

echo "> This script will install a Raspberry Pi emulator on your macOS computer."
echo "> It will take up approximately 7 GB of space on your computer. Press Ctrl + C to abort."

echo "> [1/8] Checking for Homebrew..."
command -v brew >/dev/null 2>&1 || { echo >&2 "> Homebrew is not installed. You may install Homebrew at https://brew.sh.  Aborting."; exit 1; }

echo "> [2/8] Installing cURL..."
brew install curl

echo "> [3/8] Creating installation directory at $(dirname $INSTALLDIR)/$INSTALLDIR..."
mkdir $INSTALLDIR

echo "> [4/8] Downloading required scripts..."

curl https://github.com/eliblaney/runpi/uninstall.sh -o $INSTALLDIR/uninstall.sh
chmod +x $INSTALLDIR/uninstall.sh

curl https://github.com/eliblaney/runpi/runpi.sh -o $INSTALLDIR/runpi.sh 
chmod +x $INSTALLDIR/runpi.sh

echo "> Please enter your computer login password"
sudo ln -sf $INSTALLDIR/runpi.sh /usr/local/bin/runpi

echo "> [5/8] Installing QEMU..."
brew install qemu

echo "> [6/8] Installing the Linux kernel..."
curl https://eliblaney.com/raspberrypi/kernel-qemu-4.19.50-buster -o $INSTALLDIR/kernel-qemu-4.19.50-buster 

echo "> [7/8] Installing Raspbian (this may take a while)..."
curl https://eliblaney.com/raspberrypi/raspbian-buster-full.qcow -o $INSTALLDIR/raspbian-buster-full.qcow 

echo "> [8/8] Installing versatile-pb.dtb..."
curl https://eliblaney.com/raspberrypi/versatile-pb.dtb -o $INSTALLDIR/versatile-pb.dtb 

echo "> Finished installing"
echo "> Raspberry Pi installation can be found at $(dirname $INSTALLDIR)/$INSTALLDIR"
echo "> Turn on your pi by typing \"runpi\""

rm install.sh
