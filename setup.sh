#!/bin/bash -x

OS=undefined
if [ `uname` == 'Darwin' ]; then
  OS=Mac
elif [ `uname -s` == 'Linux' ]; then
  OS=Linux # TODO Ubuntu, CentOS
fi

echo $OS

if [ $OS == 'Mac' ]; then
	# Mac OS

	# Finder
        defaults write com.apple.finder AppleShowAllFiles TRUE
	# killall Finder

	# Check Homebrew
	if [ ! `which brew`]; then
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
		eval "$(/opt/homebrew/bin/brew shellenv)"
		brew -v || (echo "Failed to install brew." && exit 1)
	fi

	brew doctor

	# tmux
	if [ ! `which tmux`]; then
		brew install tmux
	fi


	brew install bash-completion

	git reattach-to-user-namespace fzf gnu-sed

	# font
	brew tap sanemat/font
	brew install ricty
	cp -f /usr/local/opt/ricty/share/fonts/Ricty*.ttf ~/Library/Fonts
	fc-cache -vf

	brew install bat tree cmake gnu-sed ctags vim asdf

	# GUI
  brew install --cask karabiner-elements google-chrome

elif [ $OS == 'Linux' ]; then
	apt update
	apt upgrade
	apt install bash-completion
	apt install git
	apt install fzf xclip
	apt install tmux tmuxinator
	apt install bat tree cmake
	apt install vim-gtk3
else
	echo "unknown OS"
	exit 2
fi


## asdf
asdf plugin add nodejs
asdf plugin add ruby
asdf plugin add golang

## Vim plugin
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

## git
curl -o ~/.git-completion.sh \
    https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
curl -o ~/.git-prompt.sh \
    https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh

chmod +x ~/.git-completion.sh
chmod +x ~/.git-prompt.sh

# alias
# ln -s ~/dotfiles/bash_profile ~/.bash_profile
# ln -s ~/dotfiles/bash_alias ~/.bash_alias
# ln -s ~/dotfiles/gitignore_global ~/.gitignore_global
# ln -s ~/dotfiles/ideavimrc ~/.ideavimrc
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
# ln -s ~/dotfiles/tmux.conf.macos ~/.tmux.conf.macos
# ln -s ~/dotfiles/tmux.conf.ubuntu ~/.tmux.conf.ubuntu
ln -s ~/dotfiles/vimrc ~/.vimrc
# ln -s ~/dotfiles/eslintrc.json ~/.eslintrc.json
# ln -s ~/dotfiles/ocamlinit ~/.ocamlinit
cp -r ~/dotfiles/vim ~/.vim
cp -r ~/dotfiles/tmux ~/.tmux
# touch ~/.bash_env

# tmux-plugins
# git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
