#!/bin/bash
# Finish Setup my ArcoLinux

##################################################################################################################
# # Aurthor     :VictoryLinux
# 
# 
# # Scroll to the very bottom to alter what is executed in this script.
##################################################################################################################

# Place a # in front of any part of this script yould like to skip:

greeting
mirror
general_update
debloat
arco
install
#laptop
#laptop2
#flatpak
update_script
fix_bashrc
face
icons
dock
backgrounds
#nvidia
#nvidia2
#intel
#intel2
#gdm
gdm2
#lightdm
#lightdm2
#virtualbox
#virtualbox2

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
	echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++"
	echo "+++++  Things you need to know before you start  +++++"
	echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++"
	echo "++                                                  ++"
	echo "++ 1.) Your username & a password for SAMBA install ++"
	echo "++ 2.) What GPU driver you need, Nvidia or Intel    ++"
	echo "++ 3.) Is this a Virtualbox VM                      ++"
	echo "++ 4.) Do you want to use GDM or LightDM            ++"
	echo "++                                                  ++"
	echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++"
	echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++"
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
	   echo "Starting Arcolinux Victory-Edition install script pt. 2."
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
	sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist;
	check_exit_status
}

# Downloading and installing all Arch Linux and ArcoLinux packages
function general_update() {

	echo "Updating ArchLinux & ArcoLinux."
	echo
	sleep 3s
	sudo pacman -Syyu --noconfirm;
	check_exit_status
}

# Debloat ArcolinuxD
function debloat() {

	echo "Debloating."
	echo
	sleep 3s
	sudo pacman -Rdsu gnome-books gnome-clocks gnome-terminal gnome-documents gnome-maps gnome-music gnome-weather gnome-boxes epiphany totem --noconfirm;
	check_exit_status gnome backgrounds
}

# Running Arco Linux Setup Scripts
function arco() {
	echo
	echo "Running Arco Linux Setup Scripts"
	echo
	sleep 3s
	cd /victory-edition/ArcoInstall/
	echo
	sh ArcoInstall/100-display-manager-and-desktop.sh
	sh ArcoInstall/110-development-software.sh
	sh ArcoInstall/120-install-sound.sh
	sh ArcoInstall/130-bluetooth.sh
	sh ArcoInstall/140-printers.sh
	sh ArcoInstall/150-samba.sh
	sh ArcoInstall/170-network-discovery.sh
	sh ArcoInstall/200-software-arch-linux.sh
	sh ArcoInstall/300-software-arcolinux-3thparty.sh
	sh ArcoInstall/400-software-arcolinux-xlarge.sh
	sh ArcoInstall/500-software-distro-specific.sh
	sh ArcoInstall/600-additional-arcolinux-software.sh
	sh ArcoInstall/700-installing-fonts.sh
	sh ArcoInstall/800-conky.sh
	echo
#	sh ArcoInstall/000-use-all-cores-makepkg-conf-v*.sh
#	sh ArcoInstall/110-install-sound-v*.sh
#	sh ArcoInstall/120-bluetooth-v*.sh
#	sh ArcoInstall/121-fix-bluetooth-switch-not-working-v*.sh
#	sh ArcoInstall/130-install-printers-v*.sh
#	sh ArcoInstall/140-install-samba-v*.sh
#	sh ArcoInstall/150-install-network-discovery-v*.sh
#	sh ArcoInstall/200-software-arch-linux-repo-v*.sh
#	sh ArcoInstall/300-software-AUR-repo-v*.sh
#	sh ArcoInstall/400-software-arch-linux-repo-distro-specific-v*.sh
#	sh ArcoInstall/500-software-AUR-repo-distro-specific-v*.sh
#	sh ArcoInstall/600-software-from-ArcoLinux-repo-v*.sh
#	sh ArcoInstall/700-installing-fonts-v*.sh
#	sh ArcoInstall/900-fix-microcode-error-v*.sh

	check_exit_status
}

function install() {
	echo
	echo "Installing Essentials"
	echo
	sleep 3s
	sudo pacman -S terminator dconf-editor yay gnome-nettool gnome-tweaks gnome-usage flatpak curl git meson onboard brave-bin unrar
	echo
	yay -S flat-remix onlyoffice-bin popsicle-git arcolinux-teamviewer realvnc-vnc-server realvnc-vnc-viewer
	echo
	flatpak install flathub org.glimpse_editor.Glimpse && flatpak install flathub com.discordapp.Discord
}

# Settings for laptops
function laptop() {
	read -p "IS THIS BEING INSTALLED ON A LAPTOP? [y,n]" answer 

            if [ "$answer" == "y" ]
            then
            	echo "You replied $input, this is a laptop."
		echo
		echo "Running setup for laptops."
		echo
		cd /victory-edition/ArcoInstall/
		echo
		sh ArcoInstall/160-install-tlp-for-laptops-v*.sh

            if [ "$answer" == "n" ]
            then
		echo "You replied $input, this is not a laptop"
		echo
		echo "Moving on"
		sleep 15s
                
            fi
        fi

}
	

