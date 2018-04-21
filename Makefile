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
	@fish --command fisher edc/bass

# DESKTOPS

.PHONY: bspwm
bspwm: bspwm.stow bspwm.hoststow bspwm.pkg sxhkd.pkg polybar.pkg nitrogen.pkg autorandr.aur

# APPS

.PHONY: newsboat
newsboat: newsboat.stow newsboat.pkg

.PHONY: st
st: ncurses
	@[ -z "`pacman -Qs | grep "/$@ 0.8.1"`" ] \
		&& (cd packages/$@; makepkg -s; sudo pacman -U --noconfirm $@*.pkg.tar*) \
		|| echo "$@ already installed."

.PHONY: ncurses
ncurses:
	@[ "`pacman -Qs | grep "/$@ 6.1-3"`" ] \
		&& (cd packages/$@; makepkg -s; sudo pacman -U --noconfirm $@*.pkg.tar*) \
		|| echo "$@ already current."

# stow utilities
.PHONY: %.stow
%.stow: stow.pkg
	$(STOW) $(basename $@ .stow)

.PHONY: %.hoststow
%.hoststow: stow.pkg
	@if [ -d "$(DOTS)/$$(basename $@ .hoststow)-$(HOST)" ]; then \
		$(STOW) $$(basename $@ .hoststow)-$(HOST); \
	else \
		$(STOW) $$(basename $@ .hoststow)-default; \
		echo "Using default config. Consider creating host-specific config."; \
	fi

# package management
.PHONY: %.pkg
%.pkg:
	@[ -z "`pacman -Qs | grep $(basename $@ .pkg)`" ] \
		&& sudo pacman -S --noconfirm $(basename $@ .pkg) \
		|| echo "$(basename $@ .pkg)already installed."

.PHONY: %.aur
%.aur: yay
	@[ -z "`pacman -Qs | grep $(basename $@ .pkg)`" ] \
		&& yay -S --noconfirm $(basename $@ .pkg) \
		|| echo "$(basename $@ .pkg)already installed."

.PHONY: yay
yay: /usr/bin/yay

/usr/bin/yay:
	$(eval NAME = yay)
	@cd /tmp; \
 		wget https://aur.archlinux.org/cgit/aur.git/snapshot/$(NAME).tar.gz; \
 		tar -xf /tmp/$(NAME).tar.gz; \
 		cd /tmp/$(NAME); \
 		makepkg -s; \
 		sudo pacman -U --noconfirm $(NAME)*.pkg.*
