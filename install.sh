#!/bin/bash

echo "> Raspberry Pi QEMU emulator installer by Eli Blaney"
echo "> This script will install a Raspberry Pi emulator on your macOS computer."
echo "> It will take up approximately 7 GB of space on your computer. Press Ctrl + C to abort."

brew install curl

mkdir ~/.raspberrypi

curl https://github.com/eliblaney/runpi/uninstall.sh -o ~/.raspberrypi/uninstall.sh
chmod +x ~/.raspberrypi/uninstall.sh

curl https://github.com/eliblaney/runpi/runpi.sh -o ~/.raspberrypi/runpi.sh 
chmod +x ~/.raspberrypi/runpi.sh

echo "Please enter your computer login password"
sudo ln -sf ~/.raspberrypi/runpi.sh /usr/local/bin/runpi

echo "(1/5) Installing Homebrew..."
command -v brew >/dev/null 2>&1 || { echo >&2 "Homebrew is not installed. You may install Homebrew at https://brew.sh.  Aborting."; exit 1; }

echo "(2/5) Installing QEMU..."
brew install qemu

echo "(3/5) Installing the Linux kernel..."
curl https://eliblaney.com/raspberrypi/kernel-qemu-4.19.50-buster -o ~/.raspberrypi/kernel-qemu-4.19.50-buster 
echo "(4/5) Installing Raspbian (this may take a while)..."
curl https://eliblaney.com/raspberrypi/raspbian-buster-full.qcow -o ~/.raspberrypi/raspbian-buster-full.qcow 
echo "(5/5) Installing versatile-pb.dtb..."
curl https://eliblaney.com/raspberrypi/versatile-pb.dtb -o ~/.raspberrypi/versatile-pb.dtb 

echo "> Finished installing"
echo "> Raspberry Pi installation can be found at ~/.raspberrypi"
echo "> Turn on your pi by typing \"runpi\""

rm install.sh
