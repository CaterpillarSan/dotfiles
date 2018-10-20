#!/bin/bash -x

# Check Homebrew
if [ ! `which brew`]; then
	echo "please install Homebrew"
	exit 1
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

# Vim with lua
brew install vim --with-lua --with-override-system-vi

## Neobundle
git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim

# alias
ln -s ~/dotfiles/.bash_profile ~/.bash_profile
ln -s ~/dotfiles/.bashrc ~/.bashrc
ln -s ~/dotfiles/.gitignore_global ~/.gitignore_global
ln -s ~/dotfiles/.ideavimrc ~/.ideavimrc
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/.vimrc ~/.vimrc
cp -r ~/dotfiles/.vim ~/.vim
