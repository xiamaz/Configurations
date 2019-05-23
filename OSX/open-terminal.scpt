#!/usr/bin/osascript

on run argv
	set termwin to "tmux"
	set termprof to "tmux"
	tell application "iTerm"
		if (it is not running) or ((windows where name contains termwin) is {}) then
			create window with profile termprof
		else
			activate
			tell first window whose name contains termwin
				select
			end
		end if
	end tell
end run
