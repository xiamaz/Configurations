#!/bin/sh
# Handle installation of package dependencies
# Do it using very stupid name resolution first

# Install package manager for archaur
install_manual_archaur() {
	name="$1"
	cd /tmp
	wget https://aur.archlinux.org/cgit/aur.git/snapshot/${name}.tar.gz
	tar -xf /tmp/${name}.tar.gz
	cd /tmp/${name}
	makepkg -s
	sudo pacman -U --noconfirm ${name}*.pkg.*
}

# Install package by name using both official and aur packages
install_package_archaur() {
	pkgname="$1"
	manager="yay"
	if ! command -v $manager > /dev/null; then
		install_manual_archaur $manager
	fi
	if [ -z "`pacman -Qs | grep $pkgname`" ]; then
		$manager -S --noconfirm $pkgname
	else
		echo "$pkgname already installed."
	fi
}

# Install debian packages from official sources
install_package_debian() {
	pkgnames=$1
	manager="apt-get"
	if ! command -v $manager > /dev/null; then
		echo "$manager not installed. Giving up."
		return
	fi
	sudo $manager -y install $pkgname
}

# Translate package names
translate_names() {
	prog="$1"
	case $prog in
	tmux)
		;;
	*)
		echo "Unknown program metaname $prog"
		;;
	esac
}
