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

greeting() {

	echo
	echo "Hello, $USER. Let's Finish settting up your fresh ArcoLinux install."
	echo
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
	sudo pacman -Rdsu gnome-books gnome-clocks  gnome-documents gnome-maps gnome-music gnome-todo gnome-weather gnome-boxes epiphany totem --noconfirm;
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
	sudo mv arco-gnome/Personal/arcoupdate ~/.bin/;
	cd .bin 
	chmod u+x arcoupdate
	check_exit_status
}

# Put the fancy bash promt back after updating
function fix_bashrc() {

	echo "Making Terminal fancy."
	echo
	sleep 3s
	sudo mv arco-gnome/Personal/.fancy-user-bash.sh ~/;
	sudo mv arco-gnome/Personal/.fancy-root-bash.sh ~/;
	echo "source ~/.fancy-user-bash.sh" >> ~/.bashrc
	check_exit_status
}

# Put the fancy bash promt back after updating
function pop() {

	echo "Installing my Icon Theme."
	echo
	sleep 3s
	git clone https://github.com/pop-os/icon-theme pop-icon-theme
	cd pop-icon-theme
	meson build
	sudo ninja -C "build" install
	sudo mv pop-icon-theme/ ~/;
	gsettings set org.gnome.desktop.interface icon-theme 'Pop'
	
	check_exit_status
}

# Put the fancy bash promt back after updating
function pop() {

	echo "Installing my Icon Theme."
	echo
	sleep 3s
	gsettings set org.gnome.desktop.interface icon-theme 'Pop'
	
	check_exit_status
}

function leave() {

	echo
	echo "-------------------------------------"
	echo "---- ArcoLinux has been installed! ----"
	echo "-------------------------------------"
	echo
	echo "This PC may need to be restarted"
	echo
	echo "You can now recieve the full upgrades that ArcoLinux releases once a month by opening terminal and typing"
	echo 
	echo "arcoupdate"
	echo
	echo "Restarting in 15 Seconds"
	sleep 15s
	reboot
}

mirror
general_update
debloat
arco
update_script
fix_bashrc
pop
leave
