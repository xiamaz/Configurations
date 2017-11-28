#!/bin/sh
HOMEUSER='pedia'

if [ "$(id -u)" -ne 0 ]; then
    echo "Please run this script as root."
    exit
fi
. /etc/os-release

# install essential packages
case $NAME in
	"Debian GNU/Linux")
		echo "Debian System detected"
		DEBIAN_FRONTEND=noninteractive
		apt update -y
		apt-get -o Dpkg::Options::="--force-confnew" -fuy dist-upgrade
		INSTALL_COMMAND='apt -o Dpkg::Options::="--force-confnew" -fuy install'
		;;
	"Arch Linux")
		echo "Archlinux detected"
		pacman -Syu --noconfirm
		INSTALL_COMMAND='pacman -S --noconfirm'
		;;
	*)
		echo "Currently not supported"
		exit
		;;
esac


$INSTALL_COMMAND sudo
$INSTALL_COMMAND curl
$INSTALL_COMMAND neovim
$INSTALL_COMMAND tmux
$INSTALL_COMMAND python3
$INSTALL_COMMAND git
$INSTALL_COMMAND fish

# setup new user
useradd -m $HOMEUSER
case $NAME in
	"Debian GNU/Linux")
		gpasswd -a $HOMEUSER sudo
		;;
	"Arch Linux")
		echo 'wheel ALL=(ALL) ALL' | sudo EDITOR='tee -a' visudo
		gpasswd -a $HOMEUSER wheel
		;;
	*)
		;;
esac

su $HOMEUSER -c "fish setup_env.fish"
