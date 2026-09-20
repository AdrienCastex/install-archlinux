#!/bin/bash

if [[ $(whoami) != "root" ]] ; then
	echo "Must start this script as ROOT user!!!!"
	exit 80
fi

pacman -S vim sudo

# Create human user
read -p "User name to create (human): " USERNAME

if [[ ! $USERNAME ]] ; then
	USERNAME="human"
fi

useradd -m -G wheel $USERNAME
passwd $USERNAME

read -p "/!\\ Now, you must add the group 'wheel' to sudoers! The line is already there, just uncomment it. (press any key to continue)"

EDITOR=vim visudo

