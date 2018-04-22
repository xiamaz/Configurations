function su
    /bin/su --shell=/usr/bin/fish $argv
end

# aliases for python virtualenvs
alias pmk 'python3 -m venv env'
alias pa '. env/bin/activate.fish'
alias pdep 'pip install -r requirements.txt'
alias pd 'deactivate'

# completion for fish
complete -c pacman -n "__fish_contains_opt -s U upgrade" -xa '(__fish_complete_suffix pkg.tar)' -d 'Package file'

set -x -U GOPATH $HOME/go
set -x PATH $GOPATH/bin $PATH

if test -e ~/.config/fish/local.fish
	. ~/.config/fish/local.fish
end
