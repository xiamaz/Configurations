#!/usr/bin/fish

function merge -a lpath rpath prog
	if test -e "$lpath/$prog"; and test -e "$rpath/$prog"
		if not diff "$lpath/$prog" "$rpath/$prog"
			echo "Merging local and remote $prog"
			vimdiff $lpath $rpath
		else
			echo "Local and remote $prog are identical."
		end
	else if test -e "$lpath/$prog"
		echo "Copying local file $prog to repository"
		set folder_path (string split -m 1 -r "/" "$rpath/$prog")[1]
		mkdir -p $folder_path
		cp "$lpath/$prog" "$rpath/$prog"
	else if test -e "$rpath/$prog"
		echo "Remote exists, copying $prog to local computer"
		set folder_path (string split -m 1 -r "/" "$lpath/$prog")[1]
		mkdir -p $folder_path
		cp "$rpath/$prog" "$lpath/$prog"
	else
		echo "No files found"
	end
end


set git_path "$HOME/Git/Configurations"
set submod "bspwm"

set conf_path "$HOME/.config"

# sxhkd keybinding manager configuration
# read dependencies, such as scripts and put them in a sensible directory
set prog "sxhkd/sxhkdrc"
set -l ext "" ".$submod" "."(hostname)""
for e in $ext
	set lpath "$conf_path"
	set rpath "$git_path/$submod"
	merge $lpath $rpath $prog$e
end

# bspwm window manager configuration
set prog "bspwm/bspwmrc"
set lpath "$conf_path"
set rpath "$git_path/$submod"
merge $lpath $rpath $prog

# polybar configuration
set prog "polybar/config"
set lpath "$conf_path"
set rpath "$git_path/$submod"
merge $lpath $rpath $prog

# compton configuration
set prog "compton.conf"
merge "$conf_path" "$git_path/$submod"
