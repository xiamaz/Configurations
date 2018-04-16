DOTS = Dotfiles
STOW = stow -t $(HOME) -d $(DOTS)

.PHONY: tiling
tiling: bspwm base apps

.PHONY: base
base: tmux neovim fish

.PHONY: apps
apps: newsbeuter

# BASE PROGRAMS

.PHONY: tmux
tmux:
	$(STOW) tmux
	./Install/pluginstall.sh

.PHONY: neovim
neovim:
	$(STOW) neovim

.PHONY: fish
fish:
	$(STOW) fish
	curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
	fish --command fisher edc/bass

# DESKTOPS

.PHONY: bspwm
bspwm:
	$(STOW) bspwm

# APPS

.PHONY: newsbeuter
newsbeuter:
	$(STOW) newsbeuter
