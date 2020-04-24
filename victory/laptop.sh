#!/bin/bash

# Finish Setup my ArcoLinux

##################################################################################################################
# # Aurthor     :VictoryLinux
# 
# 
# 
##################################################################################################################

# Setting up Laptop

HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=4
BACKTITLE="VictoryLinux"
TITLE="Laptop"
MENU="Is this a laptop?:"

OPTIONS=(1 "No"
         2 "Yes")

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear
case $CHOICE in
        1)
            echo "Skipping, You dont need it."
            ;;
        2)
            echo
            echo "Running Laptop Script"
            echo
            sleep 3s
            cd /victory-edition/ArcoInstall/
            echo
            sh ArcoInstall/160-install-tlp-for-laptops-v*.sh
            ;;
esac
