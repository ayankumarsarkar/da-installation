# if sudo is not installed
# sudo apt install sudo
# use this if usermod did not work
sudo usermod -aG $user,input,video,plugdev $user

echo "Installing wget, gcc, and make temporarily..."
sudo apt install wget gcc make libpam0g-dev

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
echo "Installing Sway..."
sudo apt install sway

echo "Installing Waybar..."
sudo apt install waybar

echo "Instaaling Rofi..."
sudo apt install rofi

echo "Installing Alacritty..."
sudo apt install alacritty

echo "Installing PCManFM-qt..."
sudo apt install pcmanfm-qt

echo "Installing Falkon..."
sudo apt install falkon

echo "Installing Bluefish..."
sudo apt install bluefish


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
echo "Copying Sway configs..."
cp config.sway ~/.config/sway/config

echo "Copying Waybar configs..."
cp -r waybar ~/.config/waybar

echo "Removing installation prerequisites..."
sudo apt remove wget gcc make libpam0g-dev
echo "Removing eccess fat..."
sudo apt autoremove