#!/bin/sh
# very simple solution, since urxvt is very nice about window titles
# wmctrl will simply switch to first window with the corresponding name in the title
STATUS=$(wmctrl -lx | grep urxvt.URxvt)
echo $STATUS
if [ "$STATUS" ];
then
	wmctrl -a urxvt.URxvt -x
else
	urxvt -e zsh -c "tmux -q has-session && exec tmux attach-session -d || exec tmux new-session -n$USER -s$USER"
fi
