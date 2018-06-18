#!/usr/bin/fish

function create_ssh_entry
	set host $argv[1]
	set remote $argv[2]
	# get generated public key
	set ssh_key (ssh -t $remote@$host "cat /tmp/id.pub")
	set prefix_cmd "command=\"borg serve --restrict-to-path /backup/repos/$host\",restrict"

	set auth_entry "$prefix_cmd $ssh_key"

	if sudo grep $host /backup/.ssh/authorized_keys
		echo "Entry already in authorized keys. Replacing with new one."
	else
		sudo sh -c "echo $auth_entry >> /backup/.ssh/authorized_keys"
	end
end

if [ (count $argv) -gt 2 -o (count $argv) -eq 0 ]
	echo "Usage: hostname [user]"
	exit
end

if [ (count $argv) -eq 2 ]
	set target_user "$argv[2]"
else
	set target_user "max"
end

set target_host "$argv[1]"

echo $target_host $target_user


scp -rq files $target_user@$target_host:/tmp

# execute Pre-setup
ssh -t $target_user@$target_host "/tmp/files/pre_setup.fish"

create_ssh_entry $target_host $target_user

ssh -t $target_user@$target_host "/tmp/files/setup.fish"
