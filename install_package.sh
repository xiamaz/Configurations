#!/bin/sh
# Handle installation of package dependencies
# Do it using very stupid name resolution first

pkg_method() {
	jq -r ".\"$2\".\"$1\"" <packages.json
}

install_mac() {
	install_cmd=$(pkg_method "Darwin" $1)
	if [ "$install_cmd" = "null" ]; then
		echo "$1 not found in packages.json. Try default brew install"
		brew install $1
	else
		eval $install_cmd
	fi
}

install_archlinux() {
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
