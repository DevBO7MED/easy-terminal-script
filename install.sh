#!/bin/sh

echo "Starting installation..."


if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root" 1>&2
    exit 1
fi


apt-get update
apt-get install -y figlet lolcat

echo "Installation complete!"
