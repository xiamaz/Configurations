#!/bin/bash
# Prerequisites: dotfiles.key at /tmp
# Bootstrap an initial blank setup

PREREQUISITES="git jq zsh tmux"

MISSING_PREQ=0
echo "init: searching for required tools"
for preq in $PREREQUISITES; do
	if ! command -v $preq > /dev/null; then
		echo "$preq needs to be installed and in \$PATH"
		MISSING_PREQ=1
	else
		echo "$preq found."
	fi
done
echo ""

if [ $MISSING_PREQ == 1 ]; then
	"missing prerequisites"
	exit
fi

# Install zinit
echo "zsh: Installation"
ZINIT_HOME="$HOME/.zinit/bin"
if [ ! -d $ZINIT_HOME ]; then
	echo "Installing zinit at $ZINIT_HOME"
	git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
echo "Zinit is installed."

if [ ${SHELL##*/} = "zsh" ]; then
	echo "zsh is current shell doing nothing"
else
	echo "setting default shell to zsh"
	chsh -s $(which zsh)
fi

echo ""

# Install tpm
echo "tmux: Installation"
TPMDIR="$HOME/.tmux/plugins/tpm"
if [ ! -d $TPMDIR ]; then
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
echo "TPM is installed. Do not forget to prefix + I inside tmux."
echo ""

# Clone dotfiles repo
echo "dotfiles: Installation"
cgit() {
	git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME $@
}


DOTDIR="$HOME/.dotfiles.git"
if [ ! -d $DOTDIR ]; then
	git clone --bare https://github.com/xiamaz/.dotfiles.git "$1"
fi

echo "Checking out dotfiles, might lead to conflicts. Resolve manually."
cgit checkout
