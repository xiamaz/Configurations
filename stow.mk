TARGET ?= $(HOME)
SOURCE ?= $(DOTS)

STOW = stow -t $(TARGET) -d $(SOURCE)

# stow utilities
.PHONY: %.stow
%.stow: stow.pkg
	$(STOW) $(basename $@ .stow)

.PHONY: %.hoststow
.ONESHELL:
%.hoststow: stow.pkg
	@if [ -d "$(SOURCE)/$$(basename $@ .hoststow)@$(HOST)" ]; then
		$(STOW) $$(basename $@ .hoststow)@$(HOST)
	else
		$(STOW) $$(basename $@ .hoststow)@default
		echo "Using default config. Consider creating host-specific config."
	fi

