#!/bin/bash

if [[ $(whoami) != "root" ]] ; then
	echo "Must start this script as ROOT user!!!!"
	exit 80
fi

echo "====================================="
echo Install base packages
echo "====================================="

pacman -S vim sudo

echo "====================================="
echo Create first user
echo "====================================="

# Create human user
read -p "User name to create (human): " USERNAME

if [[ ! $USERNAME ]] ; then
	USERNAME="human"
fi

useradd -m -G wheel $USERNAME
passwd $USERNAME

read -p "/!\\ Now, you must add the group 'wheel' to sudoers! The line is already there, just uncomment it. Also, add to secured_path '...:/home/$USERNAME/.bin:/var/lib/snapd/snap/bin' (press any key to continue)"

EDITOR=vim visudo

echo "====================================="
echo "==== Start software installation ===="
echo "====================================="
SCRIPT_DIR=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)

echo "Changing user from $USER to $USERNAME to run scripts/install-software.sh"
su $USERNAME -Pc "bash ${SCRIPT_DIR}/scripts/install-software.sh"

