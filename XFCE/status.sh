#!/usr/bin/zsh
# requires fontawesome for icons
# get first temperature from coretemp
zmodload zsh/mathfunc
LC_NUMERIC="en_US.UTF-8"
#temp=$(sensors -u coretemp-isa-0000 | grep -i -m 1 input | grep -o "[^ ]*$")
temp=$(($(< /sys/class/thermal/thermal_zone2/temp)/1000))

# get ram numbers
ram=($(free -h))
# total=$(awk '{print $2}' <<< $ram)
# used=$(awk '{print $3}' <<< $ram)
avail=${ram[13]}

# get load
load=($(< /proc/loadavg))
m1=${load[1]}
m5=${load[2]}
m15=${load[3]}

# calculate cpu usage from proc stat
stat=($(< /proc/stat))
pstat=($(< /tmp/status-pstat))
# idle = idle / iowait
idle=$((stat[5]+stat[6]))
# nonidle = user + nice + system + irq + softirq + steal
nidle=$((stat[2]+stat[3]+stat[4]+stat[7]+stat[8]+stat[9]))
# total = idle + nonidle
tot=$((idle+nidle))
# save to status-pstat
> /tmp/status-pstat <<< "$idle $nidle $tot"
# diff
didle=$((idle-pstat[1]))
dtot=$((tot-pstat[3]))
# cpu = (totald - idled) / totald
cpu=$((float(dtot-didle)/dtot*100))

# combine into status string
printf "<txt><span font_weight='bold'><span fgcolor='#D0B03C' font='FontAwesome' font_weight='normal'> </span> <span fgcolor='#FFE377'>%4.1f%% </span><span fgcolor='#72B3CC' font='FontAwesome' font_weight='normal'>   </span> <span fgcolor='#9CD9F0'>${avail} free</span> <span fgcolor='#C75646' font='FontAwesome' font_weight='normal'>  </span> <span fgcolor='#E09690'>${temp%.*}°C</span></span></txt><tool> $m1 $m5 $m15</tool>" "$cpu"

