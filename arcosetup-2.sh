#!/bin/bash
# Finish Setup my ArcoLinux

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

	echo
	echo "+-------------------------------------------------------------------------+"
	echo "|-- Hello, $USER. Let's Finish settting up your fresh ArcoLinux install.--|"
	echo "+-------------------------------------------------------------------------+"
	echo
	echo "This is not a silent install" 
	echo
	echo "you will be asked several questions as it progresses"
	sleep 5s
}

# searching for the fastest mirrors
function mirror() {

	echo "Updating your Mirrors."
	sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist;
	check_exit_status
}

# Downloading and installing all Arch Linux and ArcoLinux packages
function general_update() {

	echo "Updating Arch & Arco."
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
	sudo pacman -Rdsu gnome-books gnome-clocks gnome-terminal gnome-documents gnome-maps gnome-music gnome-todo gnome-weather gnome-boxes epiphany totem --noconfirm;
	check_exit_status
}

# Running Arco Linux Setup Scripts
function arco() {
	echo
	echo "Running Arco Linux Setup Scripts"
	echo
	sleep 3s
	cd /arco-gnome/ArcoInstall/
	echo
	sh ArcoInstall/000-use-all-cores-makepkg-conf-v*.sh
	sh ArcoInstall/110-install-sound-v*.sh
	sh ArcoInstall/120-bluetooth-v*.sh
	sh ArcoInstall/121-fix-bluetooth-switch-not-working-v*.sh
	sh ArcoInstall/130-install-printers-v*.sh
	sh ArcoInstall/140-install-samba-v*.sh
	sh ArcoInstall/150-install-network-discovery-v*.sh
	sh ArcoInstall/200-software-arch-linux-repo-v*.sh
	sh ArcoInstall/300-software-AUR-repo-v*.sh
	sh ArcoInstall/400-software-arch-linux-repo-distro-specific-v*.sh
	sh ArcoInstall/500-software-AUR-repo-distro-specific-v*.sh
	sh ArcoInstall/600-software-from-ArcoLinux-repo-v*.sh
	sh ArcoInstall/700-installing-fonts-v*.sh
	sh ArcoInstall/900-fix-microcode-error-v*.sh
	read -p "Is this a laptop? (y/n) " answer

            if [ "$answer" == "y" ]
            then
                sh ArcoInstall/160-install-tlp-for-laptops-v*.sh
            fi

	check_exit_status
}

# copy update script to final location
function update_script() {

	echo "Moving Update Script to final location."
	echo
	sleep 3s
	sudo mv Personal/arcoupdate ~/.bin/;
	cd ~/.bin 
	chmod u+x arcoupdate
	check_exit_status
}

# Put the fancy bash promt back after updating
function fix_bashrc() {

	echo "Making Terminal fancy."
	echo
	sleep 3s
	sudo cp -r Personal/.fancy-user-bash.sh ~/;
	sudo cp -r Personal/.fancy-root-bash.sh ~/;
	echo "source ~/.fancy-user-bash.sh" >> ~/.bashrc
	echo
	gsettings set org.gnome.desktop.default-applications.terminal exec 'terminator'
	echo
	sudo ln -s /usr/bin/gnome-terminal
	check_exit_status
}

# Installing my Icon Themes
function icons() {

	echo "Giving Gnome a facelift."
	echo
	sleep 3s
	git clone https://github.com/pop-os/icon-theme pop-icon-theme
	cd pop-icon-theme
	meson build
	sudo ninja -C "build" install
	sudo mv pop-icon-theme/ ~/;
	#gsettings set org.gnome.desktop.interface icon-theme 'Pop'
	echo
	git clone https://github.com/daniruiz/flat-remix && mkdir -p ~/.icons && cp -r flat-remix/Flat-Remix* ~/.icons/
	gsettings set org.gnome.desktop.interface icon-theme "Flat-Remix-Blue-Dark"
	
	check_exit_status
}

# Setting up Favorite Dock icons
function dock() {

	echo "Setting up the Dock."
	echo
	sleep 3s
	cp /usr/share/applications/plank.desktop ~/.config/autostart/
	sudo chmod +x ~/.config/autostart/plank.desktop
	echo
	gsettings set org.gnome.shell favorite-apps "['firefox.desktop', 'chromium.desktop', 'org.gnome.Nautilus.desktop', 'simplenote.desktop', 'terminator.desktop', 'realvnc-vncviewer.desktop', 'com.teamviewer.TeamViewer.desktop', 'virtualbox.desktop', 'onboard.desktop']"
	
	check_exit_status
}

# Put the wallpaper
function backgrounds() {

	echo "Setting up Favorite Wallpaper."
	echo
	sleep 3s
	sudo mv ~/arco-gnome/Personal/backgrounds/my_arcolinux /usr/share/backgrounds/
	sudo mv ~/arco-gnome/Personal/backgrounds/my_gnome /usr/share/backgrounds/
	sudo mv ~/arco-gnome/Personal/backgrounds/my_wall /usr/share/backgrounds/
	echo
	sudo rm -rf /usr/share/backgrounds/arcolinux
	sudo rm -rf /usr/share/backgrounds/gnome
	check_exit_status
}

# Installing Nvidia drivers,if needed
function nvidia() {

	echo "Installing Nvidia drivers,if needed."
	echo
	read -p "Do you need Nvidia video drivers? (y/n) " answer

            if [ "$answer" == "y" ]
            then
                sudo pacman -S nvidia nvidia-utils lib32-nvidia-utils nvidia-settings vulkan-icd-loader lib32-vulkan-icd-loader
            fi

	check_exit_status
}

# Installing Intel drivers,if needed
function intel() {

	echo "Installing Intel drivers,if needed."
	echo
	read -p "Do you need Intel video drivers? (y/n) " answer

            if [ "$answer" == "y" ]
            then
                sudo pacman -S lib32-mesa vulkan-intel lib32-vulkan-intel vulkan-icd-loader lib32-vulkan-icd-loader

            fi

	check_exit_status
}

# Put the fancy bash promt back after updating
function virtualbox() {

	echo
	read -p "Is this being setup in virtualbox? (y/n) " answer

            if [ "$answer" == "y" ]
            then
                sudo pacman -S virtualbox-guest-modules-arch virtualbox-guest-utils --noconfirm

            fi

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

greeting
mirror
general_update
debloat
arco
update_script
fix_bashrc
icons
dock
backgrounds
nvidia
intel
#virtualbox
leave
