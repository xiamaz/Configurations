borgbackup - Initial setup
==========================

Short installation manual for installation of borgbackup in a setup with a
central backupserver and multiple clients which will connect to the server via
SSH.


SSH connection between client and server
----------------------------------------

The backupuser on the client should have read access to all folders to be backed
up. Depending on whether system files should also be backed up, both the normal
system user or root could be used for this role.


Installation of borgmatic
-------------------------

Borgmatic is a wrapper around borg enabling configuration options for backups
including backups to remote servers. A timer systemd service can then be used to
trigger backups to the backup server in regular intervals.

You can copy a reference config.yaml to the new computer. Inside of the copied
config the hostname has to be changed and ownership and permissions need to be
adjusted.

.. code:: sh
   sed -i "s/HOSTNAME/$(hostname)/g" /etc/borgmatic/config.yaml
   chown root:root /etc/borgmatic/config.yaml
   chmod 600 /etc/borgmatic/config.yaml


Initialization of borg repo on the server
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Backups from each computer will be saved to a different repo, thus we will need
to create a new repo for a new computer.

.. code:: sh
   sudo borg init borgbackup@thinkstation-d20:repos/<HOSTNAME> --encryption=authenticated-blake2


Enable regular backups
~~~~~~~~~~~~~~~~~~~~~~

A systemd timer is part of borgmatic to schedule regular updates. Simply enable
it for automatic backups.

.. code:: sh
   systemctl enable borgmatic.timer
