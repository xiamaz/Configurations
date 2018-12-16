#!/usr/bin/osascript

on run argv
	set termcmd to "open ~/Configurations/OSX/tmux.terminal"
	set termwin to "tmux main"
	repeat with cmdname in argv
		if (cmdname as string) is equal to "home" then
			set termcmd to "open ~/Configurations/OSX/mosh-home.terminal"
			set termwin to "mosh home"
		end if
	end repeat
	tell application "Terminal"
		if (it is not running) or ((windows where name contains termwin) is {}) then
			do shell script termcmd
		end if
		set filtered to windows where name contains termwin
		if filtered is not {} then
			set index of item 1 of filtered to 1
		end if
		do shell script "open -a Terminal"
	end tell
end run
