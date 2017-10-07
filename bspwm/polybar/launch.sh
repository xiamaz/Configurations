#!/usr/bin/sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
MONITOR=DP-3 polybar top &
MONITOR=DP-3 polybar bottom &
MONITOR=DVI-I-1 polybar top &
MONITOR=DVI-I-1 polybar bottom &

echo "Bars launched..."
