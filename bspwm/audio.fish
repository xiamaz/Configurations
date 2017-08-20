#!/bin/fish

pamixer -$argv[1] $argv[2]

set audio_level (pamixer --get-volume)
set mute_status (pamixer --get-mute)

if [ $mute_status = "true" -o $audio_level = 0 ]
	notify-send.sh -R /tmp/notifyid-audio -i audio-volume-muted-symbolic -h int:value:$audio_level "Audio Sink Volume Muted"
else if [ $audio_level -ge 67 ]
	notify-send.sh -R /tmp/notifyid-audio -i audio-volume-high-symbolic -h int:value:$audio_level "Audio Sink Volume"
else if [ $audio_level -ge 34 ]
	notify-send.sh -R /tmp/notifyid-audio -i audio-volume-medium-symbolic -h int:value:$audio_level "Audio Sink Volume"
else
	notify-send.sh -R /tmp/notifyid-audio -i audio-volume-low-symbolic -h int:value:$audio_level "Audio Sink Volume"
end
