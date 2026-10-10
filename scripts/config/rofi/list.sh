#!/bin/bash

if [[ "$#" -eq "0" ]] ; then
	ls /home/human/.bin/
	echo poweroff
	echo reboot
	echo veille_hibernate
	echo veille_suspend
	echo exit
else
	case "$1" in
		poweroff)
			systemctl poweroff -i &
			;;
		reboot)
			systemctl reboot -i &
			;;
		exit)
			i3-msg exit &
			;;
		veille_suspend)
			/home/$USER/.bin/power-suspend > /dev/null 2>&1 &
			;;
		veille_hibernate)
			/home/$USER/.bin/power-hibernate > /dev/null 2>&1 &
			;;
		*)
			/home/$USER/.bin/$@ > /dev/null 2>&1 &
			;;
	esac
fi

