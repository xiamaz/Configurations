#!/bin/sh
killall -q sxhkd

config_files="$HOME/.config/sxhkd/sxhkdrc $HOME/.config/sxhkd/sxhkdrc.host"

if [ "base" != "$1" ]; then
	config_files="$config_files $HOME/.config/sxhkd/sxhkdrc.bspwm"
fi

SXHKD_SHELL=/bin/dash sxhkd -c $config_files &
