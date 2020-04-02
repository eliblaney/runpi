#!/bin/bash

echo "> Raspberry Pi QEMU emulator installer by Eli Blaney"

OPTIND=1

while getopts "h?p:" opt; do
    case "$opt" in
    h|\?)
        echo "Usage: ./install.sh [-h] [-p INSTALLDIR]"
		echo "-h -- Show this help"
        exit 0
        ;;
    esac
done

shift $((OPTIND-1))

[ "${1:-}" = "--" ] && shift

echo "> This script will install a Raspberry Pi emulator on your macOS computer."
echo "> It will take up approximately 7 GB of space on your computer. Press Ctrl + C to abort."

echo "> [3/8] Creating installation directory at ~/.raspberrypi
mkdir ~/.raspberrypi

echo "> [4/8] Downloading required scripts..."

curl https://github.com/eliblaney/runpi/uninstall.sh > ~/.raspberrypi/uninstall.sh
chmod +x ~/.raspberrypi/uninstall.sh

curl https://github.com/eliblaney/runpi/runpi.sh > ~/.raspberrypi/runpi.sh
chmod +x ~/.raspberrypi/runpi.sh

echo "> Please enter your computer login password"
sudo ln -sf ~/.raspberrypi/runpi.sh /usr/local/bin/runpi

echo "> [6/8] Installing the Linux kernel..."
curl https://eliblaney.com/raspberrypi/kernel-qemu-4.19.50-buster > ~/.raspberrypi/kernel-qemu-4.19.50-buster 

echo "> [7/8] Installing Raspbian (this may take a while)..."
curl https://eliblaney.com/raspberrypi/raspbian-buster.qcow > ~/.raspberrypi/raspbian-buster.qcow 

echo "> [8/8] Installing versatile-pb.dtb..."
curl https://eliblaney.com/raspberrypi/versatile-pb.dtb > ~/.raspberrypi/versatile-pb.dtb 

echo "> Finished installing"
echo "> Raspberry Pi installation can be found at ~/.raspberrypi"
echo "> Turn on your pi by typing \"runpi\""

rm install.sh
