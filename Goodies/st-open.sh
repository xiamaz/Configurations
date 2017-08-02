#!/bin/dash
# very simple solution, since urxvt is very nice about window titles
# wmctrl will simply switch to first window with the corresponding name in the title
STATUS=$(wmctrl -lx | grep st-256color.st-256color)
echo $STATUS
if [ "$STATUS" ];
then
	wmctrl -a st-256color.st-256color -x
else
	st -e dash -c "tmux -q has-session && exec tmux attach-session -d || exec tmux new-session -n$USER -s$USER"
fi
