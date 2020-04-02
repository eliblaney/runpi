#!/bin/bash

# Determine installation directory (directory containing this script)
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
INSTALLDIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"

echo "Running Raspberry Pi..."
echo "You must enter your computer login password"
sudo qemu-system-arm -kernel $INSTALLDIR/kernel-qemu-4.19.50-buster -append "root=/dev/sda2 panic=1 rootfstype=ext4 rw" -hda $INSTALLDIR/raspbian-buster.qcow -cpu arm1176 -m 256 -M versatilepb -dtb $INSTALLDIR/versatile-pb.dtb -no-reboot -serial stdio -device e1000,mac=00:00:ab:c9:df:03
echo "Raspberry Pi has shut down"
