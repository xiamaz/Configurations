#!/bin/dash
TARGET_INDEX=$1

SPACE_QUERY=$(yabai -m query --spaces)
CUR_DISPLAY=$(jq '.[] | select(.focused == 1).display' <<EOF
$SPACE_QUERY
EOF
)

TARGET_SPACE_INDEX=$(jq "[.[] | select(.display == ${CUR_DISPLAY})][$TARGET_INDEX].index" <<EOF
$SPACE_QUERY
EOF
)

if [ -z "$TARGET_SPACE_INDEX" ]; then
	echo "EE: Index does not exist on current monitor ${CUR_DISPLAY}."
	exit 1
else
	echo "Moving window to space index ${TARGET_SPACE_INDEX}"
	yabai -m window --space $TARGET_SPACE_INDEX
fi
