# package management
.PHONY: %.pkg
.ONESHELL:
%.pkg:
	@if [ -n "`grep archlinux /etc/os-release`" ]; then
		if [ -z "`pacman -Qs | grep $(basename $@ .pkg)`" ]; then
			sudo pacman -S --noconfirm $(basename $@ .pkg)
		else
			echo "$(basename $@ .pkg)already installed."
		fi
	else
		echo "Not archlinux. Not managing package installation."
	fi

.PHONY: %.aur
.ONESHELL:
%.aur: yay
	@if [ -n "`grep archlinux /etc/os-release`" ]; then
		if [ -z "`pacman -Qs | grep $(basename $@ .pkg)`" ]; then
			yay -S --noconfirm $(basename $@ .pkg)
		else
			echo "$(basename $@ .pkg)already installed."
		fi
	else
		echo "Not archlinux. Not managing package installation."
	fi

.PHONY: yay
yay: /usr/bin/yay

.ONESHELL:
/usr/bin/yay:
	@$(eval NAME = yay)
	if [ -n "`grep archlinux /etc/os-release`" ]; then
		cd /tmp
		wget https://aur.archlinux.org/cgit/aur.git/snapshot/$(NAME).tar.gz
		tar -xf /tmp/$(NAME).tar.gz
		cd /tmp/$(NAME)
		makepkg -s
		sudo pacman -U --noconfirm $(NAME)*.pkg.*
	else
		echo "Not archlinux. Not managing package installation."
	fi
