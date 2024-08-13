#!/bin/sh


if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root" 1>&2
    exit 1
fi

menu() {
    clear
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

clear

#!/bin/sh

if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root" 1>&2
    exit 1
fi

menu() {
clear
echo "  ____ _   _ _____ ____ _  _____ _   _  ____ "
echo " / ___| | | | ____/ ___| |/ /_ _| \ | |/ ___|"
echo "| |   | |_| |  _|| |   | ' / | ||  \| | |  _   _    _    _ "
echo "| |___|  _  | |__| |___| . \ | || |\  | |_| | (_)  (_)  (_)"
echo " \____|_| |_|_____\____|_|\_\___|_| \_|\____|"
echo
echo
}

menu

# Define colors

RED='\033[0;31m'

GREEN='\033[0;32m'

NC='\033[0m' # No Color



# Function to check if a command exists

check_command() {

    command -v "$1" >/dev/null 2>&1

}



# Function to check if a file exists at specific paths

check_file() {

    for path in "$@"; do

        if [ -f "$path" ]; then

            return 0

        fi

    done

    return 1

}



# Function to check for root privileges

check_root() {

    printf "Checking for root privileges: "

    if [ "$(id -u)" -eq 0 ]; then

        printf "[ ${GREEN}✔${NC} ]\n"

    else

        printf "[ ${RED}✘${NC} ]\n"

        return 1

    fi

}



# Function to check each required program

check_program() {

    printf "Checking for %-10s       " "$1":

    if check_command "$1" || check_file "$2" "$3" "$4" "$5" "$6" "$7" "$8" "$9"; then

        printf "[ ${GREEN}✔${NC} ]\n"

    else

        printf "[ ${RED}✘${NC} ]\n"

        MISSING_PROGRAMS="$MISSING_PROGRAMS $1"

    fi

}



# Check for Metasploit specifically

check_metasploit() {

    printf "Checking for Metasploit:      "

    if check_command "msfconsole" || check_file "/usr/bin/msfconsole" "/usr/local/bin/msfconsole" "/bin/msfconsole" "/usr/sbin/msfconsole" "/sbin/msfconsole"; then

        printf "[ ${GREEN}✔${NC} ]\n"

    else

        printf "[ ${RED}✘${NC} ]\n"

        MISSING_PROGRAMS="$MISSING_PROGRAMS metasploit"

    fi

}



# Start checks

echo

check_root

sleep 1



MISSING_PROGRAMS=""



check_program xterm "/usr/bin/xterm" "/usr/local/bin/xterm" "/bin/xterm" "/usr/sbin/xterm" "/sbin/xterm"

sleep 1

check_program lolcat "/usr/bin/lolcat" "/usr/local/bin/lolcat" "/bin/lolcat" "/usr/sbin/lolcat" "/sbin/lolcat"

sleep 1

check_program figlet "/usr/bin/figlet" "/usr/local/bin/figlet" "/bin/figlet" "/usr/sbin/figlet" "/sbin/figlet"

sleep 1

check_metasploit

sleep 1

check_program msfvenom "/usr/bin/msfvenom" "/usr/local/bin/msfvenom" "/bin/msfvenom" "/usr/sbin/msfvenom" "/sbin/msfvenom"



# Handle missing programs

if [ -n "$MISSING_PROGRAMS" ]; then

    echo "Some required programs are missing. Please run install.sh to install them."

    read -p "Press Enter to exit..."

    exit 1

fi



echo

echo "All required programs are installed."

echo

echo "You Can Now Open Easy Terminal Script Press Enter to exit"

read cont



