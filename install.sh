#!/bin/sh


if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root" 1>&2
    exit 1
fi

echo "Starting installation..."
echo
echo
sudo apt-get update
sudo apt-get install -y figlet lolcat
echo
echo
echo "Installation complete! Now You Can Run The Script"
