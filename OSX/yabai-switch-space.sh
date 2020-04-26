#!/bin/sh
TARGET_INDEX=$1

SPACE_QUERY=$(yabai -m query --spaces)
CUR_SPACE=$(echo $SPACE_QUERY | jq '.[] | select(.focused == 1) | .index')
CUR_DISPLAY=$(echo $SPACE_QUERY | jq '.[] | select(.focused == 1) | .display')

TARGET_SPACE_INDEX=$(echo $SPACE_QUERY | jq ".[] | select(.display == ${CUR_DISPLAY}) | .index" | sed -n "${TARGET_INDEX}p")

if [ -z "$TARGET_SPACE_INDEX" ]; then
	echo "EE: Index does not exist on current monitor ${CUR_DISPLAY}."
	exit 1
elif [ $TARGET_SPACE_INDEX -ne $CUR_SPACE ]; then
	echo "Switching to space index ${TARGET_SPACE_INDEX}"
	yabai -m space --focus $TARGET_SPACE_INDEX
else
	echo "Switching to most recent space."
	yabai -m space --focus recent
fi
