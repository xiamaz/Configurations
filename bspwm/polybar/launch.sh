#!/bin/sh
MAIN_MONITOR='eDP1'

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch internal laptop bar and external monitor bars with less information
for monitor in "$( bspc query -M --names )"; do
	echo $monitor
	if [ "$monitor" == $MAIN_MONITOR ]; then
	 	MONITOR=$monitor polybar main &
	else
	 	MONITOR=$monitor polybar side &
	fi
done

echo "Bars launched..."
