#!/bin/bash

check_installation_of() {
   command -v "$1" &> /dev/null
}

echo "Checking installation of I3wm..."
if check_installation_of i3; then
    echo "* Already installed."
else
    echo "Installing I3wm..."
    mkdir $XDG_CONFIG_HOME/i3
    sudo apt install i3
fi

echo "Checking installation of Polybar..."
if check_installation_of polybar; then
    echo "* Already installed."
else
    echo "Installing Polybar..."
    mkdir $XDG_CONFIG_HOME/polybar
    sudo apt install polybar
fi

echo "Checking installation of Rofi..."
if check_installation_of rofi; then
    echo "* Already installed."
else
    echo "Installing Rofi..."
    mkdir $XDG_CONFIG_HOME/rofi
    sudo apt install rofi
fi

echo "Checking installation of Alacritty..."
if check_installation_of alacritty; then
    echo "* Already installed."
else
    echo "Installing Alacritty..."
    mkdir $XDG_CONFIG_HOME/alacritty
    sudo apt install alacritty
fi

# PCManFM-qt is part of core-lxqt so out of the equation
# PCManFM was considered but its development seem to have
# become stalled and its desktop does not work well with
# i3 window manager. Hence, both of them are removed from
# this Distribution or whatever it is I am building. This
# block of text is in their sweet memory. Time to move on

echo "Checking installation of Ranger..."
if check_installation_of ranger; then
    echo "* Already installed."
else
    echo "Installing Ranger..."
    mkdir $XDG_CONFIG_HOME/ranger
    sudo apt install ranger
fi

echo "Checking installation of Zathura..."
if check_installation_of zathura; then
    echo "* Already installed."
else
    echo "Installing Zathura..."
    mkdir $XDG_CONFIG_HOME/zathura
    sudo apt install zathura zathura-pdf-popler
fi
# This is an awesome piece of softwere that I discovered
# randomly

echo "Checking installation of MPV..."
if check_installation_of mpv; then
    echo "* Already installed."
else
    echo "Installing MPV..."
    mkdir $XDG_CONFIG_HOME/mpv
    sudo apt install mpv
fi
# Settled on MPV for video player because it works and it
# is larger than VLC but shorter then Celluloid

echo "Checking installation of Feh..."
if check_installation_of feh; then
    echo "* Already installed."
else
    echo "Installing Feh..."
    mkdir $XDG_CONFIG_HOME/feh
    sudo apt install feh
fi
# Went with Feh because it is familiar; may change later

# KeePassXC for Password Management

echo "Checking installation of falkon..."
if check_installation_of falkon; then
    echo "* Already installed."
else
    echo "Installing Falkon..."
    mkdir $XDG_CONFIG_HOME/falkon
    sudo apt install falkon
fi # Falkon is giving me pain... a bit

echo "Checking installation of bluefish..."
if check_installation_of bluefish; then
    echo "* Already installed."
else
    echo "Installing Bluefish..."
    mkdir $XDG_CONFIG_HOME/bluefish
    sudo apt install bluefish
fi # I may replace bluefish with Zed unfortunately

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
    wget https://app.tuta.com/desktop/tutanota-desktop-linux.AppImage
    echo "Installing..."
    mv tutanota-desktop-linux.AppImage $SYSTEM_BIN_HOME/tutanota-desktop-linux.AppImage
    chmod u+x $SYSTEM_BIN_HOME/tutanota-desktop-linux.AppImage
    echo ".. done"
fi # This has a bizare TLS1.5 Handshake error as does Chromium

#wget <link to Koofr>
# ^^^ It's installation is the most confusing of all.

sudo apt install --no-install-recommends lxqt-core lxqt-config lxqt-session lxqt-policykit

sudo apt remove pcmanfm-qt lxqt-panel