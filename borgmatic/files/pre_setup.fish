#!/usr/bin/fish

set borg_user "root"

set borg_dir "/etc/borgmatic"

if not test -f "/usr/bin/borgmatic"
	echo "Borgmatic not found. Installing it first."
	pacaur -yq --noconfirm borgmatic
end

sudo mkdir -p $borg_dir

if not sudo test -e "/root/.ssh/id.pub"
	sudo mkdir -p "/root/.ssh"
	ssh-keygen -q -b 4096 -t rsa -C "Borgbackup autogen" -f "/root/.ssh/id" -p ""
end

if not test -f /root.ssh/config; or not sudo grep "thinkstation-d20" /root/.ssh/config
	echo "Adding id configuration to ssh config"
	sudo sh -c "cat /tmp/files/ssh_config >> /root/.ssh/config"
end

sudo cp /root/.ssh/id.pub /tmp/id.pub
