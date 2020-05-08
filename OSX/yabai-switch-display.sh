#!/bin/dash

case "$1" in
	focus-next)
		yabai -m display --focus next || yabai -m display --focus first
		;;
	focus-prev)
		yabai -m display --focus prev || yabai -m display --focus last
		;;
	send-next)
		DEST=next
		if ! yabai -m window --display $DEST; then
			DEST=first
			yabai -m window --display $DEST
		fi
		yabai -m display --focus $DEST
		;;
	send-prev)
		DEST=prev
		if ! yabai -m window --display $DEST; then
			DEST=last
			yabai -m window --display $DEST
		fi
		yabai -m display --focus $DEST
		;;
	*)
		echo "Args: focus-next|focus-prev|send-next|send-prev"
		exit 1
esac
