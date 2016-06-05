#!/bin/sh
dbus-monitor --system "type='signal',sender='org.freedesktop.login1',path='/org/freedesktop/login1/seat/seat0',interface='org.freedesktop.DBus.Properties',member='PropertiesChanged'" | grep --line-buffered "ActiveSession" | while read line; do xset s activate && xset s reset; done
