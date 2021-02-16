#!/bin/bash -x

if [ $1 = 'macos' ]; then
	# Mac OS

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

	brew install bat tree cmake gnu-sed ctags

	# Vim with lua
	brew install vim --with-lua --with-override-system-vi
elif [ $1 = "ubuntu" ]; then
	apt update
	apt upgrade
	apt install bash-completion
	apt install git
	apt install fzf xclip
	apt install tmux tmuxinator
	apt install bat tree cmake
	apt install vim-gtk3
else
	echo "please input your distributution. macos/ubuntu"
	exit 2
fi
## Neobundle
git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim

# alias
ln -s ~/dotfiles/bash_profile ~/.bash_profile
ln -s ~/dotfiles/bash_alias ~/.bash_alias
ln -s ~/dotfiles/gitignore_global ~/.gitignore_global
ln -s ~/dotfiles/ideavimrc ~/.ideavimrc
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/tmux.conf.macos ~/.tmux.conf.macos
ln -s ~/dotfiles/tmux.conf.ubuntu ~/.tmux.conf.ubuntu
ln -s ~/dotfiles/vimrc ~/.vimrc
ln -s ~/dotfiles/eslintrc.json ~/.eslintrc.json
ln -s ~/dotfiles/ocamlinit ~/.ocamlinit
cp -r ~/dotfiles/vim ~/.vim
cp -r ~/dotfiles/tmux ~/.tmux
touch ~/.bash_env

# tmux-plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