# Running Arco Linux Setup Scripts
function laptop2() {
	echo
	echo "Running Arco Linux Setup Scripts"
	echo
	sleep 3s
	cd /victory-edition/ArcoInstall/
	echo
	sh ArcoInstall/160-laptop.sh
	echo
	check_exit_status
}


# copy update script to final location
function flatpak() {

#	echo "Moving Update Script to final location."
	echo
#	sleep 3s
	flatpak install flathub org.glimpse_editor.Glimpse;
	echo
	check_exit_status
}

# copy update script to final location
function update_script() {

	echo "Moving Update Script to final location."
	echo
	sleep 3s
	sudo mv victory/arcoupdate ~/.bin/;
	cd ~/.bin 
	chmod u+x arcoupdate
	check_exit_status
}

# Put the fancy bash promt back after updating
function fix_bashrc() {

	echo "Making Terminal fancy."
	echo
	sleep 3s
	sudo cp -r victory/fancy-user-bash.sh ~/;
	sudo cp -r victory/fancy-root-bash.sh ~/;
	cd ~
	sudo mv fancy-user-bash.sh .fancy-user-bash.sh
	sudo mv fancy-root-bash.sh .fancy-root-bash.sh
	echo "
	source ~/.fancy-user-bash.sh" | sudo tee --append ~/.bashrc
		echo
	#	gsettings set org.gnome.desktop.default-applications.terminal exec 'terminator'
	#	echo
	#	sudo ln -s /usr/bin/gnome-terminal
		check_exit_status
	}
	
# Put the .face img in home folder
function face() {

	echo "Fixing my face."
	echo
	sleep 3s
	sudo cp -r victory/face ~/;
	echo
	cd ~
	sudo mv face .face
	echo
	check_exit_status
}

# Installing my Icon Themes
function icons() {

	echo "Giving Gnome a facelift."
	echo
	sleep 3s
#	git clone https://github.com/pop-os/icon-theme pop-icon-theme
#	cd pop-icon-theme
#	meson build
#	sudo ninja -C "build" install
#	sudo mv pop-icon-theme/ ~/;
	#gsettings set org.gnome.desktop.interface icon-theme 'Pop'
	echo
	git clone https://github.com/daniruiz/flat-remix
	git clone https://github.com/daniruiz/flat-remix-gtk
	mkdir -p ~/.icons && mkdir -p ~/.themes
	cp -r flat-remix/Flat-Remix* ~/.icons/ && cp -r flat-remix-gtk/Flat-Remix-GTK* ~/.themes/
	rm -rf ~/flat-remix flat-remix-gtk
	gsettings set org.gnome.desktop.interface gtk-theme "Flat-Remix-GTK-Blue-Dark"
	gsettings set org.gnome.desktop.interface icon-theme "Flat-Remix-Blue-Dark"
	
	check_exit_status
}

# Setting up Favorite Dock icons
function dock() {

	echo "Setting up the Dock."
	echo
	sleep 3s
#	cp /usr/share/applications/plank.desktop ~/.config/autostart/
#	sudo chmod +x ~/.config/autostart/plank.desktop
	echo
	gsettings set org.gnome.shell favorite-apps "['firefox.desktop', 'chromium.desktop', 'org.gnome.Nautilus.desktop', 'simplenote.desktop', 'terminator.desktop', 'realvnc-vncviewer.desktop', 'com.teamviewer.TeamViewer.desktop', 'virtualbox.desktop', 'onboard.desktop']"
	
	check_exit_status
}

# Put the wallpaper
function backgrounds() {

	echo "Setting up Favorite Wallpaper."
	echo
	sleep 3s
#	sudo mv ~/victory-edition/victory/backgrounds/my_arcolinux /usr/share/backgrounds/
#	sudo mv ~/victory-edition/victory/backgrounds/my_gnome /usr/share/backgrounds/
#	sudo mv ~/victory-edition/victory/backgrounds/my_wall /usr/share/backgrounds/
	sudo cp -r ~/victory-edition/victory/backgrounds/victory /usr/share/backgrounds/
	echo
#	sudo rm -rf /usr/share/backgrounds/arcolinux
#	sudo rm -rf /usr/share/backgrounds/gnome
	check_exit_status
}

# searching for the fastest mirrors
function nvidia() {
	echo "DO YOU NEED NVIDIA DRIVERS? [y,n]"
	read input

	# did we get an input value?
	if [ "$input" == "" ]; then

	   echo "Nothing was entered by the user"

	# was it a y or a yes?
	elif [[ "$input" == "y" ]] || [[ "$input" == "yes" ]]; then

	   echo "You replied $input, you do need Nvidia video driver"
	   echo
	   echo "Installing Nvidia video driver"
	   echo
	   sleep 3s
           echo
           sudo pacman -S nvidia nvidia-utils lib32-nvidia-utils nvidia-settings vulkan-icd-loader lib32-vulkan-icd-loader

	# treat anything else as a negative response
	else

	   echo "You replied $input, you don't need nvidia driver"
	   echo
	   echo "Moving on"

fi

	echo
	
	check_exit_status
}

