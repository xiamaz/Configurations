#!/usr/bin/fish
echo (pwd)
# install fisher
curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher

fisher edc/bass
