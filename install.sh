#!/bin/bash

## Check Prerequisites
REQUIRED_CMDS="jq git-crypt"

echo "Searching for required software:"
FAILED=false
for cmd in $REQUIRED_CMDS; do
	if ! command -v $cmd > /dev/null; then
		echo "$cmd: missing"
		FAILED=true
	else
		echo "$cmd: found"
	fi
done

if [ $FAILED = true ]; then
	echo "Missing software. Exiting..."
	exit
fi
