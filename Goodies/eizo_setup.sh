#!/bin/bash
# script for adding undetected resolutions to our eizo crt monitor
displayName="$1"


mode6="1400x1050_85.00" 
xrandr --newmode "$mode6" 179.50  1400 1512 1656 1912  1050 1053 1057 1105 -hsync +vsync
xrandr --addmode $displayName $mode6

# first add the most important primary mode
# 1280x1024 is supposed to be the default resolution, but the ratio is stretched, let us use
# 1280x960 instead
mode1="1280x960_95.00"
xrandr --newmode $mode1  168.25  1280 1376 1512 1744  960 963 967 1017 -hsync +vsync
xrandr --addmode $displayName $mode1

# try to add other diplay modes automatically

mode3="1600x1200_76.00"  
xrandr --newmode $mode3 207.50  1600 1720 1888 2176  1200 1203 1207 1256 -hsync +vsync
xrandr --addmode $displayName $mode3 

mode2="1024x768_115.00"
xrandr --newmode $mode2 131.75  1024 1104 1208 1392  768 771 775 824 -hsync +vsync
xrandr --addmode $displayName $mode2

mode4="800x600_144.00" 
xrandr --newmode $mode4 102.50  800 864 944 1088  600 603 607 655 -hsync +vsync
xrandr --addmode $displayName $mode4

mode5="640x480_160.00"  
xrandr --newmode $mode5 73.00  640 688 752 864  480 483 487 530 -hsync +vsync
xrandr --addmode $displayName $mode5

