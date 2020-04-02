#!/bin/bash

echo "> Raspberry Pi QEMU emulator installer by Eli Blaney"

OPTIND=1
INSTALLDIR="~/.raspberrypi"

# Process command line arguments
while getopts "h?p:" opt; do
    case "$opt" in
    h|\?)
        echo "Usage: ./install.sh [-h] [-p INSTALLDIR]"
		echo "-h -- Show this help"
		echo "-p INSTALLDIR -- Change installation directory [default = ~/.raspberrypi]"
        exit 0
        ;;
    p)  INSTALLDIR="$OPTARG"
        ;;
    esac
done

# Shift arguments away, technically unnecssary here but good practice
shift $((OPTIND-1))
[ "${1:-}" = "--" ] && shift

echo "> This script will install a Raspberry Pi emulator on your macOS computer."
echo "> It will take up approximately 7 GB of space on your computer. Press Ctrl + C to abort."

echo "> [1/7] Installing dependencies..."
$darwin = [[ "$(uname)" == "Darwin" ]];
$brew = $(command -v brew >/dev/null 2>&1);
$wget = $(command -v wget >/dev/null 2>&1);
$qemu = $(command -v qemu >/dev/null 2>&1);
$brewerror = "> Homebrew is not installed. You may install Homebrew at https://brew.sh.  Aborting.";

$darwin && {
	# macOS systems
	$wget || {
		echo "> Installing wget..."
		$brew && brew install wget || {
			echo >&2 "$brewerror"; exit 1;
		}
	}
	$qemu || {
		echo "> Installing QEMU..."
		$brew && brew install qemu || {
			echo >&2 "$brewerror"; exit 1;
		}
	}
} || {
	# Non macOS systems (likely Linux)
	$wget || {
		echo >&2 "Missing dependency: wget. Please use your package manager to install missing dependencies."; exit 1;
	}
	$qemu || {
		echo >&2 "Missing dependency: QEMU. Please use your package manager to install missing dependencies."; exit 1;
	}
}

echo "> [2/7] Creating installation directory at $INSTALLDIR..."
mkdir "$INSTALLDIR"

echo "> [3/7] Installing the Linux kernel..."
wget -O "$INSTALLDIR/kernel-qemu-4.19.50-buster"  https://eliblaney.com/raspberrypi/kernel-qemu-4.19.50-buster

echo "> [4/7] Installing Raspbian \(this may take a while\)..."
wget -O "$INSTALLDIR/raspbian-buster.qcow" https://eliblaney.com/raspberrypi/raspbian-buster.qcow

echo "> [5/7] Installing versatile-pb.dtb..."
wget -O "$INSTALLDIR/versatile-pb.dtb" https://eliblaney.com/raspberrypi/versatile-pb.dtb
echo "> [6/7] Downloading required scripts..."

wget -O "$INSTALLDIR/uninstall.sh" https://github.com/eliblaney/runpi/uninstall.sh
chmod +x "$INSTALLDIR/uninstall.sh"

wget -O "$INSTALLDIR/runpi.sh"  https://github.com/eliblaney/runpi/runpi.sh
chmod +x "$INSTALLDIR/runpi.sh"

echo "> [7/7] Creating links..."
echo "> Please enter your computer login password"
sudo ln -sf "$INSTALLDIR/runpi.sh" /usr/local/bin/runpi

echo "> Finished installing"
echo "> Raspberry Pi installation can be found at $INSTALLDIR"
echo "> Turn on your pi by typing \"runpi\""
