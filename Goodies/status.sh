#!/usr/bin/bash
# get first temperature from coretemp
temp=$(sensors -u coretemp-isa-0000 | grep -i -m 1 input | grep -o "[^ ]*$")


# get ram numbers
ram=$(free -m | grep -i mem)
total=$(awk '{print $2}' <<< $ram)
used=$(awk '{print $3}' <<< $ram)

# get load
load=$(cat /proc/loadavg)
m1=$(awk '{print $1}' <<< $load)
m5=$(awk '{print $2}' <<< $load)
m15=$(awk '{print $3}' <<< $load)

# combine into status string
line="<span font_weight='bold'><span fgcolor='#D0B03C'>CPU</span> <span fgcolor='#FFE377'>$m1 $m5 $m15</span><span fgcolor='#72B3CC'>  RAM</span> <span fgcolor='#9CD9F0'>${used}M/${total}M</span> <span fgcolor='#C75646'>Temp</span> <span fgcolor='#E09690'>${temp%.*}°C</span></span>"
echo "<txt>$line</txt>"
