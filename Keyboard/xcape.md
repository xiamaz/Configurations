# Making the CapsLock Key useful

Xcape is a handy tool for rebinding keys, especially for different uses as a modifier or pressed on its own.

For rebinding the CapsLock key as a CTRL-Modifier with Escape functionality when pressed on its own, quite many guides exist on the internet.

What I am going for:
xorg.conf Keyboard-Configuration
External keyboards will lose their modifications when replugged, if xkbmap or any other userspace tool is used for configuration.
In order to keep or modifications even in the case of external keyboards, we will need our modifications on the system level. Udev might be one possibility, but xorg.conf is definitely easier.

xcape for Escape functionality
This tool acts as a daemon for our keystrokes, therefore we will need to run it in userspace.
Since it depends on X11, we should guarantee it to be started after a X11-Session. We can do this by either adding a line to xprofile (this bash file is called on login, dependant on the used DM), DE-dependent session startup manager or a user systemd-file (yes, systemd can be used for everything).

Weird xcape behavior when rebinding Caps to Ctrl with nocaps
Rebinding CapsLock to Ctrl with nocaps and Activation of xcape will result in our CapsLock-Key stop working as an Escape key, after we trigger Escape from the normal left Ctrl-Key.
We can avoid this behavior by using the caps:ctrl_modifier option and using xcape on the Caps_Lock keysym, instead of all Ctrl-Modifiers. This should solve the problem.
