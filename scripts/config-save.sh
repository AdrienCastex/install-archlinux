#!/bin/bash

if [[ $(whoami) == "root" ]] ; then
	echo "Don't start this script as ROOT user!!!!"
	exit 80
fi

SCRIPT_DIR=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)
cd "$SCRIPT_DIR"

cp ~/.xinitrc ./xinitrc

cp -rLT ~/.bin ./bin

mkdir -p ./config

cp -rL ~/.config/i3 ./config/
cp -rL ~/.config/rofi ./config/
cp -rL ~/.config/kitty ./config/
cp -rL ~/.config/polybar ./config/

cp /usr/share/X11/xorg.conf.d/50-touchpad.conf 50-touchpad.conf

cp ~/.bashrc bashrc

