.PHONY: all
all: keyboard neovim

.PHONY: neovim
.ONESHELL:
neovim:
	@echo "Copying neovim config into root user."
	sudo sh -c 'install -m644 $@/.config/nvim/init.vim $$HOME/.config/nvim/'


.PHONY: keyboard
.ONESHELL:
keyboard: alt_ctl
	echo "Installing x11 keyboard conf"
	sudo install -m644 $@/etc/X11/xorg.conf.d/00-keyboard.conf /etc/X11/xorg.conf.d/
	echo "Installing virtual console kbd layout."
	sudo install -m644 $@/etc/vconsole.conf /etc/

.PHONY: alt_ctl
.ONESHELL:
alt_ctl:
	@if [ ! -d $$HOME/Git/alt_ctl ]; then
		git clone https://github.com/xiamaz/$@.git $$HOME/Git/$@
	else
		echo "Already cloned, just pulling."
	fi
	cd $$HOME/Git/$@
	git pull
	sudo make install
