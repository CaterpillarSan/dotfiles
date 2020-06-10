# bash_profile

if [ -f ~/.bashrc ] ; then
. ~/.bashrc
fi

if [ -f ~/.bash_env ] ; then
. ~/.bash_env
fi


if [[ ! -n $TMUX ]] && [[ $VSCODE_PID == "" ]] ; then
  # get the IDs
  ID="`tmux list-sessions`"
  if [[ -z "$ID" ]]; then
    tmux new-session
  fi
  new="new"
  ID="$new:
$ID"
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

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
  # kubectl shell completion
  if [ -f ~/.kube/completion.bash.inc ]; then
   source ~/.kube/completion.bash.inc
  fi
fi
