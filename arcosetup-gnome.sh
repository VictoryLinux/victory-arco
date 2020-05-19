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

function greeting() {

	clear

	echo
	echo "+-------------------------------------------------------------------------+"
	echo "|------- Hello, $USER. Let's setup your ArcoLinux Victory-Edition. -------|"
	echo "+-------------------------------------------------------------------------+"
	echo
	echo "DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK."
	echo
	echo
	echo
	echo
	echo "This is NOT a silent install" 
	echo
	echo "you will be asked several questions as it progresses"
	echo
	echo
	echo
	echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
	echo "++++++++  Things you need to know before you start  ++++++++"
	echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
	echo "++                                                        ++"
	echo "++ 1.) This first script will install the Gnome DE + GDM  ++"
	echo "++                                                        ++"
	echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
	echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
	echo
	echo
#	sleep 5s
	echo "ARE YOU READY TO START? [y,n]"
	read input

	# did we get an input value?
	if [ "$input" == "" ]; then

	   echo "Nothing was entered by the user"

	# was it a y or a yes?
	elif [[ "$input" == "y" ]] || [[ "$input" == "yes" ]]; then

	   echo "You replied $input, you are ready to start"
	   echo
	   echo "Starting Arcolinux Victory-Edition install script pt. 1."
	   echo
	   sleep 3s

	# treat anything else as a negative response
	else

	   echo "You replied $input, you are not ready"
	   echo
	   exit 1

fi

	echo
	
	check_exit_status
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

	echo "Updating ArchLinux & ArcoLinux."
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
	echo "You now have a DE. stay here and finish now or reboot to finish in Gnome"
	echo
}

# finish
function finish() {
	read -p "Do you want to stay here and finish now? (y/n) " answer 

            if [ "$answer" == "y" ]
            then
            	cd arco-gnome
		echo
		sh arcosetup-victory.sh

            if [ "$answer" == "n" ]
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
		echo "Restarting in 20s"
		sleep 15s
                reboot
            fi
        fi

}

greeting
mirror
general_update
gnome
gdm
finish
