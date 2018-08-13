BASEDIR := $(shell pwd)
HOST = $(shell hostname)
export BASEDIR
export HOST


DOTS = Dotfiles
HOSTSDIR = Hosts

include packaging.mk stow.mk

.PHONY: all
all: bspwm apps base

# host specific installs

.PHONY: Thinkpad-W520
Thinkpad-W520:
	$(MAKE) -C Utils/nvidia_toggle
	sudo $(MAKE) -C Utils/nvidia_toggle install

# DESKTOPS
.PHONY: bspwm
bspwm:
	$(MAKE) -C Dotfiles/bspwm

# APPS
.PHONY: apps
apps: newsboat zimwiki nextcloud keepassxc redshift latex python

.PHONY: newsboat
newsboat: newsboat.stow newsboat.pkg

.PHONY: zimwiki
zimwiki: zimwiki.stow zim.pkg

.PHONY: nextcloud
nextcloud: nextcloud-client.aur

.PHONY: keepassxc
keepassxc: keepassxc.pkg

.PHONY: redshift
redshift: redshift.pkg

.PHONY: latex
latex: LaTeX.stow texlive-core.pkg texlive-science.pkg

.PHONY: python
python: python.stow python-pyflakes.pkg python-pylint.pkg

# BASE PROGRAMS
.PHONY: base
base: tmux neovim fish st basefonts keyboard chinese

.PHONY: tmux
tmux: tmux.stow tmux.pkg
	@echo "Issue C-a I to install packages defined in .tmux.conf."

.PHONY: neovim
neovim: neovim.stow neovim.pkg

.PHONY: git
git: git.stow

.PHONY: fish
fish: fish.stow fish.pkg
	@curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
	@fish -c "fisher"

.PHONY: st
.ONESHELL:
st: ncurses terminess-powerline-font-git.aur
	@if [ hostname = "Z20T" ]; then
		FONTSIZE=12
	else
		FONTSIZE=11
	fi
	if [ -z "`pacman -Qs | grep "/$@ 0.8.1"`" ]; then
		cd packages/$@
		FONTSIZE=$$FONTSIZE makepkg -sf
		sudo pacman -U --noconfirm $@*.pkg.tar*
	else
		echo "$@ already installed."
	fi

.PHONY: ncurses
.ONESHELL:
ncurses:
	@if [ "`pacman -Qs | grep "/$@ 6.1-3"`" ]; then
		cd packages/$@
		makepkg -s
		sudo pacman -U --noconfirm $@*.pkg.tar*
	else
		echo "$@ already current."
	fi

.PHONY: keyboard
keyboard: keyboard.stow xcape.pkg
	@systemctl --user enable --now xcape.service

.PHONY: ctags
ctags: universal-ctags-git.aur ctags.stow


.PHONY: chinese
chinese: ibus.pkg ibus-rime.pkg wqy-microhei.pkg wqy-zenhei.pkg

.PHONY: basefonts
basefonts: otf-overpass.pkg noto-fonts.pkg cantarell-fonts.pkg
