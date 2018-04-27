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
