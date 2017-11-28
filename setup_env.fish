#!/usr/bin/fish
echo (pwd)
# install fisher
curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher

fisher edc/bass

# setup neovim
mkdir -p $HOME/Git
cd $HOME/Git
git clone https://github.com/xiamaz/Configurations.git

ln -s $HOME/Git/Configurations/Vim/vim $HOME/.config/nvim
touch $HOME/.vimrc.local
cp $HOME/Git/Configurations/Dotfiles/tmux/tmux.conf $HOME/.tmux.conf
sh $HOME/Git/Configurations/Dotfiles/tmux/pluginstall.sh
