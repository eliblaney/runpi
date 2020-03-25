#!/bin/bash

echo "Running Raspberry Pi..."
echo "You must enter your computer login password"
sudo qemu-system-arm -kernel ~/.raspberrypi/kernel-qemu-4.19.50-buster -append "root=/dev/sda2 panic=1 rootfstype=ext4 rw" -hda ~/.raspberrypi/raspbian-buster.qcow -cpu arm1176 -m 256 -M versatilepb -dtb ~/.raspberrypi/versatile-pb.dtb -no-reboot -serial stdio -device e1000,mac=00:00:ab:c9:df:03
echo "Raspberry Pi has shut down"
