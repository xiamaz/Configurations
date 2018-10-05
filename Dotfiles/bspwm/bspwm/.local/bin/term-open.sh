#!/bin/sh

# Create a new terminal using the given command
create_st() {
	st -t "$1" -e sh -c "$2"
}

# Raise the window with the given title or create a new terminal executing
# the given command.
# Args:
# 1 - window title
# 2 - command to execute
raise_or_create() {
	if wmctrl -l | grep "$1" > /dev/null; then
		wmctrl -a "$1" -F
	else
		create_st "$1" "$2"
	fi
}

has_vpn() {
	if ip tuntap show | grep tun0 > /dev/null; then
		echo "60001"
	else
		echo "60002:61000"
	fi
}

case $1 in
	main)
		raise_or_create "st-main-local-tmux" "tmux a"
		;;
	home)
		raise_or_create "st-main-home-tmux" "mosh home --port=$(has_vpn) -- tmux a"
		;;
	ssh)
		raise_or_create "st-ssh-$2" "ssh $2"
esac
