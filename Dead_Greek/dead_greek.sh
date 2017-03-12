#!/bin/bash

echo "Checking if Xmodmap exists"
if [ -s $HOME/.Xmodmap ]; then
	echo "Xmodmap already exists, will directly update the letter."
else
	echo "Xmodmap does not exist, will generate new one directly."
	xmodmap -pke > $HOME/.Xmodmap
fi

echo "Modifying Xmodmap with dead_greek modifier on AltGr-G."
sed -i -e "s/g G g G [a-zA-Z0-9]\+ /g G g G dead_greek /g" $HOME/.Xmodmap
