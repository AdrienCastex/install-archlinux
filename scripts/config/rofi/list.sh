#!/bin/bash

if [[ "$#" -eq "0" ]] ; then
	ls /home/human/.bin/
	echo poweroff
	echo reboot
	echo veille
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
		veille)
			systemctl hibernate -i &
			;;
		*)
			/home/human/.bin/$@ > /dev/null 2>&1 &
			;;
	esac
fi

