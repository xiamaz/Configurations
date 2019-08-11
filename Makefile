BASEDIR := $(shell pwd)
HOST = $(shell hostname)
export BASEDIR
export HOST


DOTS = Dotfiles
HOSTSDIR = Hosts

include stow.mk

.PHONY: all
all: bspwm apps base $(HOST).host

.PHONY: %.pkg
.ONESHELL:
%.pkg:
	./install_package.sh $*

# host specific installs
.PHONY: Thinkpad-W520.host
Thinkpad-W520.host:
	$(MAKE) -C Utils/nvidia_toggle
	sudo $(MAKE) -C Utils/nvidia_toggle install

.PHONY: %.host
%.host:
	echo "Default host configuration"

# DESKTOPS
.PHONY: bspwm
bspwm: bspwm-autonamer rofi.stow rofi.pkg flameshot.pkg redshift.pkg
	$(MAKE) -C Dotfiles/bspwm

# APPS
.PHONY: apps
apps: newsboat zimwiki nextcloud-client.aur keepassxc.pkg latex python R

.PHONY: newsboat
newsboat: newsboat.stow newsboat.pkg

.PHONY: zimwiki
zimwiki: zimwiki.stow zim.pkg

.PHONY: latex
latex: LaTeX.stow texlive-core.pkg texlive-science.pkg

.PHONY: python
python: conda.pkg

.PHONY: R
R: R.stow r.pkg gcc-fortran.pkg

.PHONY: bspwm-autonamer
.ONESHELL:
bspwm-autonamer:
ifeq ("$(wildcard $(HOME)/Git/bspwm-autonamer)", "")
	@git clone https://github.com/xiamaz/$@.git $$HOME/Git/$@
else
	@echo "Already cloned, just pulling."
endif
	cd $$HOME/Git/$@
	git pull
	make install
	systemctl --user enable --now bspwm-autoremover

# BASE PROGRAMS
.PHONY: base
base: tmux neovim ssh git python

.PHONY: ssh
.ONESHELL:
ssh: # git SSH.stow openssh.pkg mosh.pkg
ifeq ("$(wildcard $(HOME)/.ssh/id_rsa)", "")
	ssh-keygen -b 4096 -t rsa -N "" -f ~/.ssh/id_rsa
endif
	read -p "ssh server to get configuration from: " remote
	echo $$remote
	ssh $$remote "cd ~/Configurations;/usr/local/bin/git-crypt export-key /tmp/configurations.key"
	scp $$remote:/tmp/configurations.key /tmp/configurations.key
	git crypt unlock /tmp/configurations.key
	rm /tmp/configurations.key
	ssh $$remote "rm /tmp/configurations.key"

.PHONY: tmux
tmux: tmux.pkg
ifeq ("$(wildcard $(HOME)/.tmux/plugins/tpm)", "")
	@git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
else
	@echo "tpm already installed"
endif
	@echo "Issue C-a I to install packages defined in .tmux.conf."

.PHONY: neovim
neovim: neovim.pkg ctags

.PHONY: emacs
emacs: emacs.stow emacs.pkg

.PHONY: git
git: git-crypt.pkg
	@echo "Unlock with key: git-crypt unlock /path/to/key"

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
	$(MAKE) -C System keyboard

.PHONY: ctags
ctags: ctags.pkg ctags.stow

.PHONY: chinese
chinese: ibus.pkg ibus-rime.pkg wqy-microhei.pkg wqy-zenhei.pkg

.PHONY: basefonts
basefonts: otf-overpass.pkg noto-fonts.pkg cantarell-fonts.pkg
