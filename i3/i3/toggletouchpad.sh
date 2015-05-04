#!/bin/bash
if synclient -l | grep "TouchpadOff .*=.*0" ; then
	synclient TouchpadOff=1 ;
	notify-send -t 1 Touchpad off;
else
        synclient TouchpadOff=0 ;
	notify-send -t 1 Touchpad on;
fi
