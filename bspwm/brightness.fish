#!/bin/fish

xbacklight -$argv[1] $argv[2]

set brightnessLevel (cat /sys/class/backlight/intel_backlight/actual_brightness)
set maxBrightness (cat /sys/class/backlight/intel_backlight/max_brightness)

set brightness (math "100 * $brightnessLevel / $maxBrightness")

notify-send.sh -R /tmp/notifyid-brightness -i display-brightness-symbolic -h int:value:$brightness "Brightness"