# Running Arco Linux Setup Scripts
function nvidia2() {
	echo
	echo "Installing Nvidia video driver"
	echo
	sleep 3s
	echo
	sudo pacman -S nvidia nvidia-utils lib32-nvidia-utils nvidia-settings vulkan-icd-loader lib32-vulkan-icd-loader
	echo
	check_exit_status
}

# searching for the fastest mirrors
function intel() {
	echo "DO YOU NEED INTEL VIDEO DRIVERS? [y,n]"
	read input

	# did we get an input value?
	if [ "$input" == "" ]; then

	   echo "Nothing was entered by the user"

	# was it a y or a yes?
	elif [[ "$input" == "y" ]] || [[ "$input" == "yes" ]]; then

	   echo "You replied $input, you do need Intel video driver"
	   echo
	   echo "Installing Intel video driver"
	   echo
	   sleep 3s
           echo
           sudo pacman -S lib32-mesa vulkan-intel lib32-vulkan-intel vulkan-icd-loader lib32-vulkan-icd-loader

	# treat anything else as a negative response
	else

	   echo "You replied $input, you don't need Intel video driver"
	   echo
	   echo "Moving on"

fi

	echo
	
	check_exit_status
}

# Running Arco Linux Setup Scripts
function intel2() {
	echo
	echo "Installing Intel video driver"
	echo
	sleep 3s
	echo
	sudo pacman -S lib32-mesa vulkan-intel lib32-vulkan-intel vulkan-icd-loader lib32-vulkan-icd-loader
	echo
	check_exit_status
}

# searching for the fastest mirrors
function gdm() {
	read -p "DO YOU WANT TO ENABLE GDM DISPLAY MANAGER? [y,n]" answer 

            if [ "$answer" == "y" ]
            then
            	echo "You replied $input, you do want to enable GDM Display Manager."
		echo
		echo "Enabling GDM Display Manager."
		echo
		sleep 3s
		echo
		sudo systemctl enable gdm.service -f
		echo

            if [ "$answer" == "n" ]
            then
		echo "You replied $input, you don't want to enable GDM Display Manager"
		echo
		echo "Moving on"
		sleep 15s
                
            fi
        fi

}

# Running Arco Linux Setup Scripts
function gdm2() {
	echo
	echo "Enabling GDM Display Manager"
	echo
	sleep 3s
	echo
	sudo systemctl enable gdm.service -f
	echo
	check_exit_status
}

# searching for the fastest mirrors
function lightdm() {
	echo "DO YOU WANT TO ENABLE LIGHTDM DISPLAY MANAGER? [y,n]"
	read input

	# did we get an input value?
	if [ "$input" == "" ]; then

	   echo "Nothing was entered by the user"

	# was it a y or a yes?
	elif [[ "$input" == "y" ]] || [[ "$input" == "yes" ]]; then

	   echo "You replied $input, you do want to enable LightDM Display Manager"
	   echo
	   echo "Enabling LightDM Display Manager"
	   echo
	   sleep 3s
           echo
           sudo systemctl enable Lightdm.service -f

	# treat anything else as a negative response
	else

	   echo "You replied $input, you don't want to enable LightDM Display Manager"
	   echo
	   echo "Moving on"

fi

	echo
	
	check_exit_status
}

# Running Arco Linux Setup Scripts
function lightdm2() {
	echo
	echo "Enabling LightDM Display Manager"
	echo
	sleep 3s
	echo
	sudo systemctl enable lightdm.service -f
	echo
	check_exit_status
}

# Installing Guest Additions,if needed
function virtualbox() {
	
	read -p "IS THIS A VBOX VM, INSTALL GUEST ADDITIONS? [y,n]" answer 

            if [ "$answer" == "y" ]
            then
            	echo "You replied $input, this is a Vbox VM"
		echo
		echo "Installing Guest Additions"
		echo
		sleep 3s
		echo
		sudo pacman -S virtualbox-guest-modules-arch virtualbox-guest-utils --noconfirm

            if [ "$answer" == "n" ]
            then
		echo "You replied $input, this is not a VM"
		echo
		echo "Moving on"
		sleep 15s
                
            fi
        fi

}
	

# Running Arco Linux Setup Scripts
function virtualbox2() {
	echo
	echo "Installing Guest Additions"
	echo
	sleep 3s
	echo
	sudo pacman -S virtualbox-guest-modules-arch virtualbox-guest-utils --noconfirm
	echo
	check_exit_status
}


function leave() {

	echo
	echo "---------------------------------------"
	echo "---- ArcoLinux has been installed! ----"
	echo "---------------------------------------"
	echo
	echo "This PC may need to be restarted"
	echo
	echo
	echo
	echo "Restarting in 15 Seconds"
	sleep 15s
	reboot
}
leave
