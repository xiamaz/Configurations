#!/bin/bash
# script for adding undetected resolutions to our eizo crt monitor
displayName="$1"
# first add the most important primary mode
mode="1400x1050_85" 
modeline="179.50  1400 1512 1656 1912  1050 1053 1057 1105 -hsync +vsync"
xrandr --newmode $mode "$modeline"
xrandr --addmode $displayName $mode
