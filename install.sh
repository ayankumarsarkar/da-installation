#!/bin/bash

check_installation_of() {
    command -v "$1" &> /dev/null
}

read -p "Do you want to run this script? (y/n): " confirm

if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
    echo "Exiting..."
    exit 0
fi
unset confirm
echo "Starting..."

# if sudo is not installed
# sudo apt install sudo
# use this if usermod did not work
sudo usermod -aG input,video,plugdev $USER

echo "Setting up Bash..."
mkdir -p $HOME/System/bash


read -p "Do you want to install anything? (y/n): " confirm

if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
    echo "Exiting..."
    exit 0
fi
unset confirm

echo "Installing wget, gcc, and make temporarily..."
if check_installation_of lidm; then
    sudo apt install wget gcc make xorg unzip
else
    sudo apt install wget gcc make libpam0g-dev xorg unzip
fi
# ask for $user if none found

# switch to user space

# create default folders
read -p "Do you want to (re)create missing directories? (y/n): " confirm

if [[ "$confirm" != "n" && "$confirm" != "N" ]]; then
    echo "(Re)creating (missing) directories..."
    mkdir $HOME/.config/ # Soon $HOME/System
    mkdir $HOME/Desktop/
    mkdir $HOME/Documents/
    mkdir $HOME/Inbox/
    mkdir $HOME/Pictures/
    mkdir $HOME/Templates/
    mkdir $HOME/Videos/
    echo " ...done."
fi

echo "Configuring bash profile..."
#mv $HOME/.bash_profile $HOME/Inbox/bashrc_original
cp bash.conf $HOME/.bash_profile
source $HOME/.bash_profile
echo " ...done."

# install software

source install-software.sh

# Copy configs

echo "Copying Bash config..."
cp -r bash $XDG_CONFIG_HOME/

echo "Copying X11 configs..."
cp xorg.conf $XDG_CONFIG_HOME/.xinitrc

#echo "Copying i3 configs..."
#cp -r i3 $XDG_CONFIG_HOME/

#echo "Copying Waybar configs..."
#cp -r waybar ~/.config/waybar
#git clone https://github.com/prcxzm/polybar-themes
#cp -r polybar-themes/simple $XDG_CONFIG_HOME/polybar
cp -r polybar $XDG_CONFIG_HOME/

echo "Removing installation prerequisites..."
sudo apt remove wget gcc make libpam0g-dev
echo "Removing eccess fat..."
sudo apt autoremove

echo "Reboot required..."