#!/bin/bash
xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/presentation-mode -T
xfce4-panel --plugin-event=genmon-7:refresh:bool:true
