STOW = stow -t $HOME

DOTS = Dotfiles

.PHONY: tiling
tiling: bspwm base apps

.PHONY: base
base: tmux neovim fish

.PHONY: apps
apps: newsbeuter

# BASE PROGRAMS

.PHONY: tmux
tmux:
	$(STOW) $(DOTS)/tmux
	./Install/pluginstall.sh

.PHONY: neovim
neovim:
	$(STOW) $(DOTS)/neovim

.PHONY: fish
fish:
	$(STOW) $(DOTS)/fish
	curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
	fish --command fisher edc/bass

# DESKTOPS

.PHONY: bspwm
bspwm:
	$(STOW) $(DOTS)/bspwm

# APPS

.PHONY: newsbeuter
newsbeuter:
	$(STOW) $(DOTS)/newsbeuter
