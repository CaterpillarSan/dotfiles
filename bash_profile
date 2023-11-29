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

if which brew > /dev/null; then
	if [ -f $(brew --prefix)/etc/bash_completion ]; then
	  . $(brew --prefix)/etc/bash_completion
	fi
else
	if [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi
if [ -f ~/git-completion.bash ]; then
    source ~/git-completion.bash
fi
if [ -f ~/git-prompt.sh ]; then
    source ~/git-prompt.sh
fi

# kubectl shell completion
 if [ -f ~/.kube/completion.bash.inc ]; then
   source ~/.kube/completion.bash.inc
 fi

 if [ -f ~/view-saml-role.sh ]; then
   source ~/view-saml-role.sh
else
	__saml_ps1() {
		echo ''
	}
 fi

set -o vi

# bashの表示のやつ
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUPSTREAM=auto
export PS1='\e[32m\][\w] \e[31m\]$(__git_ps1 [%s]) \e[33m\]$(__saml_ps1 [%s]) \e[36m\]\n\D{%y/%m/%d %H:%M:%S} ( ＾∀＾) \[\e[0m\] \$  '
export LSCOLORS=gxfxcxdxbxegedabagacad

if which direnv > /dev/null; then
	eval "$(direnv hook bash)"
fi

# PATHまわり
export PATH=/usr/local/bin:$PATH

export PATH="/usr/local/opt/avr-gcc@7/bin:$PATH"
export PATH=/usr/local/opt/openssl/bin:$PATH
export PATH=/Library/Frameworks/Python.framework/Versions/2.7.14_2/bin:$PATH
export PATH=/usr/local/Cellar/git/2.19.0_2/bin:$PATH
export PATH=$HOME/wabt/out/clang/Debug:$PATH
export PATH="$GOROOT/bin:$PATH"


# 警告が邪魔
export BASH_SILENCE_DEPRECATION_WARNING=1

# tmuxinator
export EDITOR='vim'
export SHELL=/bin/bash

cdls ()
{
    \cd "$@" && ls
}
alias cd="cdls"

alias ls="ls -G"
alias ll="ls -l"
alias la="ls -a"


. /usr/local/opt/asdf/libexec/asdf.sh
. /usr/local/opt/asdf/etc/bash_completion.d/asdf.bash
