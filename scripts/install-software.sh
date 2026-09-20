#!/bin/bash

if [[ $(whoami) == "root" ]] ; then
	echo "Don't start this script as ROOT user!!!!"
	exit 80
fi

function yes_no {
    while true; do
        read -p "$* [y/n]: " yn
        case $yn in
            [Yy]*) return 0  ;;
            [Nn]*) echo "Aborted" ; return  1 ;;
        esac
    done
}

echo "====================================="
echo Update
echo "====================================="
sudo pacman -Syu

echo "====================================="
echo Install packages
echo "====================================="

INSTALL_i3="xorg-xinit polybar rofi kitty i3wm i3status xorg-xrandr ttf-nerd-fonts-symbols"
INSTALL_bluetooth="bluez bluez-utils"

sudo pacman -S --needed base-devel
sudo pacman -S vim wget git less man android-file-transfer imagemagick openssh $INSTALL_i3 $INSTALL_bluetooth

systemctl enable --now bluetooth

git config --global core.editor "vim"

echo "====================================="
echo Install yay
echo "====================================="
cd /tmp
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

echo "====================================="
echo "Install mega-cmd"
echo "====================================="
cd /tmp
wget https://mega.nz/linux/repo/Arch_Extra/x86_64/megacmd-x86_64.pkg.tar.zst
sudo pacman -U "megacmd-x86_64.pkg.tar.zst"
mkdir ~/mega
read -p "MEGA username:" megaUsername
read -p "MEGA password:" megaPassword
mega-login "$megaUsername" "$megaPassword"
megaUsername=
megaPassword=
mega-sync ~/mega /

echo "====================================="
echo Install audio
echo "====================================="
sudo pacman -S pipewire pipewire-audio pipewire-pulse pipewire-alsa wireplumber wiremix
systemctl --user enable --now pipewire pipewire-pulse wireplumber

echo "====================================="
echo Install firefox
echo "====================================="
sudo pacman -Sy firefox

echo "====================================="
echo Install nordvpn
echo "====================================="
systemctl enable --now snapd
sudo snap install nordvpn

sudo groupadd nordvpn
sudo usermod -aG nordvpn $USER

sudo snap connect nordvpn:system-observe
sudo snap connect nordvpn:hardware-observe
sudo snap connect nordvpn:network-control
sudo snap connect nordvpn:network-observe
sudo snap connect nordvpn:firewall-control
sudo snap connect nordvpn:login-session-observe
sudo snap connect nordvpn:network-manager

echo "====================================="
echo Install common config
echo "====================================="
SCRIPT_DIR=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)
cd "$SCRIPT_DIR"
bash ./config-install.sh

echo "====================================="
echo Install some additional packages?
echo "====================================="
if [ yes_no "Install Visual Studio Code? " ] ; then
	yay -S visual-studio-code-bin
fi

if [ yes_no "Install Unity? " ] ; then
	yay -S unityhub dotnet-sdk mono mono-msbuild mono-msbuild-sdkresolver
	sudo pacman -S aspnet-runtime dotnet-runtime dotnet-sdk mono-msbuild mono-msbuild-sdkresolver mono
	echo "Extensions à installer dans vscode : C#, Debugger for Unity, Unity Tools, vscode-solution-explorer"
fi

if [ yes_no "Install Libre Office? " ] ; then
	sudo pacman -S libreoffice-still
fi

