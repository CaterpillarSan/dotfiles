# bash_profile

if [ -f ~/.bashrc ] ; then
. ~/.bashrc
fi

if [ -f ~/.bash_env ] ; then
. ~/.bash_env
fi

if [ -f ~/.bash_aliases ]; then
. ~/.bash_aliases
fi


if [[ ! -n $TMUX ]] && [[ ! $TERM_PROGRAM == "vscode" ]] ; then
  # get the IDs
  ID="`tmux list-sessions`"
  if [[ -z "$ID" ]]; then
    tmux new-session
  fi
  new="new"
  ID="$new:$ID"
  ID="`echo "$ID" | fzf | cut -d: -f1`"
  echo "$ID"
  if [[ $ID = $new ]]; then
    tmux new-session
  elif [[ -n "$ID" ]]; then
    tmux attach-session -t "$ID" -d
  else
    :  # Start terminal normally
  fi
fi

if `which brew`; then
	if [ -f $(brew --prefix)/etc/bash_completion ]; then
	  . $(brew --prefix)/etc/bash_completion
	fi
else
	if [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi

# kubectl shell completion
 if [ -f ~/.kube/completion.bash.inc ]; then
   source ~/.kube/completion.bash.inc
 fi

set -o vi

# bashの表示のやつ
GIT_PS1_SHOWDIRTYSTATE=true
export PS1='\e[32m\][\w] \e[31m\]$(__git_ps1 [%s]) \e[36m\]\n( ＾∀＾) \[\e[0m\] \$ '
export LSCOLORS=gxfxcxdxbxegedabagacad

# env
if `which anyenv`; then
	eval "$(anyenv init -)"
fi

# PATHまわり
export PATH=/usr/local/bin:$PATH

if `which go`; then
	export GOPATH=$HOME/go
	export GOBIN=$HOME/go/bin
	export PATH=$(go env GOPATH)/bin:$PATH
fi
export NODEBREW_ROOT=/usr/local/var/nodebrew
export PATH="/usr/local/opt/avr-gcc@7/bin:$PATH"
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
