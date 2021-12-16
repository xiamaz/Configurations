# Configurations
Config files for various programs for more portability

## host specific configuration

Run `make $(hostname)` to install hostname specific components to the system.
This will require root permissions, as most components relate to hardware
features requiring setuid for ease-of-use.

## Bootstrap

```
$ wget https://raw.githubusercontent.com/xiamaz/Configurations/master/bootstrap.sh
$ bash bootstrap.sh
```

## Minimal Bootstrap

```
$ git clone --bare git@github.com:xiamaz/.dotfiles.git $HOME/.dotfiles.git
$ alias cgit="git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME"
$ cgit checkout
```

Resolve any issues pointed out and rerun the command.

Installing tpm for tmux

```
$ git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Remember to `Ctrl+a I` to install plugins while inside tmux.
