#!/bin/sh
# very simple solution, since urxvt is very nice about window titles
# wmctrl will simply switch to first window with the corresponding name in the title
STATUS=$(wmctrl -l | grep urxvt.URxvt)
echo $STATUS
if [ "$STATUS" ];
then
	wmctrl -a urxvt
else
	urxvt
fi
