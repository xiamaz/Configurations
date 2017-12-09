#!/bin/bash

configDirectory=".config"
localDirectory=".local/share"

# create symlinks
if [ ! -e "$HOME/.config/nvim" ]; then
	echo "Symlinking neovim directory"
	ln -s "$HOME/Git/Configurations/Vim/vim" "$HOME/$configDirectory/"
fi

if [ ! -e "$HOME/.vimrc.local" ]; then
	echo "Creating local vimrc"
	touch "$HOME/.vimrc.local"
fi

if [ ! -e "$HOME/$localDirectory/vim" ]; then
	echo "Create local swap undo and backup directories"
	mkdir -p "$HOME/$localDirectory/vim/swap"
	mkdir -p "$HOME/$localDirectory/vim/undo"
	mkdir -p "$HOME/$localDirectory/vim/backup"
fi
