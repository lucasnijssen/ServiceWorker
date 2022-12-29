#!/bin/sh

# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White

scriptVersion="1.6"
menuAmount="6"

TODAY=`date +%j`                 # Today, as day-of-year (1-366)
CHRISTMAS=`date -d 25-Dec +%j`   # Christmas day, in same format

echo -e " _       __     __  __           __  ___    ____"
echo -e "| |     / /__  / / / /___  _____/ /_/   |  / / /"
echo -e "| | /| / / _ \/ /_/ / __ \/ ___/ __/ /| | / / /"
echo -e "| |/ |/ /  __/ __  / /_/ (__  ) /_/ ___ |/ / /"
echo -e "|__/|__/\___/_/ /_/\____/____/\__/_/  |_/_/_/ ©         __"
echo -e "  / ___/___  ______   __(_)_______| |     / /___  _____/ /_____  _____"
echo -e "  \__ \/ _ \/ ___/ | / / / ___/ _ \ | /| / / __ \/ ___/ //_/ _ \/ ___/"
echo -e " ___/ /  __/ /   | |/ / / /__/  __/ |/ |/ / /_/ / /  / ,< /  __/ /"
echo -e "/____/\___/_/    |___/_/\___/\___/|__/|__/\____/_/  /_/|_|\___/_/"
echo -e "${BGreen}Version: [${scriptVersion}.${menuAmount}]${Color_Off}"
echo ""
echo "|=======================================|"                                                                      
echo -e "|        ${BBlue}What do you want to do?${Color_Off}        |"
echo "|        [0] Script Info                |"
echo "|        [1] Update and Upgrade         |"
echo "|        [2] Ping Google.com            |"
echo "|        [3] Install pterodactyl        |"
echo "|        [4] Restart a Service          |"
echo "|        [5] View docker containers     |"
echo "|        [6] Ho Ho Ho                   |"
echo "|=======================================|"
echo "Select an number between [0-${menuAmount}]:"
read menuInput

#error catching
if [ -z "$menuInput" ]; then
    echo "You need to select an option."
    echo "The program will exit now, to try again please run the start command."
fi

if [ "$menuInput" -gt "$menuAmount" ]; then
    echo "You need to select an option."
    echo "The program will exit now, to try again please run the start command."
fi
#end of error cathing

#begin of menu select

#help
if [[ "$menuInput" == 0 ]]; then
   echo -e "|==========================================|"
   echo -e "|                   ${BGreen}Info${Color_Off}                   |"
   echo -e "|                                          |"
   echo -e "|       We are working on the script,      |"
   echo -e "|         So its not close to done.        |"
   echo -e "|                                          |"
   echo -e "| ${BWhite}This script is an product of WeHostAll ©${Color_Off} |"
   echo -e "|==========================================|"
fi

#Update and Upgrade
if [[ "$menuInput" == 1 ]]; then
    echo "Starting Update..."
    sudo apt update
    echo -e "${BGreen}Update Done!${Color_Off}"
        echo "Starting Upgrade..."
    sudo apt upgrade
    echo -e "${BGreen}Upgrade Done!${Color_Off}"
fi

#ping
if [[ "$menuInput" == 2 ]]; then
    echo "How many times do you want to ping:"
    read pingTimes

    if [ "$pingTimes" -gt 0 ]; then
        echo "Starting Ping..."
        ping -c ${pingTimes} google.com
        echo -e "${BGreen}Pinging Done!${Color_Off}"
    else 
        echo -e "${BRed}Please enter an number bigger than 0.${Color_Off}"
        echo ""
        echo "How many times do you want to ping:"
        read pingTimes
        echo "Starting Ping..."
        ping -c ${pingTimes} google.com
        echo -e "${BGreen}Pinging Done!${Color_Off}"
    fi
fi

#pterodactyl
if [[ "$menuInput" == 3 ]]; then
   sudo bash <(curl -s https://pterodactyl-installer.se)
fi

#program restart
if [[ "$menuInput" == 4 ]]; then
    echo "Which program do you want to restart?"
    read restartProgram
    echo "Do you really want to restart ${restartProgram}? (y/n)"
    read -r CONFIRM
    if [[ "$CONFIRM" =~ [Yy] ]]; then
      sudo systemctl restart $restartProgram
    else
      echo -e "${BRed}Restart of ${restartProgram} aborted.${Color_Off}"
      exit 1
    fi
fi

#Docker
if [[ "$menuInput" == 5 ]]; then
   echo -e "This are your all your ${BBlue}Docker${Color_Off} containers:"
   docker ls --all
fi

#Cristmas
if [[ "$menuInput" == 6 ]]; then
   echo "There are $(($CHRISTMAS - $TODAY)) days until Christmas."
fi



