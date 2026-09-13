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
mkdir ~/.config/
mkdir ~/Desktop/
mkdir ~/Documents/
mkdir ~/Inbox/
mkdir ~/Pictures/
mkdir ~/Templates/
mkdir ~/Videos/

# install software
#echo "Installing Sway..."
#sudo apt install sway
#mkdir ~/.config/sway/
echo "Installing i3..."
sudo apt install i3
mkdir ~/.config/i3/

#echo "Installing Waybar..."
#sudo apt install waybar
#mkdir ~/.config/waybar
echo "Installing Polybar..."
sudo apt install polybar
mkdir ~/.config/polybar

echo "Installing Rofi..."
sudo apt install rofi
mkdir ~/.config/rofi

echo "Installing Alacritty..."
sudo apt install alacritty

#echo "Installing PCManFM-qt..."
#sudo apt install pcmanfm-qt
echo "Installing PCManFM..."
sudo apt install pcmanfm

echo "Installing Falkon..."
sudo apt install falkon
mkdir ~/.config/falkon

echo "Installing Bluefish..."
sudo apt install bluefish
mkdir ~/.config/bluefish

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
echo "Copying X11 configs..."
cp config.xorg ~/.xinitrc

echo "Copying Sway configs..."
cp config.sway ~/.config/i3/config

#echo "Copying Waybar configs..."
#cp -r waybar ~/.config/waybar
git clone https://github.com/prcxzm/polybar-themes
cp -r polybar-themes/simple ~/.config/polybar

echo "Removing installation prerequisites..."
sudo apt remove wget gcc make libpam0g-dev
echo "Removing eccess fat..."
sudo apt autoremove

echo "Reboot required..."