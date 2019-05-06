#!/bin/sh
if [ -z $1 ]; then exit; fi
# Focus the nth desktop on the given monitor
monitor_id=$(chunkc tiling::query --monitor id)
selected_desktop_id=$(chunkc tiling::query --desktops-for-monitor $monitor_id | cut -d " " -f $1)
case $selected_desktop_id in
	*[[:alnum:]]*)
		chunkc tiling::desktop --focus index $selected_desktop_id
		;;
esac
