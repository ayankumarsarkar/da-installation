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

#echo "Setting up Bash..."
#mkdir -p $HOME/System/bash


read -p "Do you want to install anything? (y/n): " confirm

if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
    echo "Exiting..."
    exit 0
fi
unset confirm

echo "Installing wget, gcc, and make temporarily..."
if check_installation_of lidm; then
    sudo apt install wget gcc make xorg
else
    sudo apt install wget gcc make libpam0g-dev xorg
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
#echo "Installing Sway..."
#sudo apt install sway
#mkdir ~/.config/sway/
echo "Checking installation of i3..."
if check_installation_of i3; then
    echo "* Already installed."
else
    echo "Installing i3..."
    mkdir $XDG_CONFIG_HOME/i3
    sudo apt install i3
fi

#echo "Installing Waybar..."
#sudo apt install waybar
#mkdir ~/.config/waybar
echo "Checking installation of polybar..."
if check_installation_of polybar; then
    echo "* Already installed."
else
    echo "Installing Polybar..."
    mkdir $XDG_CONFIG_HOME/polybar
    sudo apt install polybar
fi

echo "Checking installation of rofi..."
if check_installation_of rofi; then
    echo "* Already installed."
else
    echo "Installing Rofi..."
    mkdir $XDG_CONFIG_HOME/rofi
    sudo apt install rofi
fi

echo "Checking installation of alacritty..."
if check_installation_of alacritty; then
    echo "* Already installed."
else
    echo "Installing Alacritty..."
    mkdir $XDG_CONFIG_HOME/alacritty
    sudo apt install alacritty
fi

#echo "Installing PCManFM-qt..."
#sudo apt install pcmanfm-qt
echo "Checking installation of pcmanfm..."
if check_installation_of pcmanfm; then
    echo "* Already installed."
else
    echo "Installing PCManFM..."
    mkdir $XDG_CONFIG_HOME/pcmanfm
    sudo apt install pcmanfm
fi

echo "Checking installation of falkon..."
if check_installation_of falkon; then
    echo "* Already installed."
else
    echo "Installing Falkon..."
    mkdir $XDG_CONFIG_HOME/falkon
    sudo apt install falkon
fi

echo "Checking installation of bluefish..."
if check_installation_of bluefish; then
    echo "* Already installed."
else
    echo "Installing Bluefish..."
    mkdir $XDG_CONFIG_HOME/bluefish
    sudo apt install bluefish
fi

echo "Checking installation of sqlitebrowser..."
if check_installation_of sqlitebrowser; then
    echo "* Already installed."
else
    echo "Installing sqlitebrowser..."
    mkdir $XDG_CONFIG_HOME/sqlitebrowser
    sudo apt install sqlitebrowser
fi


echo "Checking installation of lidm..."
if check_installation_of lidm; then
    echo "* Already installed."
else
    echo "Getting LiDM source..."
    sudo git clone https://github.com/javalsai/lidm.git
    cd lidm
    echo "Compiling source..."
    sudo make CFLAGS="-D_GNU_SOURCE" CXXFLAGS="-D_GNU_SOURCE" # 👍
    echo "Installing..."
    sudo make install
    sudo make install-service-systemd
    cd ..
    sudo systemctl enable lidm
    echo "...Done"
fi

echo "Checking installation of tuta..."
if check_installation_of tuta; then
    echo "* Already installed."
else
    echo "Getting AppImage..."
    wget https://app/tuta.com/desktop/tutanota-desktop-linux.AppImage
    echo "Installing..."
    mv tutanota-desktop-linux.AppImage $SYSTEM_BIN_HOME/tutanota-desktop-linux.AppImage
    chmod u+x $SYSTEM_BIN_HOME/tutanota-desktop-linux.AppImage
    echo ".. done"
fi

#wget <link to Koofr>

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