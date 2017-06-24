#!/bin/sh
kpcmd="keepassxc"
dbLocation="/home/max/Sync/Files/shinier.kdbx"
keyLocation="/home/max/Documents/keepass.key"
/home/max/SystemSettings/KeepassAutostart/kr.py get keepass2 | $kpcmd -pw-stdin -keyfile:$keyLocation $dbLocation
