#!/bin/sh
/home/max/SystemSettings/KeepassAutostart/kr.py get keepass2 | keepass -pw-stdin -keyfile:/home/max/Documents/keepass.key /home/max/Dropbox/shinier.kdbx
