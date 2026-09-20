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

# Update
sudo pacman -Syu

# Install packages
sudo pacman -S --needed base-devel
sudo pacman -S vim wget git xorg-xinit polybar rofi kitty less i3wm i3status bluez bluez-utils man xorg-xrandr android-file-transfer imagemagick openssh

systemctl enable --now bluetooth

git config --global core.editor "vim"

# Install yay
cd /tmp
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# Install mega-cmd
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

# Install audio
sudo pacman -S pipewire pipewire-audio pipewire-pulse pipewire-alsa wireplumber wiremix
systemctl --user enable --now pipewire pipewire-pulse wireplumber

# Install firefox
sudo pacman -Sy firefox

# Install nordvpn
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

# Install env
SCRIPT_DIR=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)
cd "$SCRIPT_DIR"
bash ./config-install.sh

# Install conditional packages
if [ yes_no "Install vscode? " ] ; then
	yay -S visual-studio-code-bin
fi
if [ yes_no "Install unity? " ] ; then
	yay -S unityhub dotnet-sdk mono mono-msbuild mono-msbuild-sdkresolver
	sudo pacman -S aspnet-runtime dotnet-runtime dotnet-sdk mono-msbuild mono-msbuild-sdkresolver mono
	echo "Extensions à installer dans vscode : C#, Debugger for Unity, Unity Tools, vscode-solution-explorer"
fi

