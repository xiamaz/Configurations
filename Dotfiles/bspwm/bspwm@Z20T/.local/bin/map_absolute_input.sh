#!/bin/sh
# Map all absolute input devices to the primary internal screen.
PRIMARY_SCREEN="eDP1"

# 1 - device name
map_to_screen() {
	xinput --map-to-output "$1" $PRIMARY_SCREEN
}

map_to_screen 'Atmel'
map_to_screen 'Wacom ISDv4 12C Pen stylus'
map_to_screen 'Wacom ISDv4 12C Pen eraser'
