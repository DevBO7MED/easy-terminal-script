#!/bin/sh
#
echo " ___ _   _ ____ _____  _    _     _     ___ _   _  ____"
echo "|_ _| \ | / ___|_   _|/ \  | |   | |   |_ _| \ | |/ ___| "
echo " | ||  \| \___ \ | | / _ \ | |   | |    | ||  \| | |  _   _    _    _"
echo " | || |\  |___) || |/ ___ \| |___| |___ | || |\  | |_| | (_)  (_)  (_)"
echo "|___|_| \_|____/ |_/_/   \_\_____|_____|___|_| \_|\____| "

if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root" 1>&2
    exit 1
fi

echo "Starting installation..."
echo
echo
sudo apt-get update
echo
sudo apt-get install -y figlet lolcat
echo
echo
echo "Installation complete! Now You Can Run The Script"
