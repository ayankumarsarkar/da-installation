# if sudo is not installed
# apt install sudo
#sudo apt install seatd
sudo apt install wget gcc make
# use this if usermod did not work
# /usr/shin/usermod -aG user $user

# ask for $user if none found

# switch to user space

# create default folders
mkdir ~/.config/
mkdir ~/.config/sway/
mkdir ~/.config/falkon
mkdir ~/.config/bluefish
mkdir ~/.config/rofi-wayland
mkdir ~/.config/waybar
mkdir ~/Desktop/
mkdir ~/Documents/
mkdir ~/Inbox/
mkdir ~/Pictures/
mkdir ~/Templates/
mkdir ~/Videos/

# install software
sudo apt install sway
sudo apt install waybar
sudo apt install rofi
sudo apt install alacritty
sudo apt install pcmanfm-qt
sudo apt install falkon
sudo apt install bluefish

git clone https://github.com/javalsai/lidm.git
cd lidm
make # 👍

sudo apt install ~/Inbox/lidm
#wget <link to TutaMail> 
#wget <link to Koofr>

# Copy configs
cp config.sway ~/.config/sway/config
cp -r waybar ~/.config/waybar

sudo apt remove wget gcc make
sudo apt autoremove