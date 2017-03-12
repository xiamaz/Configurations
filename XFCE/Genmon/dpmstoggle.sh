#!/bin/bash
presentation_mode=$(xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/presentation-mode -v)

if $presentation_mode; then
	echo "<img>/home/max/SystemSettings/dpms/teahot.png</img>
	<click>$HOME/SystemSettings/dpms/tog.sh</click>"
else
	echo "<img>/home/max/SystemSettings/dpms/teacold.png</img>
	<click>$HOME/SystemSettings/dpms/tog.sh</click>"
fi
