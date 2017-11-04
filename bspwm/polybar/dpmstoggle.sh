#!/bin/dash
if [ "$(xset dpms q | grep 'DPMS is Enabled')" ]; then
	if [ "$1" ]; then
		xset -dpms
		echo ""
	else
		echo ""
	fi
else
	if [ "$1" ]; then
		xset +dpms
		echo ""
	else
		echo ""
	fi
fi
