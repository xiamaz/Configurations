#!/bin/sh
# very simple solution, since urxvt is very nice about window titles
# wmctrl will simply switch to first window with the corresponding name in the title
STATUS=$(wmctrl -lx | grep urxvt.URxvt)
echo $STATUS
if [ "$STATUS" ];
then
	wmctrl -ax urxvt.URxvt
else
	urxvt
fi
