#!/bin/bash

SCRIPT_DIR=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)
cd "$SCRIPT_DIR"

mkdir -p ~/.bin
mkdir -p ~/.config
mkdir -p ~/projects

cp xinitrc ~/.xinitrc
cp -r config/* ~/.config/
cp -r bin/* ~/.bin
cp bashrc ~/.bashrc

chmod u+x ~/.bin/*
chmod u+x ~/.config/rofi/list.sh

sudo cp 50-touchpad.conf /usr/share/X11/xorg.conf.d/50-touchpad.conf 
sudo chmod +xr /usr/share/X11/xorg.conf.d/50-touchpad.conf 
sudo cp 50-touchpad.conf /etc/X11/xorg.conf.d/50-touchpad.conf
sudo chmod +xr /etc/X11/xorg.conf.d/50-touchpad.conf
