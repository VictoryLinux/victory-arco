#!/bin/bash

# Finish Setup my ArcoLinux

##################################################################################################################
# # Aurthor     :VictoryLinux
# 
# 
# 
##################################################################################################################

# Setting up Display Manager

HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=4
BACKTITLE="VictoryLinux"
TITLE="Display Manager"
MENU="Choose one of the following options:"

OPTIONS=(1 "No Thanks, dont need it"
        (2 "GDM"
        (3 "LightDM")

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
            sudo systemctl enable gdm.service -f
            ;;
        3)
            sudo systemctl enable Lightdm.service -f
            ;;
        
esac