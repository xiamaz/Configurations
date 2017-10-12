#!/bin/sh

B='#00000055'  # blank
C='#00000055'  # clear ish
D='#f0f0f0cc'  # default
T='#f0f0f0ee'  # text
W='#00000099'  # wrong
V='#00000099'  # verifying

i3lock              \
--insidevercolor=$C   \
--ringvercolor=$V     \
\
--insidewrongcolor=$C \
--ringwrongcolor=$W   \
\
--insidecolor=$B      \
--ringcolor=$D        \
--linecolor=$B        \
--separatorcolor=$D   \
\
--textcolor=$T        \
--timecolor=$T        \
--datecolor=$T        \
--keyhlcolor=$W       \
--bshlcolor=$W        \
\
--screen 0            \
--blur 5              \
--clock               \
--indicator           \
--timestr="%H:%M"  \
--datestr="%Y – %m – %d" \
--timesize=48 		\
--textsize=36         \
--modsize=24          \
--datesize=24 		\
--datepos="tx:ty+48" \
--radius=140 		\
--ring-width=5 		\
