= Dead Greek Letters using xmodmap

Adding greek input in X is really easy, once you know how it can be done. X supports a dead-greek mode natively.

Adding a dead_greek symbol to a key is enough to enable greek letter input.

Using xmodmap, we can for example use altgr-g as dead_greek modifier to enter greek symbols.

For example this command can be used for temporary testing.:
xmodmap -e "keycode  42 = g G g G dead_greek ENG eng"
