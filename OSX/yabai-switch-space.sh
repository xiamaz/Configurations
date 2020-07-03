#!/bin/dash
TARGET_INDEX=$1

SPACE_QUERY=$(yabai -m query --spaces | sed '$s/},/}]/')
CUR_SPACE=$(jq '.[] | select(.focused == 1).index' <<EOF
$SPACE_QUERY
EOF
)
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
elif [ $TARGET_SPACE_INDEX -ne $CUR_SPACE ]; then
	echo "Switching to space index ${TARGET_SPACE_INDEX}"
	yabai -m space --focus $TARGET_SPACE_INDEX
else
	echo "Switching to most recent space."
	yabai -m space --focus recent
fi
