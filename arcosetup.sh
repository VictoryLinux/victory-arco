#!/bin/bash
# Start Setup my ArcoLinux

##################################################################################################################
# # Aurthor     :Vicck-tech 
# 
# 
# 
##################################################################################################################

# Make sure each command executes properly
check_exit_status() {

	if [ $? -eq 0 ]
	then
		echo
		echo "Success"
		echo
	else
		echo
		echo "[ERROR] Update Failed! Check the errors and try again"
		echo
		
		read -p "The last command exited with an error. Exit script? (y/n) " answer

            if [ "$answer" == "y" ]
            then
                exit 1
            fi
	fi
}

greeting() {

	echo
	echo "Hello, $USER. Let's start setting up your fresh ArcoLinux install."
	echo
}

# searching for the fastest mirrors
function mirror() {

	echo "Updating your Mirrors."
	echo
	sleep 3s
	sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist;
	check_exit_status
}

# Downloading and installing all Arch Linux and ArcoLinux packages
function general_update() {

	echo "Updating Arch & Arco."
	echo
	sleep 3s
	sudo pacman -Sy archlinux-keyring --noconfirm;
	sudo pacman -Syyu --noconfirm;
	check_exit_status
}

# Downloading and installing all Arch Linux and ArcoLinux packages
function gnome() {

	echo "Installing Gnome DE."
	echo
	sleep 3s
	sudo pacman -S gnome --noconfirm;
	check_exit_status
}

# Setting up GDM login screen
function gdm() {

	echo "Installing GDM."
	echo
	sleep 3s
	sudo systemctl enable gdm.service -f;
	check_exit_status
	echo
	echo "You now have a DE. Reboot now to finish in Gnome, or stay here and finish now"
	echo
	read -p "Do you want to reboot now? (y/n) " answer 

            if [ "$answer" == "y" ]
            then
            	echo
		echo "----------------------------------------------"
		echo "---- ArcoLinux part 1 has been installed! ----"
		echo "----------------------------------------------"
		echo
		check_exit_status
		echo
            	echo "After restarting, open terminal and run arcosetup-2.sh from the arco-gnome folder to finish this setup"
            	echo
		echo "Restarting in 15s"
		sleep 15s
                reboot

            if [ "$answer" == "n" ]
            then
	    	cd arco-gnome
		echo
                sh arcosetup-2.sh
            fi
        fi

}

mirror
general_update
gnome
gdm
