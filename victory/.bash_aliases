#Bash aliases to make life easier



# ipconfig
# A listing of your full ip address info, enp3s0 may need to changed if your nic is called something else.
alias ipconfig="nmcli dev show enp3s0"

# upall
# An alias taken from ArcoLinux one command to update everything
# For Debian and based destros
alias upall="sudo apt update && sudo  apt upgrade && sudo apt autoremove"

# ll
# A faster way to Long List a directory
alias ll="ls -la"
