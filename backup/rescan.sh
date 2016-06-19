#!/bin/bash

# when redocking running laptop the external esata bay is not recognized
# using this command 0 as wildcard, all scsi targets will be rescanned
sleep 1
echo 0 0 0 | tee /sys/class/scsi_host/host*/scan
echo "Rescanned successfully" > /backup/confirm.txt
