DOTS = Dotfiles
STOW = stow -t $(HOME) -d $(DOTS)

HOST = $(shell hostname)

.PHONY: tiling
tiling: bspwm base apps

.PHONY: base
base: tmux neovim fish st

.PHONY: apps
apps: newsboat

# BASE PROGRAMS

.PHONY: tmux
tmux: tmux.stow tmux.pkg
	@echo "Issue C-a I to install packages defined in .tmux.conf."

.PHONY: neovim
neovim: neovim.stow neovim.pkg

.PHONY: fish
fish: fish.stow fish.pkg
	@curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
	@fish -c "fisher edc/bass"

# DESKTOPS

.PHONY: bspwm
bspwm: bspwm.stow bspwm.hoststow bspwm.pkg sxhkd.pkg polybar nitrogen.pkg autorandr.aur

# APPS

.PHONY: newsboat
newsboat: newsboat.stow newsboat.pkg

.PHONY: polybar
polybar: polybar.pkg fonts

.PHONY: st
.ONESHELL:
st: ncurses
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


.PHONY: fonts
fonts: otf-font-awesome.pkg wqy-microhei.pkg wqy-zenhei.pkg otf-overpass.pkg \
	noto-fonts.pkg ttf-material-design-icons.aur termsyn-font.aur bdf-unifont.pkg \
	terminess-powerline-font-git.aur

# stow utilities
.PHONY: %.stow
%.stow: stow.pkg
	$(STOW) $(basename $@ .stow)

.PHONY: %.hoststow
.ONESHELL:
%.hoststow: stow.pkg
	@if [ -d "$(DOTS)/$$(basename $@ .hoststow)-$(HOST)" ]; then
		$(STOW) $$(basename $@ .hoststow)-$(HOST)
	else
		$(STOW) $$(basename $@ .hoststow)-default
		echo "Using default config. Consider creating host-specific config."
	fi

# package management
.PHONY: %.pkg
.ONESHELL:
%.pkg:
	@if [ -z "`pacman -Qs | grep $(basename $@ .pkg)`" ]; then
		sudo pacman -S --noconfirm $(basename $@ .pkg)
	else
		echo "$(basename $@ .pkg)already installed."
	fi

.PHONY: %.aur
.ONESHELL:
%.aur: yay
	@if [ -z "`pacman -Qs | grep $(basename $@ .pkg)`" ]; then
		yay -S --noconfirm $(basename $@ .pkg)
	else
		echo "$(basename $@ .pkg)already installed."
	fi

.PHONY: yay
yay: /usr/bin/yay

.ONESHELL:
/usr/bin/yay:
	@$(eval NAME = yay)
	cd /tmp
	wget https://aur.archlinux.org/cgit/aur.git/snapshot/$(NAME).tar.gz
	tar -xf /tmp/$(NAME).tar.gz
	cd /tmp/$(NAME)
	makepkg -s
	sudo pacman -U --noconfirm $(NAME)*.pkg.*
