#!/usr/bin/fish

function merge -a lpath rpath prog
	if test -e $lpath; and test -e $rpath
		echo "Merging local and remote $prog"
		vimdiff $lpath $rpath
	else if test -e $lpath
		echo "Copying local file $prog to repository"
		cp $lpath $rpath
	else if test -e $rpath
		echo "Remote exists, copying $prog to local computer"
		cp $rpath $lpath
	else
		echo "No files found"
	end
end


set git_path "$HOME/Git/Configurations"
set submod "bspwm"

set conf_path "$HOME/.config"

set prog "sxhkd/sxhkdrc"
set -l ext "" ".$submod" "."(hostname)""
for e in $ext
	set lpath "$conf_path/$prog$e"
	set rpath "$git_path/$submod/$prog$e"
	merge $lpath $rpath $prog$e
end

set prog "bspwm/bspwmrc"
set lpath "$conf_path/$prog"
set rpath "$git_path/$submod/$prog"
merge $lpath $rpath $prog

set prog "polybar/config"
set lpath "$conf_path/$prog"
set rpath "$git_path/$submod/$prog"
merge $lpath $rpath $prog
