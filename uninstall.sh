#!/bin/bash

echo "Your Raspberry Pi installation will be permanently deleted."
read -p "Are you sure (type y or n)? " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    sudo unlink /usr/local/bin/raspi
	sudo rm -rf ~/.raspberrypi
	echo "Raspberry Pi emulator has been uninstalled"
	exit 0
else
	echo "Cancelled."
	exit 1
fi
