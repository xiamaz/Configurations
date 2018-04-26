#!/bin/sh

current_desktop=$(xprop -root -notype _NET_CURRENT_DESKTOP | awk '{print $3}')
workspace_windows=$(wmctrl -l | awk -v d=$current_desktop '$2 == d { print $1 }')
not_workspace_windows=$(wmctrl -l | awk -v d=$current_desktop '$2 != d && $2 != -1 { print $1 }')

charging=$(</sys/class/power_supply/ADP1/online)

if [ $charging == 0 ]; then
for w in $not_workspace_windows; do
	p=$(xprop -notype -id $w _NET_WM_PID | awk '{print $3}')
	kill -STOP $p
done
fi
for w in $workspace_windows; do
	p=$(xprop -notype -id $w _NET_WM_PID | awk '{print $3}')
	kill -CONT $p
done

