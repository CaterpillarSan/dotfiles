#bashrc

set -o vi

# エイリアスの設定
# ls（カラー表示）
alias ls='ls -GF'
alias ll='ls -lGF'
alias la='ls -laGF'
alias sed='gsed'
alias which='type -a'

cd () {
	builtin cd "$@" && ls
}

# git
alias git-dbranch='git branch --merged | grep -v '*' | xargs -I % git branch -d %'


alias kube='kubectl'
alias bx='bundle exec'
alias ocaml="rlwrap ocaml"

# bashの表示のやつ
GIT_PS1_SHOWDIRTYSTATE=true
export PS1='\e[32m\][\w] \e[31m\]$(__git_ps1 [%s]) \e[36m\]\n( ＾∀＾) \[\e[0m\] \$ '
export LSCOLORS=gxfxcxdxbxegedabagacad

# env
eval "$(anyenv init -)"

# PATHまわり
export PATH=/usr/local/bin:$PATH
export GOPATH=$HOME/go
export GOBIN=$HOME/go/bin
export NODEBREW_ROOT=/usr/local/var/nodebrew
export PATH="/usr/local/opt/avr-gcc@7/bin:$PATH"
export PATH=$(go env GOPATH)/bin:$PATH
export PATH=/usr/local/opt/openssl/bin:$PATH
export PATH=/usr/local/var/nodebrew/current/bin:$PATH
export PATH=/Library/Frameworks/Python.framework/Versions/2.7.14_2/bin:$PATH
export PATH=/usr/local/Cellar/git/2.19.0_2/bin:$PATH
# export PATH=$HOME/.rbenv/shims:$PATH
export PATH=$HOME/wabt/out/clang/Debug:$PATH
# 警告が邪魔
export BASH_SILENCE_DEPRECATION_WARNING=1

# tmuxinator
export EDITOR='vim'
export SHELL=/bin/bash
