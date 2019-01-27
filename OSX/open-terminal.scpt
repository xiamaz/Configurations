#!/usr/bin/osascript

on run argv
	set termcmd to "open ~/Configurations/OSX/tmux.terminal"
	set termwin to "/usr/local/bin/tmux new-session -A -s main"
	repeat with cmdname in argv
		if (cmdname as string) is equal to "home" then
			set termcmd to "open ~/Configurations/OSX/mosh-home.terminal"
			set termwin to "mosh home"
		end if
	end repeat
	tell application "Terminal"
		if (it is not running) or ((windows where name contains termwin) is {}) then
			do shell script termcmd
		else
			set selwin to first window whose name contains termwin
			set frontmost of selwin to true
			activate
		end if
	end tell
end run
