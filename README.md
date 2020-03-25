# runpi

runpi is a Raspbian emulator for macOS systems developed by Eli Blaney.

The script allows you to simulate the Raspberry Pi experience. It uses QEMU run the full Raspbian buster operating system on your macOS computer by emulating the ARM1176 architecture. It does not yet have support for network bridging, but that may be added in the future.

## Requirements

- [Homebrew](https://brew.sh)
- 10GB disk space (recommended); 7GB disk space (minimum)

## Installation

Copy and paste the following command into your terminal:

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/eliblaney/runpi/master/install.sh)"

By default, installation files can be found at ~/.raspberrypi

### Installation arguments

    Usage: ./install.sh [-h] [-p INSTALLDIR]
	-h -- Show this help
	-p INSTALLDIR -- Change installation directory [default = ~/.raspberrypi]

By default, the Raspberry Pi installation is installed to `~/.raspberrypi`. You can change this by specifying the `-p` option as in this example:

	./install.sh -p ~/Documents/raspberrypi

## Usage

Simply type `runpi` to start your Raspberry Pi. This command is a symlink at `/usr/local/bin` that links to `~/.raspberrypi/runpi.sh`. You will be prompted to type your password.

## Contribute

If you would like to contribute to this project, please submit a pull request.
