#!/bin/bash

IFS=";"

function dev_rotate()
{
  TRANSFORM='Coordinate Transformation Matrix'

  case "$2" in
    normal)
      [ ! -z "$1" ] && xinput set-prop "$1" "$TRANSFORM" 1 0 0 0 1 0 0 0 1
      ;;
    inverted)
      [ ! -z "$1" ] && xinput set-prop "$1" "$TRANSFORM" -1 0 1 0 -1 1 0 0 1
      ;;
    left)
      [ ! -z "$1" ] && xinput set-prop "$1" "$TRANSFORM" 0 -1 1 1 0 0 0 0 1
      ;;
    right)
      [ ! -z "$1" ] && xinput set-prop "$1" "$TRANSFORM" 0 1 0 -1 0 1 0 0 1
      ;;
  esac
}

function scr_rotate()
{
	case "$1" in
		normal)
			xrandr -o 1
			for d in $2; do
				echo $d
				dev_rotate "$d" "left"
			done
			;;
		left)
			xrandr -o 0
			for d in $2; do
				dev_rotate "$d" "normal"
			done
			;;
		*)
			xrandr -o 0
			for d in $2; do
				dev_rotate "$d" "normal"
			done
			;;
	esac
}

# get current rotation
rot_stat=$(xrandr -q | grep -o "[0-9].[a-z]\{4,8\}\s(" | awk '{print $2}')
if [ -z "$rot_stat" ]; then
	rot_stat="normal"
fi
echo $rot_stat

# our list of periphericals
devices="Wacom ISDv4 12C Pen stylus;Wacom ISDv4 12C Pen eraser;Atmel"

scr_rotate "$rot_stat" "$devices"
