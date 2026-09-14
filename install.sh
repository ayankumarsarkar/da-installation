#!/bin/bash

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

read -p "Do you want install anything? (y/n): " confirm

if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
    echo "Exiting..."
    exit 0
fi
unset confirm
echo "Installing wget, gcc, and make temporarily..."
sudo apt install wget gcc make libpam0g-dev xorg

# ask for $user if none found

# switch to user space

# create default folders
mkdir $HOME/.config/ # Soon $HOME/System
mkdir $HOME/Desktop/
mkdir $HOME/Documents/
mkdir $HOME/Inbox/
mkdir $HOME/Pictures/
mkdir $HOME/Templates/
mkdir $HOME/Videos/

mv ~/.bashrc ~/.config/Bash/bashrc

# install software
#echo "Installing Sway..."
#sudo apt install sway
#mkdir ~/.config/sway/
echo "Installing i3..."
sudo apt install i3
mkdir $XDG_CONFIG_HOME/i3

#echo "Installing Waybar..."
#sudo apt install waybar
#mkdir ~/.config/waybar
echo "Installing Polybar..."
sudo apt install polybar
mkdir $XDG_CONFIG_HOME/polybar

echo "Installing Rofi..."
sudo apt install rofi
mkdir $XDG_CONFIG_HOME/rofi

echo "Installing Alacritty..."
sudo apt install alacritty
mkdir $XDG_CONFIG_HOME/alacritty

#echo "Installing PCManFM-qt..."
#sudo apt install pcmanfm-qt
echo "Installing PCManFM..."
sudo apt install pcmanfm
mkdir $XDG_CONFIG_HOME/pcmanfm

echo "Installing Falkon..."
sudo apt install falkon
mkdir $XDG_CONFIG_HOME/falkon

echo "Installing Bluefish..."
sudo apt install bluefish
mkdir $XDG_CONFIG_HOME/bluefish

sudo git clone https://github.com/javalsai/lidm.git
cd lidm
sudo make CFLAGS="-D_GNU_SOURCE" CXXFLAGS="-D_GNU_SOURCE" # 👍
sudo make install
sudo make install-service-systemd
cd ..
sudo systemctl enable lidm

#wget <link to TutaMail> 
#wget <link to Koofr>

# Copy configs

echo "Copying Bash config..."
cp bash.conf $HOME/.bash_profile

echo "Copying X11 configs..."
cp xorg.conf $XDG_CONFIG_HOME/.xinitrc

echo "Copying i3 configs..."
cp -r i3 $XDG_CONFIG_HOME/i3

#echo "Copying Waybar configs..."
#cp -r waybar ~/.config/waybar
git clone https://github.com/prcxzm/polybar-themes
cp -r polybar-themes/simple ~/.config/polybar

echo "Removing installation prerequisites..."
sudo apt remove wget gcc make libpam0g-dev
echo "Removing eccess fat..."
sudo apt autoremove

echo "Reboot required..."