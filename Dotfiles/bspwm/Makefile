TARGET = $(HOME)
SOURCE = .

.PHONY: bspwm
bspwm: bspwm.stow bspwm.hoststow dependencies

.PHONY: dependencies
dependencies: bspwm.pkg sxhkd.pkg nitrogen.pkg autorandr.aur \
	lxqt-policykit.pkg xfce4-clipman-plugin.pkg i3lock-color-git.aur \
	wmctrl.pkg

.PHONY: polybar
polybar: polybar.pkg fonts

.PHONY: fonts
fonts: otf-font-awesome.pkg ttf-material-design-icons.aur \
	termsyn-font.aur bdf-unifont.pkg \

include $(BASEDIR)/packaging.mk $(BASEDIR)/stow.mk
