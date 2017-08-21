#!/usr/bin/python3
from pydbus import SessionBus,SystemBus

BATTERY_LEVELS = ""

CHARGING_FULL = ''
CHARGING = ''

sys = SystemBus()
power = sys.get('.UPower')

all_capacity = 0
all_rate = 0

charge_time = 0
bat_no = 0

percentages = []

all_full = True

for a in power.EnumerateDevices():
    dev = sys.get('.UPower', a)
    # check if battery
    if dev.Type == 2:
        # change all full, if not all fully charged
        if dev.State != 4:
            all_full = False
        # check if battery is charging
        if dev.State == 1:
            charge_time += (dev.EnergyFull - dev.Energy) / dev.EnergyRate
        # add for discharge calculation
        if dev.IsPresent:
            bat_no += 1
            all_capacity += dev.Energy
            all_rate += dev.EnergyRate
            percentages.append(dev.Percentage)
    # check if line power
    elif dev.Type == 1:
        charging = dev.Online


# show icon for average percentage
if not charging:
    bat_icon = BATTERY_LEVELS[round(sum(percentages)/len(percentages)/100*4)]
elif all_full:
    bat_icon = CHARGING_FULL
else:
    bat_icon = CHARGING

if bat_no > 1:
    percentage_text = "/".join([ str(round(p)) for p in percentages]) + "%"
elif bat_no == 1:
    percentage_text = str(round(percentages[0])) + '%'
else:
    percentage_text = '-%'

if not charging:
    time_empty = all_capacity / all_rate
    time_text = ' {:02.0f}:{:02.0f}'.format(time_empty, time_empty % 1 * 60)
elif not all_full:
    time_text = ' {:02.0f}:{:02.0f}'.format(charge_time, charge_time % 1 * 60)
else:
    time_text = ''

output = "{} {}%{{F#ca}}{}%{{F-}}".format(bat_icon, percentage_text, time_text)

print(output)
