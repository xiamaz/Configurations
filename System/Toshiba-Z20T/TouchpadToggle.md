=Enabling FN-F9 for touchpad toggle
Keymaps and multimedia keys have always been a difficult topic for most linux systems.
The linux key processing chain with near infinite layers of complexity can fortunately be broken down into the two symbol categories of scancodes and keycodes.
Scancodes are generated by our hardware and keycodes are the interpretation of these by our operating system.
Scancodes can be mostly arbitrary, if you cannot get scancodes, you are out of luck.
Keycodes are limited to an area from 0 to 255. These can be read from /usr/include/linux/input-event-codes.h

=Get scancode
Cycle through evtest /dev/input/event\* until you find "Toshiba input device". This device controls the fn-key-combos.
Now press the FN-F9 Combination. Touchpad-Toggle + MSC-Scan should be visible. The value after MSC-Scan is our scancode.

=Write HWDB rule
Use the example provided. You can use any name from input-event-codes.h, but raw decimals unfortunately do not work.
