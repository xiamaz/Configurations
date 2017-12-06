#!/bin/sh
name="2560x1440_50"
cvt='256.25  2560 2736 3008 3456  1440 1443 1448 1484 -hsync +vsync'
xrandr --newmode $name $cvt
xrandr --addmode HDMI2 $name
xrandr --output HDMI2 --mode $name
nitrogen --restore
$HOME/.config/polybar/launch.sh
