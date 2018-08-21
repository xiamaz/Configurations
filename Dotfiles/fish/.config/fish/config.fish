function su
    /bin/su --shell=/usr/bin/fish $argv
end

function lessjson
    python -m json.tool $argv[1] | less
end

# remove a git branch and propagate to remote origin
function rmbranch
	git branch -d $argv[1]
	git push origin :$argv[1]
end

# push the current git branch to origin
function pushbranch
	git push --set-upstream origin (git rev-parse --abbrev-ref HEAD)
end

function mkaur
	git clone https://aur.archlinux.org/$argv[1].git
end

# connect to vpn using ovpn
function vpn
	switch (string lower $argv[1])
	case ls
		/bin/ls -1 ~/Nextcloud/VPN
	case mll
		sh -c 'cd ~/Nextcloud/VPN/MLL; sudo openvpn mll_mzhao.ovpn'
	case '*'
		echo "Unknown option. Usage: ls|<vpn names>"
	end
end


complete -c lessjson -a '(__fish_complete_suffix json)'

set fish_greeting

# aliases for python virtualenvs
alias pa '. env/bin/activate.fish'
alias pmk 'python3 -m venv env; and pa'
alias pmks 'python3 -m venv env --system-site-packages; and pa'
alias pdep 'pip install -r requirements.txt'
alias pd 'deactivate'

# completion for fish
complete -c yay -n "__fish_contains_opt -s U upgrade" -xa '(__fish_complete_suffix pkg.tar)' -d 'Package file'
# also accept non compressed packages for local installation
complete --exclusive --command pacman --description 'Package file' --arguments '(__fish_complete_suffix pkg.tar)' --condition '__fish_contains_opt -s U upgrade'

set -x -U GOPATH $HOME/go
set -x PATH $GOPATH/bin $PATH

set -x FZF_LEGACY_KEYBINDINGS 0
set -x VIRTUAL_ENV_DISABLE_PROMPT 1
