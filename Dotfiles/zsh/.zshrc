# turn off the infernal correctall for filenames
unsetopt correctall

source "${HOME}/.zgen/zgen.zsh"
if ! zgen saved; then
	zgen load zsh-users/zsh-syntax-highlighting
	zgen load zsh-users/zsh-history-substring-search
	zgen load zsh-users/zsh-autosuggestions

	zgen load zsh-users/zsh-completions src

	zgen load Tarrasch/zsh-autoenv

	# theme
	zgen load mafredri/zsh-async
	zgen load sindresorhus/pure

	zgen save
fi

# set some history options
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt hist_verify
setopt share_history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"

setopt extendedglob nomatch notify
unsetopt autocd beep
bindkey -e

# Speed up autocomplete, force prefix mapping
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)*==34=34}:${(s.:.)LS_COLORS}")';

## OS dependent settings
case "$(uname -s)" in
	Linux*)
		alias ls='ls --color'
		export PURE_PROMPT_SYMBOL=">"
		export PURE_PROMPT_VICMD_SYMBOL="<"
		export PURE_GIT_UP_ARROW="↑"
		export PURE_GIT_DOWN_ARROW="↓"
		;;
	Darwin*)
		export CLICOLOR=1
		alias mosh='LC_ALL=en_US.UTF-8 mosh'
		;;
esac

## Keybindings
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

## Conda configuration
condaprofile="etc/profile.d/conda.sh"

_conda_aliases() {
	alias pl='conda info --envs'
	alias pa='conda activate'
	alias pd='conda deactivate'
}
if [ -d $HOME/miniconda3 ]; then
	. $HOME/miniconda3/$condaprofile
	_conda_aliases
elif [ -d /usr/local/miniconda3 ]; then
	. /usr/local/miniconda3/etc/profile.d/conda.sh
	_conda_aliases
fi
