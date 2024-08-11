#!/bin/sh


<<<<<<< HEAD
=======

>>>>>>> origin/main
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root" 1>&2
    exit 1
fi

<<<<<<< HEAD
echo "Starting installation..."
echo
echo
sudo apt-get update
sudo apt-get install -y figlet lolcat
echo
echo
echo "Installation complete! Now You Can Run The Script"
=======

apt-get update
apt-get install -y figlet lolcat

echo "Installation complete!"
>>>>>>> origin/main
