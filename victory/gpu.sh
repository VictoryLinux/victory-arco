#!/bin/bash

# Finish Setup my ArcoLinux

##################################################################################################################
# # Aurthor     :VictoryLinux
# 
# 
# 
##################################################################################################################

# Setting up Video Driver

HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=4
BACKTITLE="VictoryLinux"
TITLE="Video Driver"
MENU="Choose one of the following options:"

OPTIONS=(1 "No Thanks, dont need either"
         2 "Nvidia"
         3 "Intel")

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
            sudo pacman -S nvidia nvidia-utils lib32-nvidia-utils nvidia-settings vulkan-icd-loader lib32-vulkan-icd-loader
            ;;
        3)
            sudo pacman -S lib32-mesa vulkan-intel lib32-vulkan-intel vulkan-icd-loader lib32-vulkan-icd-loader
            ;;
esac
