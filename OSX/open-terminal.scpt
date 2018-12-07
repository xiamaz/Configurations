#!/usr/bin/osascript

on run argv
	set termcmd to "tmux new-session -A -s main"
	set termwin to "tmux new-session -A -s main"
	repeat with cmdname in argv
		if (cmdname as string) is equal to "home" then
			set termcmd to "mosh home.arsbrevis.de -- sh -c 'tmux new-session -A -s main'"
			set termwin to "mosh home.arsbrevis.de"
		end if
	end repeat
	tell application "Terminal"
		if (it is not running) or ((windows where name contains termwin) is {}) then
			do script termcmd
		end if
		activate
		windows where name contains termwin
		if result is not {} then set index of item 1 of result to 1
	end tell
end run
