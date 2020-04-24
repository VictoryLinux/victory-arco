#!/bin/bash

# Finish Setup my ArcoLinux

##################################################################################################################
# # Aurthor     :VictoryLinux
# 
# 
# 
##################################################################################################################

# Setting up Guest aditions

HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=4
BACKTITLE="VictoryLinux"
TITLE="Virtualbox Guest Aditions"
MENU="Do you need Guest aditions?:"

OPTIONS=(1 "No Thanks, dont need it"
         2 "Install Guest aditions")

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
	    sudo pacman -S virtualbox-guest-modules-arch virtualbox-guest-utils --noconfirm
            ;;
esac
