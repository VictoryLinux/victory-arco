#!/bin/bash
set -e

##################################################################################################################
# Author        :Erik Dubois
# Forked by     :VictoryLinux
# 
# Forked and edited for my personal needs
# 
##################################################################################################################
#
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.
#
##################################################################################################################

# software from AUR (Arch User Repositories)
# https://aur.archlinux.org/packages/

echo "DESKTOP SPECIFIC APPLICATIONS"

echo "Installing category Accessories"

#sudo pacman -S --noconfirm --needed gnome-multi-writer
#sudo pacman -S --noconfirm --needed gnome-pie
#sudo pacman -S --noconfirm --needed galculator

echo "Installing category Development"

echo "Installing category Education"

echo "Installing category Games"

echo "Installing category Graphics"

echo "Installing category Internet"

echo "Installing category Multimedia"

#sudo pacman -S --noconfirm --needed gnome-mplayer
#sh AUR/install-mpd-ncmpcpp-v*.sh

echo "Installing category Office"

echo "Installing category Other"

echo "Installing category System"

sudo pacman -S imagemagick --noconfirm --needed
sudo pacman -S w3m --noconfirm --needed
sudo pacman -S chrome-gnome-shell --noconfirm --needed
sudo pacman -S nautilus-image-converter --noconfirm --needed
#variety
sudo pacman -S --noconfirm --needed libappindicator-gtk3
echo "################################################################"
echo "####    Software from Arch Linux Repository installed     ######"
echo "################################################################"
