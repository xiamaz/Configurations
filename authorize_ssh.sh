#!/bin/sh
host=$1
ssh_key=$(cat ~/.ssh/id_rsa.pub)
echo $ssh_key
ssh $host "touch ~/.ssh/authorized_keys;if ! grep \"$ssh_key\" ~/.ssh/authorized_keys > /dev/null; then echo $ssh_key >> ~/.ssh/authorized_keys; fi"
