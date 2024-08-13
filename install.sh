#!/bin/sh


if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root" 1>&2
    exit 1
fi


menu() {
echo " ___ _   _ ____ _____  _    _     _     ___ _   _  ____"
echo "|_ _| \ | / ___|_   _|/ \  | |   | |   |_ _| \ | |/ ___| "
echo " | ||  \| \___ \ | | / _ \ | |   | |    | ||  \| | |  _   _    _    _"
echo " | || |\  |___) || |/ ___ \| |___| |___ | || |\  | |_| | (_)  (_)  (_)"
echo "|___|_| \_|____/ |_/_/   \_\_____|_____|___|_| \_|\____| "
}

menu
echo
echo
echo
echo
echo "Starting installation..."
echo
echo
echo "Updating Your system..."
echo
echo
sudo apt-get update -y
if [ $? -eq 0 ]; then
   clear
   menu
   echo
   echo
   echo
   echo
   echo "Installed Successfully"
else
   clear
   menu
   echo
   echo
   echo
   echo
   echo "install failed Check You internet connection Try again later"
   echo "Press Enter To Exit"
   read cont
   exit
fi
echo
echo "Installing Xterm..."
echo
echo
sudo apt-get install xterm -y
if [ $? -eq 0 ]; then
   clear
   menu
   echo
   echo
   echo
   echo
   echo "Installed Successfully"
else
   clear
   menu
   echo
   echo
   echo
   echo
   echo "install failed Check You internet connection Try again later"
   echo "Press Enter To Exit"
   read cont
   exit
   
echo
fi
echo "Installing fig..."
echo
echo
sudo apt-get install figlet -y
if [ $? -eq 0 ]; then
   clear
   menu
   echo
   echo
   echo
   echo
   echo "Installed Successfully"
else
   clear
   menu
   echo
   echo
   echo
   echo
   echo "install failed Check You internet connection Try again later"
   echo "Press Enter To Exit"
   read cont
   exit
fi
echo
echo "Installing lo..."
echo
echo
sudo apt-get install lolcat -y
if [ $? -eq 0 ]; then
   clear
   menu
   echo
   echo
   echo
   echo
   echo "Installed Successfully"
else
   clear
   menu
   echo
   echo
   echo
   echo
   echo "install failed Check You internet connection try again later"
   echo "Press Enter To Exit"
   read cont
   exit
fi
   
   chmod +x eterm.sh
   if [ $? -eq 0 ]; then
   clear
   menu
   echo
   echo
   echo
   echo
   sudo chmod +x eterm.sh
   echo "Installed Successfully Now you can open \"Easy Terminal Script\" script."
   echo "Type \"./eterm.sh\" To open It."
else
   clear
   menu
   echo
   echo
   echo
   echo
   echo "operation failed Try open terminal in the easy terminal folder And type: "
   sudo chmod +x eterm.sh
   echo
   echo "Press Enter To Exit"
   read cont
   exit
fi
