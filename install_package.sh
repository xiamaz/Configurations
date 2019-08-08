#!/bin/sh
# Handle installation of package dependencies
# Do it using very stupid name resolution first

check_brew() {
	if command -v brew; then
		return
	fi
	# Install brew using terrible script curling
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

	if ! command -v jq; then
		brew install jq
	fi
}

check_yay() {
	if command -v yay; then
		return
	fi
	cd /tmp
	wget https://aur.archlinux.org/cgit/aur.git/snapshot/yay.tar.gz
	tar -xf /tmp/yay.tar.gz
	cd /tmp/yay
	makepkg -s
	sudo pacman -U --noconfirm yay*.pkg.*

	if ! command -v jq; then
		sudo pacman -S jq
	fi
}

pkg_method() {
	jq -r ".$2.$1" <packages.json
}

install_mac() {
	check_brew
	install_cmd=$(pkg_method "Darwin" $1)
	if [ "$install_cmd" = "null" ]; then
		echo "$1 not found in packages.json. Try default brew install"
		brew install $1
	else
		eval $install_cmd
	fi
}

install_archlinux() {
	check_yay
	install_cmd=$(pkg_method "Archlinux" $1)
}

pkg_name=$1

if [ $# -ne 1 ]; then
	echo "Usage: $0 pkg-name"
	exit
fi


case $(uname -s) in
Darwin)
	install_mac $pkg_name
	;;
Linux)
	if [ -n `grep archlinux /etc/os-release` ]; then
		install_archlinux $pkg_name
	fi
	;;
*)
	echo "Unrecognized"
	;;
esac
