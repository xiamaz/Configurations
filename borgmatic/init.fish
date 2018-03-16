#!/usr/bin/fish
set remote "max"

set host "dell-t5610"

scp -rq files $remote@$host:/tmp
# scp -q setup.fish $remote@$host:/tmp
# scp -q config.yaml $remote@$host:/tmp
# scp -q ssh_config $remote@$host:/tmp

ssh -t $remote@$host "/tmp/files/pre_setup.fish"

set ssh_key (ssh -t $remote@$host "cat /tmp/id.pub")

set prefix_cmd "command='borg serve --restrict-to-path /backup/repos/$host'"

set auth_entry "$prefix_cmd $ssh_key"

if sudo grep $host /backup/.ssh/authorized_keys
	echo "Entry already in authorized keys. Replacing with new one."
else
	sudo sh -c "echo $auth_entry >> /backup/.ssh/authorized_keys"
end


ssh -t $remote@$host "/tmp/files/setup.fish"
