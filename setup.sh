#!/bin/bash -x

# Check Homebrew
if [ ! `which brew`]; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
	brew -v || (echo "Failed to install brew." && exit 1)
fi

brew doctor

# tmux
if [ ! `which tmux`]; then
	brew install tmux
fi


# Bash completion
brew install bash-completion
brew install git
brew install reattach-to-user-namespace
brew install fzf
brew install gnu-sed
brew install tmuxinator
# font
brew tap sanemat/font
brew install ricty
cp -f /usr/local/opt/ricty/share/fonts/Ricty*.ttf ~/Library/Fonts
fc-cache -vf


# Vim with lua
brew install vim --with-lua --with-override-system-vi

## Neobundle
git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim

# alias
ln -s ~/dotfiles/bash_profile ~/.bash_profile
ln -s ~/dotfiles/bashrc ~/.bashrc
ln -s ~/dotfiles/gitignore_global ~/.gitignore_global
ln -s ~/dotfiles/ideavimrc ~/.ideavimrc
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/vimrc ~/.vimrc
ln -s ~/dotfiles/eslintrc.json ~/.eslintrc.json
ln -s ~/dotfiles/ocamlinit ~/.ocamlinit
cp -r ~/dotfiles/vim ~/.vim
cp -r ~/dotfiles/tmux ~/.tmux

# tmux-plugins

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm


# benri softs
brew install bat tree cmake gnu-sed ctags

# ssh TODO 
mkdir ~/.ssh
touch ~/.ssh/config
chmod 700 ~/.ssh
chmod 600 ~/.ssh/*
