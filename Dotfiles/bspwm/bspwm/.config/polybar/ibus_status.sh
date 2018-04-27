#!/usr/bin/sh
if [ "$1" == "toggle" ]; then
	i=$(./ibus-switch)
else
	i=$(ibus engine)
fi
if [ "$i" == "xkb:de::ger" ]; then
	echo "🄳"
else
	echo "🈭"
fi
