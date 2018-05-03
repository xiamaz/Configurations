function su
    /bin/su --shell=/usr/bin/fish $argv
end

function lessjson
    python -m json.tool $argv[1] | less
end

complete -c lessjson -a '(__fish_complete_suffix json)'

set fish_greeting
fish_vi_key_bindings

# aliases for python virtualenvs
alias pmk 'python3 -m venv env'
alias pa '. env/bin/activate.fish'
alias pdep 'pip install -r requirements.txt'
alias pd 'deactivate'
alias home 'mosh home -- tmux -q has-session && tmux attach || tmux new-session'

# completion for fish
complete -c pacman -n "__fish_contains_opt -s U upgrade" -xa '(__fish_complete_suffix pkg.tar)' -d 'Package file'

set -x -U GOPATH $HOME/go
set -x PATH $GOPATH/bin $PATH
