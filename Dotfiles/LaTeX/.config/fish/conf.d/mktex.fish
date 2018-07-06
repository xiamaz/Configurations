# Quickly put a small latex template into the current directory

set TEMPLATE_DIR ~/Templates

function _show_usage
	echo "Usage: <template name> <destination>"
end


function _list_templates
	find $TEMPLATE_DIR -iname "*.tex"
end

function _get_template
	if [ (count $argv) -lt 1 ]
		_show_usage
		echo (count $argv)
		return
	end

	set tname $argv[1]
	set template (_list_templates | grep -m 1 $tname)
	if [ -z $template ]
		echo "Could not find template"
	end

	set dest ([ (count $argv) -gt 1 ]; and echo $argv[2]; or echo "main")

	if [ -z (echo $dest | grep -Po '\.\w+$') ]
		set dest $dest".tex"
	end

	cp $template $dest
end

function mktex
	switch $argv[1]
	case "ls"
		_list_templates
	case "new"
		if [ (count $argv) -gt 1 ]
			_get_template $argv[2..-1]
		else
			_show_usage
		end
	case "*"
		_show_usage
	end
end

complete -c mktex -a "ls new"
