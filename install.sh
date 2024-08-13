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
echo "Starting installation..."
echo
echo "Updating Your system..."
sudo apt-get update -y
if [ $? -eq 0 ]; then
    clear
    menu
    echo
    echo "System updated successfully."
else
    clear
    menu
    echo
    echo "Update failed. Check your internet connection and try again later."
    echo "Press Enter To Exit"
    read cont
    exit
fi

echo "Installing Xterm..."
sudo apt-get install xterm -y
if [ $? -eq 0 ]; then
    clear
    menu
    echo
    echo "Xterm installed successfully."
else
    clear
    menu
    echo
    echo "Xterm installation failed. Check your internet connection and try again later."
    echo "Press Enter To Exit"
    read cont
    exit
fi

echo "Installing Figlet..."
sudo apt-get install figlet -y
if [ $? -eq 0 ]; then
    clear
    menu
    echo
    echo "Figlet installed successfully."
else
    clear
    menu
    echo
    echo "Figlet installation failed. Check your internet connection and try again later."
    echo "Press Enter To Exit"
    read cont
    exit
fi

echo "Installing Lolcat..."
sudo apt-get install lolcat -y
if [ $? -eq 0 ]; then
    clear
    menu
    echo
    echo "Lolcat installed successfully."
    sudo cp /usr/games/lolcat /usr/local/bin/
else
    clear
    menu
    echo
    echo "Lolcat installation failed. Check your internet connection and try again later."
    echo "Press Enter To Exit"
    read cont
    exit
fi

echo "Setting execute permissions for eterm.sh..."
chmod +x eterm.sh
if [ $? -eq 0 ]; then
    clear
    menu
    echo
    echo "Installed Successfully. Now you can open 'Easy Terminal Script' by typing './eterm.sh'."
else
    clear
    menu
    echo
    echo "Operation failed. Try opening the terminal in the Easy Terminal folder and typing:"
    echo "sudo chmod +x eterm.sh"
    echo "Press Enter To Exit"
    read cont
    exit
fi
