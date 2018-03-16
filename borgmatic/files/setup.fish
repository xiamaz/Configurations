#!/usr/bin/fish
echo "Replacing the hostname with local hostname"
sed -i "s/HOSTNAME/"(hostname)"/g" /tmp/files/config.yaml
sudo mv /tmp/files/config.yaml /etc/borgmatic/config.yaml
sudo chown root:root /etc/borgmatic/config.yaml
sudo chmod 600 /etc/borgmatic/config.yaml
sudo borg init borgbackup@thinkstation-d20:repos/(hostname) --encryption=authenticated-blake2
echo "Enabling the systemd service"
sudo systemctl enable --now borgmatic.timer
