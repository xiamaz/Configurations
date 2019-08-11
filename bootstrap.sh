#!/bin/sh
# Prerequisites: dotfiles.key at /tmp
# Bootstrap an initial blank setup

# Prepare package management
case $(uname -s) in
Darwin)
	echo "Preconfiguring Mac OS"
	if ! command -v brew; then
		echo "Installing homebrew"
		/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
		if [ ! -f "/etc/paths.d/brew" ]; then
			echo "/usr/local/sbin" | tee /etc/paths.d/brew > /dev/null
		fi
	fi

	if ! command -v jq; then
		brew install jq
	fi

	if [ ! -e /usr/local/bin/zsh ]; then
		brew install zsh
		if ! grep '/usr/local/bin/zsh' /etc/shells > /dev/null; then
			echo "/usr/local/bin/zsh" | sudo tee /etc/shells > /dev/null
		fi
	fi
	chsh -s /usr/local/bin/zsh

	if ! command -v gmake; then
		brew install make
	fi
	alias make="gmake"

	if [ ! -f /usr/local/bin/git-crypt ]; then
		brew install git-crypt
	fi
	;;
Linux)
	if [ -n `grep archlinux /etc/os-release` ]; then
		if ! command -v yay; then
			cd /tmp
			wget https://aur.archlinux.org/cgit/aur.git/snapshot/yay.tar.gz
			tar -xf /tmp/yay.tar.gz
			cd /tmp/yay
			makepkg -s
			sudo pacman -U --noconfirm yay*.pkg.*
		fi
		if ! command -v jq; then
			sudo pacman -S jq
		fi
		if ! command -v git-crypt; then
			sudo pacman -S git-crypt
		fi
	else
		echo "Distro not supported yet"
	fi
	;;
esac

if [ ! -d $HOME/.zgen ]; then
	echo "Installing zgen at $(HOME)/.zgen"
	git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"
fi

# Clone dotfiles repo
echo "Adding dotfiles"
if [ ! -f /tmp/dotfiles.key ]; then
	echo "No key found to unlock dotfiles aborting..."
	exit
fi

cgit() {
	git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME $@
}


if [ ! -d $HOME/.dotfiles.git ]; then
	git clone --bare https://github.com/xiamaz/.dotfiles.git $HOME/.dotfiles.git
	mkdir -p .config-backup
	cgit checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
	cgit checkout
	cgit crypt unlock /tmp/dotfiles.key
fi

# Configure SSH keys
if [ ! -f $HOME/.ssh/id_rsa ]; then
	ssh-keygen -b 4096 -t rsa -N "" -f ~/.ssh/id_rsa
	echo "SSH Public Key"
	cat ~/.ssh/id_rsa.pub
fi

echo "TODO"
echo "Install eurkey-mac"
